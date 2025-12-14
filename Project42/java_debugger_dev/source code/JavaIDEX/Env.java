package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.StepRequest;
import com.sun.jdi.request.MethodEntryRequest;
import com.sun.jdi.request.MethodExitRequest;
import com.sun.tools.jdi.*;
import java.util.*;
import java.io.*;
import java.lang.*;


class Env {

    static PrintStream out = System.out;

    static EventRequestSpecList specList = new EventRequestSpecList();

    private static VMConnection connection;

    private static SourceMapper sourceMapper = new SourceMapper(".");
    private static List excludes;

    private static final int SOURCE_CACHE_SIZE = 5;
    private static List sourceCache = new LinkedList();

    private static HashMap savedValues = new HashMap();
    static void init(String connectSpec, boolean openNow, int flags) {
        connection = new VMConnection(connectSpec, flags);
        if (!connection.isLaunch() || openNow) {
        connection.open();
        }
    }

    static VMConnection connection() {
        return connection;
    }

    static VirtualMachine vm() {
        return connection.vm();
    }


    static void shutdown() {

        shutdown(null);

    }

    static void shutdown(String message) {
        if (connection != null) {
            try {
                connection.disposeVM();

            } catch (VMDisconnectedException e) {
                // Shutting down after the VM has gone away. This is
                // not an error, and we just ignore it.
            }
        }
        if (message != null) {
            noticeln(message);
        }
        System.exit(0);

      }

    static void fatalError(String msg) {
        System.err.println("Fatal error:");
        System.err.println(msg);
        shutdown();
    }

    static void error(String msg) {
        System.err.print(msg);
    }

    static void errorln(String msg) {
        System.err.println(msg);
    }

    static void notice(String msg) {
        System.out.print(msg);
    }

    static void noticeln(String msg) {
        System.out.println(msg);
    }

    static void printPrompt() {
        ThreadInfo tinfo = ThreadInfo.current;
        if (tinfo == null) {
            out.print("> ");
        } else {
            out.print(tinfo.thread.name() + "[" +
                      (tinfo.currentFrameIndex + 1) +
                      "] ");
        }
        out.flush();
    }

    static void setSourcePath(String srcpath) {
        sourceMapper = new SourceMapper(srcpath);
        sourceCache.clear();
    }

    static private List excludes() {
        if (excludes == null) {
            setExcludes("java.*, javax.*, sun.*, com.sun.*");
        }
        return excludes;
    }

    static String excludesString() {
        Iterator iter = excludes().iterator();
        StringBuffer buffer = new StringBuffer();
        while (iter.hasNext()) {
            String pattern = (String)iter.next();
            buffer.append(pattern);
            buffer.append(",");
        }
        return buffer.toString();
    }

    static void addExcludes(StepRequest request) {
        Iterator iter = excludes().iterator();
        while (iter.hasNext()) {
            String pattern = (String)iter.next();
            request.addClassExclusionFilter(pattern);
        }
    }

    static void addExcludes(MethodEntryRequest request) {
        Iterator iter = excludes().iterator();
        while (iter.hasNext()) {
            String pattern = (String)iter.next();
            request.addClassExclusionFilter(pattern);
        }
    }

    static void addExcludes(MethodExitRequest request) {
        Iterator iter = excludes().iterator();
        while (iter.hasNext()) {
            String pattern = (String)iter.next();
            request.addClassExclusionFilter(pattern);
        }
    }

    static void setExcludes(String excludeString) {
        StringTokenizer t = new StringTokenizer(excludeString, " ,;");
        List list = new ArrayList();
        while (t.hasMoreTokens()) {
            list.add(t.nextToken());
        }
        excludes = list;
    }

    /**
     * Return a Reader cooresponding to the source of this location.
     * Return null if not available.
     * Note: returned reader must be closed.
     */
    static BufferedReader sourceReader(Location location) {
        return sourceMapper.sourceReader(location);
    }

    static synchronized String sourceLine(Location location, int lineNumber)
                                          throws IOException {
        if (lineNumber == -1) {
            throw new IllegalArgumentException();
        }

        try {
            String fileName = location.sourceName();
    
            Iterator iter = sourceCache.iterator();
            SourceCode code = null;
            while (iter.hasNext()) {
                SourceCode candidate = (SourceCode)iter.next();
                if (candidate.fileName().equals(fileName)) {
                    code = candidate;
                    iter.remove();
                    break;
                }
            }
            if (code == null) {
                BufferedReader reader = sourceReader(location);
                if (reader == null) {
                    throw new FileNotFoundException(fileName);
                }
                code = new SourceCode(fileName, reader);
                if (sourceCache.size() == SOURCE_CACHE_SIZE) {
                    sourceCache.remove(sourceCache.size() - 1);
                }
            }
            sourceCache.add(0, code);
            return code.sourceLine(lineNumber);
        } catch (AbsentInformationException e) {
            throw new IllegalArgumentException();
        }
    }

    /**
     * Return the thread status description.
     */
    static String getStatus(ThreadReference thr) {
	int status = thr.status();
        String statusString;
        switch (status) {
          case ThreadReference.THREAD_STATUS_UNKNOWN:
            statusString = "unknown";
            break;
          case ThreadReference.THREAD_STATUS_ZOMBIE:
            statusString = "zombie";
            break;
          case ThreadReference.THREAD_STATUS_RUNNING:
            statusString = "running";
            break;
          case ThreadReference.THREAD_STATUS_SLEEPING:
            statusString = "sleeping";
            break;
          case ThreadReference.THREAD_STATUS_MONITOR:
            statusString = "waiting in a monitor";
            break;
          case ThreadReference.THREAD_STATUS_WAIT:
            statusString = "cond. waiting";
            break;
          default:
            throw new InternalError("invalid thread status");
        }
        if (thr.isAtBreakpoint()) {
            statusString += " (at breakpoint)";
        }
        return statusString;
    }

    /** Return a description of an object. */
    static String description(ObjectReference ref) {
        ReferenceType clazz = ref.referenceType();
        long id = ref.uniqueID();  
        if (clazz == null) {
            return toHex(id);
        } else {
            return "(" + clazz.name() + ")" + toHex(id);
        }
    }

    /** Convert a long to a hexadecimal string. */
    static String toHex(long n) {
	char s1[] = new char[16];
	char s2[] = new char[18];

	/* Store digits in reverse order. */
	int i = 0;
	do {
	    long d = n & 0xf;
	    s1[i++] = (char)((d < 10) ? ('0' + d) : ('a' + d - 10));
	} while ((n >>>= 4) > 0);

	/* Now reverse the array. */
	s2[0] = '0';
	s2[1] = 'x';
	int j = 2;
	while (--i >= 0) {
	    s2[j++] = s1[i];
	}
	return new String(s2, 0, j);
    }

    /** Convert hexadecimal strings to longs. */
    static long fromHex(String hexStr) {
	String str = hexStr.startsWith("0x") ?
	    hexStr.substring(2).toLowerCase() : hexStr.toLowerCase();
	if (hexStr.length() == 0) {
	    throw new NumberFormatException();
	}
	
	long ret = 0;
	for (int i = 0; i < str.length(); i++) {
	    int c = str.charAt(i);
	    if (c >= '0' && c <= '9') {
		ret = (ret * 16) + (c - '0');
	    } else if (c >= 'a' && c <= 'f') {
		ret = (ret * 16) + (c - 'a' + 10);
	    } else {
		throw new NumberFormatException();
	    }
	}
	return ret;
    }
    
    static ReferenceType getReferenceTypeFromToken(String idToken) {
        ReferenceType cls = null;
        if (Character.isDigit(idToken.charAt(0))) {
            cls = null;
        } else if (idToken.startsWith("*.")) {
        // This notation saves typing by letting the user omit leading
        // package names. The first 
        // loaded class whose name matches this limited regular
        // expression is selected.
        idToken = idToken.substring(1);
        List classes = Env.vm().allClasses();
        Iterator iter = classes.iterator();
        while (iter.hasNext()) {
            ReferenceType type = ((ReferenceType)iter.next());
            if (type.name().endsWith(idToken)) {
                cls = type;
                break;
            }
        }
    } else {
            // It's a class name
            List classes = Env.vm().classesByName(idToken);
            if (classes.size() > 0) {
                // TO DO: handle multiples
                cls = (ReferenceType)classes.get(0);
            }
        }
        return cls;
    }

    static Set getSaveKeys() {
        return savedValues.keySet();
    }

    static Value getSavedValue(String key) {
        return (Value)savedValues.get(key);
    }

    static void setSavedValue(String key, Value value) {
        savedValues.put(key, value);
    }

    static class SourceCode {
        private String fileName;
        private List sourceLines = new ArrayList();

        SourceCode(String fileName, BufferedReader reader)  throws IOException {
            this.fileName = fileName;
            try {
                String line = reader.readLine();
                while (line != null) {
                    sourceLines.add(line);
                    line = reader.readLine();
                }
            } finally {
                reader.close();
            }
        }

        String fileName() {
            return fileName;
        }

        String sourceLine(int number) {
            int index = number - 1; // list is 0-indexed
            if (index >= sourceLines.size()) {
                return null;
            } else {
                return (String)sourceLines.get(index);  
            }
        }
    }
}
