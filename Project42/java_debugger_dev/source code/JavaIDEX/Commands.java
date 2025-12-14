package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.*;
import com.sun.tools.example.debug.expr.ExpressionParser;
import com.sun.tools.example.debug.expr.ParseException;

import java.util.*;
import java.io.*;
import java.awt.Rectangle;

import javax.swing.*;
import javax.swing.event.*;
import javax.swing.filechooser.*;
import javax.swing.text.*;
import javax.swing.text.AttributeSet$CharacterAttribute;
import javax.swing.undo.*;

class Commands /*implements Runnable*/{

    PrintStream out;
    EditWin eWin;
    private String sourcePath = ".";
    Thread command = null;
    int oldj;
    final int line2Pixel = 17;

    Commands(PrintStream out, EditWin eWin) {
        this.out = out;
        this.eWin = eWin;
        }
    /*Commands(EditWin eWin) {
        command = new Thread(this);
        command.start();
    } */

    private Value evaluate(String expr) throws ParseException,
                                            InvocationException,
					    InvalidTypeException,
					    ClassNotLoadedException,
                                            IncompatibleThreadStateException,
                                            VMNotConnectedException {
        ExpressionParser.GetFrame frameGetter = null;
        final ThreadInfo tinfo = ThreadInfo.current;
        if (tinfo != null) {
            frameGetter = new ExpressionParser.GetFrame() {
                public StackFrame get() throws IncompatibleThreadStateException {
                    return tinfo.getCurrentFrame();
                }
            };
        }
        return ExpressionParser.evaluate(expr, Env.vm(), frameGetter);
    }

    ThreadInfo getThread(String idToken) {
        ThreadInfo tinfo = ThreadInfo.getThread(idToken);
        if (tinfo == null) {
            out.println("\"" + idToken + "\" is not a valid thread id.");
        }
        return tinfo;
    }

    String typedName(Method method) {
        StringBuffer buf = new StringBuffer();
        buf.append(method.name());
        buf.append("(");
        Iterator it = method.argumentTypeNames().iterator();
        while (it.hasNext()) {
            buf.append((String)it.next());
            if (it.hasNext()) {
                buf.append(",");
            }
        }
        buf.append(")");
        return buf.toString();
    }

    void commandClasses() {
        List list = Env.vm().allClasses();

        out.println("** classes list **");
        for (int i = 0 ; i < list.size() ; i++) {
            ReferenceType refType = (ReferenceType)list.get(i);
//            out.println(Env.description(refType));
            out.println(refType.name());
        }
    }

    void commandClass(StringTokenizer t) {
        List list = Env.vm().allClasses();

        if (!t.hasMoreTokens()) {
            out.println("No class specified.");
            return;
        }

        String idClass = t.nextToken();
        boolean showAll = false;

        if (t.hasMoreTokens()) {
            if (t.nextToken().toLowerCase().equals("all")) {
                showAll = true;
            } else {
                out.println("Invalid option on class command");
                return;
            }
        }
        ReferenceType type = Env.getReferenceTypeFromToken(idClass);
        if (type == null) {
            out.println("\"" + idClass +
                               "\" is not a valid id or class name.");
            return;
        }
        if (type instanceof ClassType) {
            ClassType clazz = (ClassType)type;
            out.println("Class: " + clazz.name());
            ClassType superclass = clazz.superclass();
            while (superclass != null) {
                out.println("extends: " + superclass.name());
                superclass = showAll ? superclass.superclass() : null;
            }
            List interfaces = showAll ? clazz.allInterfaces()
                                      : clazz.interfaces();
            Iterator iter = interfaces.iterator();
            while (iter.hasNext()) {
                InterfaceType interfaze = (InterfaceType)iter.next();
                out.println("implements: " + interfaze.name());
            }
            List subs = clazz.subclasses();
            iter = subs.iterator();
            while (iter.hasNext()) {
                ClassType sub = (ClassType)iter.next();
                out.println("subclass: " + sub.name());
            }
            List nested = clazz.nestedTypes();
            iter = nested.iterator();
            while (iter.hasNext()) {
                ReferenceType nest = (ReferenceType)iter.next();
                out.println("nested: " + nest.name());
            }
        } else if (type instanceof InterfaceType) {
            InterfaceType interfaze = (InterfaceType)type;
            out.println("Interface: " + interfaze.name());
            List supers = interfaze.superinterfaces();
            Iterator iter = supers.iterator();
            while (iter.hasNext()) {
                InterfaceType superinterface = (InterfaceType)iter.next();
                out.println("extends: " + superinterface.name());
            }
            List subs = interfaze.subinterfaces();
            iter = subs.iterator();
            while (iter.hasNext()) {
                InterfaceType sub = (InterfaceType)iter.next();
                out.println("subinterface: " + sub.name());
            }
            List implementors = interfaze.implementors();
            iter = implementors.iterator();
            while (iter.hasNext()) {
                ClassType implementor = (ClassType)iter.next();
                out.println("implementor: " + implementor.name());
            }
            List nested = interfaze.nestedTypes();
            iter = nested.iterator();
            while (iter.hasNext()) {
                ReferenceType nest = (ReferenceType)iter.next();
                out.println("nested: " + nest.name());
            }
        } else {  // array type
            ArrayType array = (ArrayType)type;
            out.println("Array: " + array.name());
        }
    }

    void commandMethods(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No class specified.");
            return;
        }

        String idClass = t.nextToken();
        ReferenceType cls = Env.getReferenceTypeFromToken(idClass);
        if (cls != null) {
            List methods = cls.allMethods();
            for (int i = 0; i < methods.size(); i++) {
                Method method = (Method)methods.get(i);
                out.print(method.declaringType().name() + " " +
                            method.name() + "(");
                Iterator it = method.argumentTypeNames().iterator();
                if (it.hasNext()) {
                    while (true) {
                        out.print((String)it.next());
                        if (!it.hasNext()) {
                            break;
                        }
                        out.print(", ");
                    }
                }
                out.println(")");
            }
        } else {
            out.println("\"" + idClass +
                               "\" is not a valid id or class name.");
        }
    }

    void commandFields(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No class specified.");
            return;
        }

        String idClass = t.nextToken();
        ReferenceType cls = Env.getReferenceTypeFromToken(idClass);
        if (cls != null) {
            List fields = cls.allFields();
            List visible = cls.visibleFields();
            for (int i = 0; i < fields.size(); i++) {
                Field field = (Field)fields.get(i);
                out.print(field.typeName() + " " +
                          field.name());
                if (!visible.contains(field)) {
                    out.println(" (hidden)");
                } else if (!field.declaringType().equals(cls)) {
                    out.println(" (inherited from " + field.declaringType().name() + ")");
                } else {
                    out.println();
                }
            }
        } else {
            out.println("\"" + idClass +
                               "\" is not a valid id or class name.");
        }
    }

    private int printThreadGroup(ThreadGroupReference tg, int iThread) {
        out.println("Group " + tg.name() + ":");
        List tlist = tg.threads();
        ThreadInfo[] all = ThreadInfo.threads();

        int maxId = 0;
        int maxName = 0;
        for (int i = 0 ; i < tlist.size() ; i++) {
            ThreadReference thr = (ThreadReference)tlist.get(i);
            int len = Env.description(thr).length();
            if (len > maxId)
                maxId = len;
            String name = thr.name();
            int iDot = name.lastIndexOf('.');
            if (iDot >= 0 && name.length() > iDot) {
                name = name.substring(iDot + 1);
            }
            if (name.length() > maxName)
                maxName = name.length();
        }

        String maxNumString = String.valueOf(all.length);
        int maxNumDigits = maxNumString.length();

        for (int i = 0 ; i < tlist.size() ; i++) {
            ThreadReference thr = (ThreadReference)tlist.get(i);
            int threadId = 0;
            for (int j = 0; j < all.length; j++) {
                if (all[j].thread.equals(thr)) {
                    threadId = j + 1;
                    break;
                }
            }

            char buf[] = new char[80];
            for (int j = 0; j < 79; j++) {
                buf[j] = ' ';
            }
            buf[79] = '\0';
            StringBuffer sbOut = new StringBuffer();
            sbOut.append(buf);

            // Right-justify the thread number at start of output string
            String numString = String.valueOf(threadId);
            sbOut.insert(maxNumDigits - numString.length(),
                         numString);
            sbOut.insert(maxNumDigits, ".");

            int iBuf = maxNumDigits + 2;
            sbOut.insert(iBuf, Env.description(thr));
            iBuf += maxId + 1;
            String name = thr.name();
            int iDot = name.lastIndexOf('.');
            if (iDot >= 0 && name.length() > iDot) {
                name = name.substring(iDot + 1);
            }
            sbOut.insert(iBuf, name);
            iBuf += maxName + 1;
            sbOut.insert(iBuf, Env.getStatus(thr));
            sbOut.setLength(79);
            out.println(sbOut.toString());
        }

        List tglist = tg.threadGroups();
        for (int ig = 0; ig < tglist.size(); ig++) {
            ThreadGroupReference tg0 = (ThreadGroupReference)tglist.get(ig);
            if (!tg.equals(tg0)) { 
                iThread += printThreadGroup(tg0, iThread + tlist.size());
            }
        }
        return tlist.size();
    }

    void commandThreads(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            printThreadGroup(ThreadInfo.group(), 0);
            return;
        }
        String name = t.nextToken();
        ThreadGroupReference tg = ThreadGroupIterator.find(name);
        if (tg == null) {
            out.println(name + " is not a valid threadgroup name.");
        } else {
            printThreadGroup(tg, 0);
        }
    }

    void commandThreadGroups() {
        ThreadGroupIterator it = new ThreadGroupIterator();
        int cnt = 0;
        while (it.hasNext()) {
            ThreadGroupReference tg = it.nextThreadGroup();
            ++cnt;
            out.println("" + cnt + ". " + Env.description(tg) + 
                        " " + tg.name());
        }
    }
    
    void commandThread(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("Thread number not specified.");
            return;
        }
        ThreadInfo tinfo = getThread(t.nextToken());
        if (tinfo != null) {
            ThreadInfo.current = tinfo;
        }
    }
    
    void commandThreadGroup(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("Threadgroup name not specified.");
            return;
        }
        String name = t.nextToken();
        ThreadGroupReference tg = ThreadGroupIterator.find(name);
        if (tg == null) {
            out.println(name + " is not a valid threadgroup name.");
        } else {
            ThreadInfo.setThreadGroup(tg);
        }
    }
    
    void commandRun(StringTokenizer t) {
        /*
         * The 'run' command makes little sense in a 
         * that doesn't support restarts or multiple VMs. However,
         * this is an attempt to emulate the behavior of the old
         * JDB as much as possible. For new users and implementations
         * it is much more straightforward to launch immedidately
         * with the -launch option.
         */
        VMConnection connection = Env.connection();
        if (!connection.isLaunch()) {
            if (!t.hasMoreTokens()) {
                commandCont();
            } else {
                out.println("'run <args>' command valid only with launched VMs");
            }
            return;
        } 
        if (connection.isOpen()) {
            out.println("VM already running. Use 'cont' to continue after events.");
            return;
        }

        /*
         * Set the main class and any arguments. Note that this will work
         * only with the standard launcher, "com.sun.jdi.CommandLineLauncher"
         */
        String args;
        if (t.hasMoreTokens()) {
            args = t.nextToken("");
            boolean argsSet = connection.setConnectorArg("main", args);
            if (!argsSet) {
                out.println("Unable to set main class and arguments");
                return;
            } 
        } else {
            args = connection.connectorArg("main");
            if (args.length() == 0) {
                out.println("Main class and arguments must be specified");
                return;
            }
        }
        out.println("run " + args);

        /*
         * Launch the VM.
         */
        connection.open();
        
    }

    void commandLoad(StringTokenizer t) {
        out.println("The 'load' command is no longer supported.");
    }

    void commandSuspend(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            ThreadIterator ti = ThreadInfo.threadIterator();
            while (ti.hasNext()) {
                ti.nextThread().suspend();
            }
            out.println("All (non-system) threads suspended.");
        } else {
            while (t.hasMoreTokens()) {
                ThreadInfo tinfo = getThread(t.nextToken());
                if (tinfo != null) {
                    tinfo.thread.suspend();
                }                
            }
        }
    }

    void commandResume(StringTokenizer t) {
         if (!t.hasMoreTokens()) {
            ThreadIterator ti = ThreadInfo.threadIterator();
            while (ti.hasNext()) {
                ti.nextThread().resume();
            }
            ThreadInfo.invalidateAll();
             out.println("All threads resumed.");
         } else {
             while (t.hasMoreTokens()) {
                ThreadInfo tinfo = getThread(t.nextToken());
                if (tinfo != null) {
                    tinfo.thread.resume();
                    tinfo.invalidate();
                }
            }
        }
    }

    void commandCont() {
        if (ThreadInfo.current == null) {
            out.println("Nothing suspended.");
            return;
        }
        Env.vm().resume();
    }

      void clearPreviousStep(ThreadReference thread) {
        /*
         * A previous step may not have completed on this thread; 
         * if so, it gets removed here. 
         */
         EventRequestManager mgr = Env.vm().eventRequestManager();
         List requests = mgr.stepRequests();
         Iterator iter = requests.iterator();
         while (iter.hasNext()) {
             StepRequest request = (StepRequest)iter.next();
             if (request.thread().equals(thread)) {
                 mgr.deleteEventRequest(request);
                 break;
             }
         }
    }
    /* step
     *
     */
    void commandStep(StringTokenizer t) {
        if (ThreadInfo.current == null) {
            out.println("Nothing suspended.");
            return;
        }
        int depth;
        if (t.hasMoreTokens() &&
                  t.nextToken().toLowerCase().equals("up")) {
            depth = StepRequest.STEP_OUT;
        } else {
            depth = StepRequest.STEP_INTO;
        }

        clearPreviousStep(ThreadInfo.current.thread);
        EventRequestManager reqMgr = Env.vm().eventRequestManager();
        StepRequest request = reqMgr.createStepRequest(
                                     ThreadInfo.current.thread,
                                     StepRequest.STEP_LINE, depth);
        if (depth == StepRequest.STEP_INTO) {
            Env.addExcludes(request);
        }
        // We want just the next step event and no others
        request.addCountFilter(1);
        request.enable();
        Env.vm().resume();
    }

    /* stepi
     * step instruction.
     */
    void commandStepi() {
        if (ThreadInfo.current == null) {
            out.println("Nothing suspended.");
            return;
        }
        clearPreviousStep(ThreadInfo.current.thread);
        EventRequestManager reqMgr = Env.vm().eventRequestManager();
        StepRequest request = reqMgr.createStepRequest(
                                     ThreadInfo.current.thread,
                                     StepRequest.STEP_MIN,
                                     StepRequest.STEP_INTO);
        Env.addExcludes(request);
        // We want just the next step event and no others
        request.addCountFilter(1);
        request.enable();
        Env.vm().resume();
    }

    void commandNext() {
        if (ThreadInfo.current == null) {
            out.println("Nothing suspended.");
            return;
        }
        clearPreviousStep(ThreadInfo.current.thread);
        EventRequestManager reqMgr = Env.vm().eventRequestManager();
        StepRequest request = reqMgr.createStepRequest(
                                     ThreadInfo.current.thread,
                                     StepRequest.STEP_LINE,
                                     StepRequest.STEP_OVER);
        Env.addExcludes(request);
        // We want just the next step event and no others
        request.addCountFilter(1);
        request.enable();
        Env.vm().resume();
    }

    void doKill(ThreadReference thread, StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No exception object specified.");
            return;
        }
        String expr = t.nextToken("");
        Value val = null;
        try {
            val = evaluate(expr);
        } catch (ParseException exc) {
            System.out.println(exc.getMessage());
        } catch (InvocationException ie) {
            System.out.println("Exception in expression: " +
                               ie.exception().referenceType().name());
        } catch (InvalidTypeException ite) {
            System.out.println(ite.getMessage());
        } catch (IncompatibleThreadStateException itse) {
            System.out.println(itse.getMessage());
        } catch (ClassNotLoadedException tnle) {
            System.out.println(tnle.getMessage());
        }

        if ((val != null) && (val instanceof ObjectReference)) {
            try {
                thread.stop((ObjectReference)val);
                out.println(thread.toString() + " killed");
            } catch (InvalidTypeException e) {
                out.println("Invalid exception object");
            }
        } else {
            out.println("Expression must evaluate to an object");
        }
    }

    void doKillThread(ThreadReference ttk, StringTokenizer t) {
        final ThreadReference invokingThread = ThreadInfo.current.thread;
        final ThreadReference threadToKill = ttk;
        final StringTokenizer tokenizer = t;
        Thread thread = new Thread("kill command") {
            public void run() {
                doKill(threadToKill, tokenizer);
                // If events have been processing during this command,
                // the cached stack may now be stale, so invalidate it.
                ThreadInfo.invalidateAll();
                ThreadInfo.setCurrentThread(invokingThread);
                Env.printPrompt();
            }
        };
        thread.start();
    }

    void commandKill(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("Usage: kill <thread id> <throwable>");
            return;
        }
        String idToken = t.nextToken();
        ThreadInfo tinfo = ThreadInfo.getThread(idToken);
        if (tinfo != null) {
            out.println("killing thread: " + tinfo.thread.name());
            doKillThread(tinfo.thread, t);
            return;
        } else {
            out.println("invalid thread");
        }
    }

    void listCaughtExceptions() {
        boolean noExceptions = true;

        // Print set exceptions
        Iterator iter = Env.specList.eventRequestSpecs().iterator();
        while (iter.hasNext()) {
            EventRequestSpec spec = (EventRequestSpec)iter.next();
            if (spec instanceof ExceptionSpec) {
                if (noExceptions) {
                    noExceptions = false;
                    out.println("Exceptions caught:");
                }
                out.println("\t" + spec);
            }
        }
        if (noExceptions) {
            out.println("No exceptions caught.");
        }
    }

    private EventRequestSpec parseExceptionSpec(StringTokenizer t) {
        String className = t.nextToken();
        EventRequestSpec spec = null;

        try {
            spec = Env.specList.createExceptionCatch(className);
        } catch (ClassNotFoundException exc) {
            out.println("Bad class name: " + className);
        }
        return spec;
    }

    void commandCatchException(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            listCaughtExceptions();
        } else { 
            EventRequestSpec spec = parseExceptionSpec(t);
            if (spec != null) {
                resolveNow(spec);
            }
            //EventRequestManager mgr = Env.vm().eventRequestManager();
            //ExceptionRequest request = mgr.createExceptionRequest(null, true, true);
            //request.addClassFilter(t.nextToken());
            //request.enable();
        }
    }
    
    void commandIgnoreException(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            listCaughtExceptions();
        } else { 
            EventRequestSpec spec = parseExceptionSpec(t);
            if (Env.specList.delete(spec)) {
                out.println("Removed " + spec);
            } else {
                out.println("Not found: " + spec);
            }
        }
    }
    
    void commandUp(StringTokenizer t) {
        if (ThreadInfo.current == null) {
            out.println("Current thread not set.");
            return;
        }

        int nLevels = 1;
        if (t.hasMoreTokens()) {
            String idToken = t.nextToken();
            int n;
            try {
                n = Integer.valueOf(idToken).intValue();
            } catch (NumberFormatException e) {
                n = 0;
            }
            if (n <= 0) {
                out.println("Usage: up [n frames]");
                return;
            }
            nLevels = n;
        }

        try {
            ThreadInfo.current.up(nLevels);
        } catch (IncompatibleThreadStateException e) {
            out.println("Thread isn't suspended.");
        } catch (ArrayIndexOutOfBoundsException e) {
            out.println("End of stack.");
        }
    }

    void commandDown(StringTokenizer t) {
        if (ThreadInfo.current == null) {
            out.println("Current thread not set.");
            return;
        }

        int nLevels = 1;
        if (t.hasMoreTokens()) {
            String idToken = t.nextToken();
            int n;
            try {
                n = Integer.valueOf(idToken).intValue();
            } catch (NumberFormatException e) {
                n = 0;
            }
            if (n <= 0) {
                out.println("usage: down [n frames]");
                return;
            }
            nLevels = n;
        }

        try {
            ThreadInfo.current.down(nLevels);
        } catch (IncompatibleThreadStateException e) {
            out.println("Thread isn't suspended.");
        } catch (ArrayIndexOutOfBoundsException e) {
            out.println("End of stack.");
        }
    }

    private void dumpStack(ThreadInfo tinfo, boolean showPC) {
        List stack = null;
        try {
            stack = tinfo.stack();
        } catch (IncompatibleThreadStateException e) {
            eWin.debugPane.ThreadWin.append("Current thread isn't suspended.\n");
            out.println("Current thread isn't suspended.\n");
            return;
        }
        if (stack == null) {
            eWin.debugPane.ThreadWin.append("Thread is not running (no stack).\n");
            out.println("Thread is not running (no stack).\n");
        } else {
            int nFrames = stack.size();
            for (int i = tinfo.currentFrameIndex; i < nFrames; i++) {
                StackFrame frame = (StackFrame)stack.get(i);
                Location loc = frame.location();
                Method meth = loc.method();
                eWin.debugPane.ThreadWin.append("  [" + (i + 1) + "] ");
                eWin.debugPane.ThreadWin.append(meth.declaringType().name());
                eWin.debugPane.ThreadWin.append(".");
                eWin.debugPane.ThreadWin.append(meth.name());
                eWin.debugPane.ThreadWin.append(" (");

                out.print("  [" + (i + 1) + "] ");
                out.print(meth.declaringType().name());
                out.print('.');
                out.print(meth.name());
                out.print(" (");
                if (meth instanceof Method && ((Method)meth).isNative()) {
                    eWin.debugPane.ThreadWin.append("native method");
                    out.print("native method");
                } else if (loc.lineNumber() != -1) {
                    try {
                        eWin.debugPane.ThreadWin.append(loc.sourceName());
                        out.print(loc.sourceName());
                    } catch (AbsentInformationException e) {
                        eWin.debugPane.ThreadWin.append("<unknown>");
                        out.print("<unknown>");
                    }
                    eWin.debugPane.ThreadWin.append(":");
                    int temp = loc.lineNumber();
                    char x = (char)temp;
                    // String xx = (String)x;
                    eWin.debugPane.ThreadWin.append(x+" ");
                    out.print(':');
                    out.print(loc.lineNumber());
                }
                eWin.debugPane.ThreadWin.append(")");
                out.print(')');
                if (showPC) {
                    long pc = loc.codeIndex();
                    if (pc != -1) {
                        eWin.debugPane.ThreadWin.append(", pc = " + pc);
                        out.print(", pc = " + pc);
                    }
                }
                eWin.debugPane.ThreadWin.append("\n");
                out.println();

            }
        }
    }

    void commandWhere(StringTokenizer t, boolean showPC) {
        eWin.debugPane.ThreadWin.setText(" ");
        if (!t.hasMoreTokens()) {
            if (ThreadInfo.current == null) {
                out.println("No thread specified. \n");
                return;
            }
            dumpStack(ThreadInfo.current, showPC);
        } else {
            String token = t.nextToken();
            if (token.toLowerCase().equals("all")) {
                ThreadInfo[] list = ThreadInfo.threads();
                for (int i = 0; i < list.length; i++) {
                    ThreadInfo tinfo = list[i];
                    out.println(tinfo.thread.name() + ": \n" );
                    eWin.debugPane.ThreadWin.append(tinfo.thread.name() + ":\n " );
                    dumpStack(tinfo, showPC);
                }
            } else {
                ThreadInfo tinfo = getThread(token);
                if (tinfo != null) {
                    ThreadInfo.current = tinfo;
                }
                dumpStack(tinfo, showPC);
            }
        }
    }

    void commandInterrupt(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            if (ThreadInfo.current == null) {
                out.println("No thread specified.");
                return;
            }
            ThreadInfo.current.thread.interrupt();
        } else {
            String token = t.nextToken();
            ThreadInfo tinfo = getThread(token);
            if (tinfo != null) {
                tinfo.thread.interrupt();
            } else {
                out.println("Invalid thread");
            }
        }
    }

    void commandMemory() {
        out.println("The 'memory' command is no longer supported.");
    }

    void commandGC() {
        out.println("The 'gc' command is no longer necessary.\nAll objects are " +
                    "garbage collected as usual. Use 'enablegc' and 'disablegc'\n" +
                    "commands to control garbage collection of individual objects.");
    }

    /*
     * The next two methods are used by this class and by EventHandler
     * to print consistent locations and error messages.
     */
    static String locationString(Location loc) {

        return  loc.declaringType().name() +
                "." + loc.method().name() + "(), line=" +
                loc.lineNumber() + ", bci=" + loc.codeIndex();
    }

    void listBreakpoints() {
        boolean noBreakpoints = true;

        // Print set breakpoints
        Iterator iter = Env.specList.eventRequestSpecs().iterator();
        while (iter.hasNext()) {
            EventRequestSpec spec = (EventRequestSpec)iter.next();
            if (spec instanceof BreakpointSpec) {
                if (noBreakpoints) {
                    noBreakpoints = false;
                    out.println("Breakpoints set:");
                }
                out.println("\t" + spec);
//              out.println("\t" + locationString(bp.location()));
            }
        }
        if (noBreakpoints) {
            out.println("No breakpoints set.");
        }
    }


    private void printBreakpointCommandUsage(String atForm, String inForm) {
        out.println("Usage: " + atForm + " <class>:<line_number> or");
        out.println("       " + inForm + " <class>.<method_name>[(argument_type,...)]");
    }

    protected BreakpointSpec parseBreakpointSpec(StringTokenizer t, 
                                             String atForm, String inForm) {
        EventRequestSpec breakpoint = null;
        try {
            String token = t.nextToken(":( \t\n\r");

            // We can't use hasMoreTokens here because it will cause any leading
            // paren to be lost.
            String rest;
            try {
                rest = t.nextToken("").trim();
            } catch (NoSuchElementException e) {
                rest = null;
            }

            if ((rest != null) && rest.startsWith(":")) {
                t = new StringTokenizer(rest.substring(1));
                String classId = token;
                String lineToken = t.nextToken();
                int lineNumber = Integer.valueOf(lineToken).intValue();

                if (t.hasMoreTokens()) {
                    printBreakpointCommandUsage(atForm, inForm);
                    return null;
                }
                try { 
                    breakpoint = Env.specList.createBreakpoint(classId,
                                                               lineNumber);
                } catch (ClassNotFoundException exc) {
                    out.println("Bad class name: " + classId);
                }
            } else {
                // Try stripping method from class.method token.
                int idot = token.lastIndexOf(".");
                if ( (idot <= 0) ||                     /* No dot or dot in first char */
                     (idot >= token.length() - 1) ) { /* dot in last char */
                    printBreakpointCommandUsage(atForm, inForm);
                    return null;
                }
                String methodName = token.substring(idot + 1);
                String classId = token.substring(0, idot);
                List argumentList = null;
                if (rest != null) {
                    if (!rest.startsWith("(") || !rest.endsWith(")")) {
                        out.println("Invalid method specification: " + methodName + rest);
                        printBreakpointCommandUsage(atForm, inForm);
                        return null;
                    }
                    // Trim the parens
                    rest = rest.substring(1, rest.length() - 1);

                    argumentList = new ArrayList();
                    t = new StringTokenizer(rest, ",");
                    while (t.hasMoreTokens()) {
                        argumentList.add(t.nextToken());
                    }
                }
                try {
                    breakpoint = Env.specList.createBreakpoint(classId, 
                                                               methodName, 
                                                               argumentList);
                } catch (MalformedMemberNameException exc) {
                    out.println("Bad method name: " + methodName);
                } catch (ClassNotFoundException exc) {
                    out.println("Bad class name: " + classId);
                }
            }
        } catch (Exception e) {
            printBreakpointCommandUsage(atForm, inForm);
            return null;
        }
        return (BreakpointSpec)breakpoint;
    }

    private void resolveNow(EventRequestSpec spec) {
        boolean success = Env.specList.addEagerlyResolve(spec);
        if (success && !spec.isResolved()) {
            out.println("Deferring " + spec + ".");
            out.println("It will be set after the class is loaded.");
        }
    }

    void commandStop(StringTokenizer t) {
        Location bploc;
        String atIn;
        byte suspendPolicy = EventRequest.SUSPEND_ALL;

        if (t.hasMoreTokens()) {
            atIn = t.nextToken();
            if (atIn.equals("go") && t.hasMoreTokens()) {
                suspendPolicy = EventRequest.SUSPEND_NONE;
                atIn = t.nextToken();
            } else if (atIn.equals("thread") && t.hasMoreTokens()) {
                suspendPolicy = EventRequest.SUSPEND_EVENT_THREAD;
                atIn = t.nextToken();
            }
        } else {
            listBreakpoints();
            return;
        }        

        BreakpointSpec spec = parseBreakpointSpec(t, "stop at", "stop in");
        if (spec != null) {
            // Enforcement of "at" vs. "in". The distinction is really 
            // unnecessary and we should consider not checking for this 
            // (and making "at" and "in" optional).
            if (atIn.equals("at") && spec.isMethodBreakpoint()) {
                out.println("Use 'stop at' to set a breakpoint at a line number");
                printBreakpointCommandUsage("stop at", "stop in");
                return;
            }
            spec.suspendPolicy = suspendPolicy;
            resolveNow(spec);
        }
    }

    void commandClear(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            listBreakpoints();
            return;
        }
        
        BreakpointSpec spec = parseBreakpointSpec(t, "clear", "clear");
        if (spec != null) {         
            if (Env.specList.delete(spec)) {
                out.println("Removed: " + spec);

            } else {
                out.println("Not found: " + spec);
            }
        }
    }

    private List parseWatchpointSpec(StringTokenizer t) {
        List list = new ArrayList();
        boolean access = false;
        boolean modification = false;
        int suspendPolicy = EventRequest.SUSPEND_ALL;

        String fieldName = t.nextToken();
        if (fieldName.equals("go")) {
            suspendPolicy = EventRequest.SUSPEND_NONE;
            fieldName = t.nextToken();
        } else if (fieldName.equals("thread")) {
            suspendPolicy = EventRequest.SUSPEND_EVENT_THREAD;
            fieldName = t.nextToken();
        }
        if (fieldName.equals("access")) {
            access = true;
            fieldName = t.nextToken();
        } else if (fieldName.equals("all")) {
            access = true;
            modification = true;
            fieldName = t.nextToken();
        } else {
            modification = true;
        }
        int dot = fieldName.lastIndexOf('.');
        if (dot < 0) {
            out.println("Class containing field must be specified.");
            return list;
        }
        String className = fieldName.substring(0, dot);
        fieldName = fieldName.substring(dot+1);

        try {
            EventRequestSpec spec;
            if (access) {
                spec = Env.specList.createAccessWatchpoint(className, 
                                                           fieldName);
                spec.suspendPolicy = suspendPolicy;
                list.add(spec);
            }
            if (modification) {
                spec = Env.specList.createModificationWatchpoint(className, 
                                                                 fieldName);
                spec.suspendPolicy = suspendPolicy;
                list.add(spec);
            }
        } catch (MalformedMemberNameException exc) {
            out.println("Bad field name: " + fieldName);
        } catch (ClassNotFoundException exc) {
            out.println("Bad class name: " + className);
        }
        return list;
    }

    void commandWatch(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("Field to watch not specified.");
            return;
        }

        Iterator iter = parseWatchpointSpec(t).iterator();
        while (iter.hasNext()) {
            resolveNow((WatchpointSpec)iter.next());
        }
    }

    void commandUnwatch(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("Field to unwatch not specified.");
            return;
        }

        Iterator iter = parseWatchpointSpec(t).iterator();
        while (iter.hasNext()) {
            WatchpointSpec spec = (WatchpointSpec)iter.next();
            if (Env.specList.delete(spec)) {
                out.println("Removed " + spec);
            } else {
                out.println("Not found: " + spec);
            }
        }
    }

    void commandTrace(StringTokenizer t) {
        String modif;
        int suspendPolicy = EventRequest.SUSPEND_ALL;

        if (t.hasMoreTokens()) {
            modif = t.nextToken();
            if (modif.equals("go")) {
                suspendPolicy = EventRequest.SUSPEND_NONE;
                modif = t.nextToken();
            } else if (modif.equals("thread")) {
                suspendPolicy = EventRequest.SUSPEND_EVENT_THREAD;
                modif = t.nextToken();
            }
            if (modif.equals("methods")) {
                // nothing to do until other traces
            } else {
                out.println("Specify kind, for example 'methods'");
            }
        }
        ThreadInfo tinfo = null;
        if (t.hasMoreTokens()) {
            tinfo = getThread(t.nextToken());
        }
        EventRequestManager erm = Env.vm().eventRequestManager();
        MethodEntryRequest entry = erm.createMethodEntryRequest();
        MethodExitRequest exit = erm.createMethodExitRequest();
        if (tinfo != null) {
            entry.addThreadFilter(tinfo.thread);
            exit.addThreadFilter(tinfo.thread);
        }
        Env.addExcludes(entry);
        Env.addExcludes(exit);

        entry.setSuspendPolicy(suspendPolicy);
        exit.setSuspendPolicy(suspendPolicy);
        entry.enable();
        exit.enable();
    }

    void commandUntrace(StringTokenizer t) {
        EventRequestManager erm = Env.vm().eventRequestManager();
        Iterator it = erm.methodEntryRequests().iterator();
        while (it.hasNext()) {
            ((EventRequest)it.next()).disable();
        }
        it = erm.methodExitRequests().iterator();
        while (it.hasNext()) {
            ((EventRequest)it.next()).disable();
        }
    }

    void commandList(StringTokenizer t) {
        StackFrame frame = null;
        if (ThreadInfo.current == null) {
            out.println("No thread specified.");

            return;
        }
        try {
            frame = ThreadInfo.current.getCurrentFrame();
        } catch (IncompatibleThreadStateException e) {
            out.println("Current thread isn't suspended.");
            return;
        }

        if (frame == null) {
            out.println("No frames on the current call stack");
            return;
        }

        Location loc = frame.location();
        if (loc.method().isNative()) {
            out.println("Current method is native");
            return;
        }

        String sourceFileName = null;
        try {
            sourceFileName = loc.sourceName();

            ReferenceType refType = loc.declaringType();

            int lineno = loc.lineNumber();
            if (t.hasMoreTokens()) {
                String id = t.nextToken();

                // See if token is a line number.
                try {
                    lineno = Integer.valueOf(id).intValue();
                } catch (NumberFormatException nfe) {
                    // It isn't -- see if it's a method name.
                        List meths = refType.methodsByName(id);
                        if (meths == null || meths.size() == 0) {
                            out.println(id +
                                        " is not a valid line number or " +
                                        "method name for class " +
                                        refType.name());
                            return;
                        } else if (meths.size() > 1) {
                            out.println(id +
                                        " is an ambiguous method name in" +
                                        refType.name());
                            return;
                        }
                        loc = ((Method)meths.get(0)).location();
                        lineno = loc.lineNumber();
                }
            }
            int startLine = (lineno > 4) ? lineno - 4 : 1;
            int endLine = startLine + 9;

            if (Env.sourceLine(loc, lineno) == null) {
                out.println("" + lineno +
                            " is an invalid line number for " +
                            refType.name());
            } else {
                for (int i = startLine; i <= endLine; i++) {
                    String sourceLine = Env.sourceLine(loc, i);
                    if (sourceLine == null) {
                        break;
                    }
                    out.print(i);
                    out.print("\t");
                    if (i == lineno) {
                        out.print("=> ");
                    } else {
                        out.print("   ");
                    }
                    out.println(sourceLine);
                }
            }
        } catch (AbsentInformationException e) {
            out.println("No source information available for " + loc);
        } catch(FileNotFoundException exc) {
            out.println("Source file not found: " + sourceFileName);
        } catch(IOException exc) {
            out.println("I/O Exception occurred: " + exc);
        } 
    }

    void commandLines(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("Specify class and method");
        } else {
            String idClass = t.nextToken();
            String idMethod = t.hasMoreTokens() ? t.nextToken() : null;
            try {
                ReferenceType refType = Env.getReferenceTypeFromToken(idClass);
                if (refType != null) {
                    List lines = null;
                    if (idMethod == null) {
                        lines = refType.allLineLocations();
                    } else {
                        List methods = refType.allMethods();
                        Iterator iter = methods.iterator();
                        while (iter.hasNext()) {
                            Method method = (Method)iter.next();
                            if (method.name().equals(idMethod)) {
                                lines = method.allLineLocations();
                            }
                        }
                        if (lines == null) {
                            out.println("\"" + idMethod +
                                               "\" is not a method name.");
                        }
                    }
                    Iterator iter = lines.iterator();
                    while (iter.hasNext()) {
                        Location line = (Location)iter.next();
                        out.println(line);
                    }
                } else {
                    out.println("\"" + idClass +
                                       "\" is not a valid id or class name.");
                }
            } catch (AbsentInformationException e) {
                out.println("Line number information not available for \"" + idClass + "\"");
            }
        }
    }

    void commandClasspath(StringTokenizer t) {
        if (Env.vm() instanceof PathSearchingVirtualMachine) {
            PathSearchingVirtualMachine vm = (PathSearchingVirtualMachine)Env.vm();
            out.println("base directory: " + vm.baseDirectory());
            out.println("classpath: " + vm.classPath());
            out.println("bootclasspath: " + vm.bootClassPath());
        } else {
            out.println("The VM does not use paths");
        }
    }

    /* Get or set the source file path list. */
    void commandUse(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println(sourcePath);
        } else {
            Env.setSourcePath(t.nextToken());
        }
    }

    /* Print a stack variable */
    private void printVar(LocalVariable var, Value value) {
        out.println("  " + var.name() + " = " + value);
        eWin.debugPane.AWatchWin.append("  " + var.name() + " = " + value +"\n");
    }

         /* Print all local variables in current stack frame. */
    void commandLocals() {
        StackFrame frame;
        eWin.debugPane.AWatchWin.setText(" ");
        if (ThreadInfo.current == null) {
            out.println("No default thread specified: " +
                               "use the \"thread\" command first.");
            eWin.debugPane.AWatchWin.append("No default thread specified: " +
                               "use the \"thread\" command first.\n");
            return;
        }
        try {
            frame = ThreadInfo.current.getCurrentFrame();
            List vars = frame.visibleVariables();

            if (vars.size() == 0) {
                out.println("No local variables");
                eWin.debugPane.AWatchWin.append("No local variables \n");
                return;
            }
            Map values = frame.getValues(vars);

            out.println("Method arguments:");
            eWin.debugPane.AWatchWin.append("Method arguments: \n");
            for (Iterator it = vars.iterator(); it.hasNext(); ) {
                LocalVariable var = (LocalVariable)it.next();
                if (var.isArgument()) {
                    Value val = (Value)values.get(var);
                    printVar(var, val);
                }
            }
            out.println("Local variables:");
            eWin.debugPane.AWatchWin.append("Local variables:\n");
            for (Iterator it = vars.iterator(); it.hasNext(); ) {
                LocalVariable var = (LocalVariable)it.next();
                if (!var.isArgument()) {
                    Value val = (Value)values.get(var);
                    printVar(var, val);
                }
            }
        } catch (AbsentInformationException aie) {
            out.println("Local variable information not available." +
                        " Compile with -g to generate variable information");
            eWin.debugPane.AWatchWin.append("Local variable information not available." +
                        " Compile with -g to generate variable information\n");
        } catch (IncompatibleThreadStateException exc) {
            out.println("Thread isn't suspended.");
            eWin.debugPane.AWatchWin.append("Thread isn't suspended.\n");
        }
    }

    private void dump(ObjectReference obj, ReferenceType refType,
                      ReferenceType refTypeBase) {
        for (Iterator it = refType.fields().iterator(); it.hasNext(); ) {
            Field field = (Field)it.next();
            out.print("    ");
            if (!refType.equals(refTypeBase)) {
                out.print(refType.name() + ".");
            }
            out.print(field.name() + ": ");
            out.println(obj.getValue(field));
        }
        if (refType instanceof ClassType) {
            ClassType sup = ((ClassType)refType).superclass();
            if (sup != null) {
                dump(obj, sup, refTypeBase);
            }
        } else if (refType instanceof InterfaceType) {
            List sups = ((InterfaceType)refType).superinterfaces();
            for (Iterator it = sups.iterator(); it.hasNext(); ) {
                dump(obj, (ReferenceType)it.next(), refTypeBase);
            }
        }
    }

    /* Print a specified reference.
     */
    void doPrint(StringTokenizer t, boolean dumpObject) {
        if (!t.hasMoreTokens()) {
            out.println("No objects specified.");
            eWin.debugPane.AWatchWin.append("No objects specified. \n");
            return;
        }

        while (t.hasMoreTokens()) {
            String expr = t.nextToken("");
            try {
                Value val = evaluate(expr);
                if (val == null) {
                    out.println(expr + " = null");
                    eWin.debugPane.addWatchWin.append(expr + " = null \n");
                } else if (dumpObject && (val instanceof ObjectReference) &&
                           !(val instanceof StringReference)) {
                    ObjectReference obj = (ObjectReference)val;
                    ReferenceType refType = obj.referenceType();
                    out.println(expr + " = " + val.toString() + " {");
                    eWin.debugPane.addWatchWin.append(expr + " = " + val.toString() + " {\n");
                    dump(obj, refType, refType);
                    out.println("}");
                    eWin.debugPane.addWatchWin.append("}\n");
                } else {
                    out.println(expr + " = " + val.toString());
                    eWin.debugPane.addWatchWin.append(expr + " = "+val.toString()+"\n");
                }
            } catch (ParseException exc) {
                System.out.println(exc.getMessage());

                eWin.debugPane.addWatchWin.append(exc.getMessage()+"\n");
            } catch (InvocationException ie) {
                System.out.println("Exception in expression: " +
                                   ie.exception().referenceType().name());
                eWin.debugPane.addWatchWin.append("Exception in expression: " +
                                   ie.exception().referenceType().name()+"\n");
            } catch (InvalidTypeException ite) {
                System.out.println(ite.getMessage());
                eWin.debugPane.addWatchWin.append(ite.getMessage()+"\n");
            } catch (IncompatibleThreadStateException itse) {
                System.out.println(itse.getMessage());
                eWin.debugPane.addWatchWin.append(itse.getMessage()+"\n");
            } catch (ClassNotLoadedException tnle) {
                System.out.println(tnle.getMessage());
                eWin.debugPane.addWatchWin.append(tnle.getMessage()+"\n");
            }
        }
    }

    void commandPrint(final StringTokenizer t, final boolean dumpObject) {
        final ThreadReference invokingThread =
            ThreadInfo.current==null? null : ThreadInfo.current.thread;
            Thread thread = new Thread("print command") {
            public void run() {
                doPrint(t, dumpObject);
                // If events have been processing during this command,
                // the cached stack may now be stale, so invalidate it.
                ThreadInfo.invalidateAll();
                if (invokingThread != null) {
                    ThreadInfo.setCurrentThread(invokingThread);
                }
                Env.printPrompt();
            }
        };
        thread.start();
    }

    void commandSet(final StringTokenizer t) {
        String all = t.nextToken("");

        /*
         * Bare bones error checking.
         */
        if (all.indexOf('=') == -1) {
            out.println("Invalid assignment syntax");
            Env.printPrompt();
            return;
        }

        /*
         * The set command is really just syntactic sugar. Pass it on to the 
         * print command.
         */
        commandPrint(new StringTokenizer(all), false);
    }

    void doLock(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No object specified.");
            return;
        }

        String expr = t.nextToken("");
        Value val = null;
        try {
            val = evaluate(expr);
        } catch (ParseException exc) {
            System.out.println(exc.getMessage());
        } catch (InvocationException ie) {
            System.out.println("Exception in expression: " + 
                               ie.exception().referenceType().name());
        } catch (InvalidTypeException ite) {
            System.out.println(ite.getMessage());
        } catch (IncompatibleThreadStateException itse) {
            System.out.println(itse.getMessage());
        } catch (ClassNotLoadedException tnle) {
            System.out.println(tnle.getMessage());
        }

        try {
            if ((val != null) && (val instanceof ObjectReference)) {
                ObjectReference object = (ObjectReference)val;
                out.println("Monitor information for " + val.toString() + ":");
                ThreadReference owner = object.owningThread();
                if (owner == null) {
                    out.println("  Not owned");
                } else {
                    out.println("  Owned by: " + owner.name() + ", entry count: " + object.entryCount());
                }
                List waiters = object.waitingThreads();
                if (waiters.size() == 0) {
                    out.println("  No waiters");
                } else {
                    Iterator iter = waiters.iterator();
                    while (iter.hasNext()) {
                        ThreadReference waiter = (ThreadReference)iter.next();
                        out.println("  Waiting thread: " + owner.name());
                    }
                }
            } else {
                out.println("Expression must evaluate to an object");
            }
        } catch (IncompatibleThreadStateException e) {
            out.println("Threads must be suspended");
        }
    }

    void commandLock(final StringTokenizer t) {
        final ThreadReference invokingThread = ThreadInfo.current.thread;
        Thread thread = new Thread("lock command") {
            public void run() {
                doLock(t);
                // If events have been processing during this command,
                // the cached stack may now be stale, so invalidate it.
                ThreadInfo.invalidateAll();
                ThreadInfo.setCurrentThread(invokingThread);
                Env.printPrompt();
            }
        };
        thread.start();
    }

    private void printThreadLockInfo(ThreadReference thread) {
        try {
            out.println("Monitor information for thread " + thread.name() + ":");
            List owned = thread.ownedMonitors();
            if (owned.size() == 0) {
                out.println("  No monitors owned");
            } else {
                Iterator iter = owned.iterator();
                while (iter.hasNext()) {
                    ObjectReference monitor = (ObjectReference)iter.next();
                    out.println("  Owned monitor: " + monitor);
                }
            }
            ObjectReference waiting = thread.currentContendedMonitor();
            if (waiting == null) {
                out.println("  Not waiting for a monitor");
            } else {
                out.println("  Waiting for monitor: " + waiting);
            }
        } catch (IncompatibleThreadStateException e) {
            out.println("Threads must be suspended");
        }
    }

    void commandThreadlocks(final StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            printThreadLockInfo(ThreadInfo.current.thread);
            return;
        }
        String token = t.nextToken();
        if (token.toLowerCase().equals("all")) {
            ThreadInfo[] list = ThreadInfo.threads();
            for (int i = 0; i < list.length; i++) {
                ThreadInfo tinfo = list[i];
                printThreadLockInfo(tinfo.thread);
            }
        } else {
            ThreadInfo tinfo = getThread(token);
            if (tinfo != null) {
                ThreadInfo.current = tinfo;
            }
            printThreadLockInfo(tinfo.thread);
        }
    }

    void doDisableGC(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No object specified.");
            return;
        }

        String expr = t.nextToken("");
        Value val = null;
        try {
            val = evaluate(expr);
        } catch (ParseException exc) {
            System.out.println(exc.getMessage());
        } catch (InvocationException ie) {
            System.out.println("Exception in expression: " + 
                               ie.exception().referenceType().name());
        } catch (InvalidTypeException ite) {
            System.out.println(ite.getMessage());
        } catch (IncompatibleThreadStateException itse) {
            System.out.println(itse.getMessage());
        } catch (ClassNotLoadedException tnle) {
            System.out.println(tnle.getMessage());
        }

        if ((val != null) && (val instanceof ObjectReference)) {
            ObjectReference object = (ObjectReference)val;
            object.disableCollection();
            out.println("GC Disabled for " + val.toString() + ":");
        } else {
            out.println("Expression must evaluate to an object");
        }
    }

    void commandDisableGC(final StringTokenizer t) {
        final ThreadReference invokingThread = ThreadInfo.current.thread;
        Thread thread = new Thread("enablegc command") {
            public void run() {
                doDisableGC(t);
                // If events have been processing during this command,
                // the cached stack may now be stale, so invalidate it.
                ThreadInfo.invalidateAll();
                ThreadInfo.setCurrentThread(invokingThread);
                Env.printPrompt();
            }
        };
        thread.start();
    }

    void doEnableGC(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No object specified.");
            return;
        }

        String expr = t.nextToken("");
        Value val = null;
        try {
            val = evaluate(expr);
        } catch (ParseException exc) {
            System.out.println(exc.getMessage());
        } catch (InvocationException ie) {
            System.out.println("Exception in expression: " + 
                               ie.exception().referenceType().name());
        } catch (InvalidTypeException ite) {
            System.out.println(ite.getMessage());
        } catch (IncompatibleThreadStateException itse) {
            System.out.println(itse.getMessage());
        } catch (ClassNotLoadedException tnle) {
            System.out.println(tnle.getMessage());
        }

        if ((val != null) && (val instanceof ObjectReference)) {
            ObjectReference object = (ObjectReference)val;
            object.enableCollection();
            out.println("GC Enabled for " + val.toString() + ":");
        } else {
            out.println("Expression must evaluate to an object");
        }
    }

    void commandEnableGC(final StringTokenizer t) {
        final ThreadReference invokingThread = ThreadInfo.current.thread;
        Thread thread = new Thread("enablegc command") {
            public void run() {
                doEnableGC(t);
                // If events have been processing during this command,
                // the cached stack may now be stale, so invalidate it.
                ThreadInfo.invalidateAll();
                ThreadInfo.setCurrentThread(invokingThread);
                Env.printPrompt();
            }
        };
        thread.start();
    }

    void doSave(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No save index specified.");
            return;
        }

        String key = t.nextToken();

        if (!t.hasMoreTokens()) {
            out.println("No expression specified.");
            return;
        }
        String expr = t.nextToken("");
        Value val = null;
        try {
            val = evaluate(expr);
        } catch (ParseException exc) {
            System.out.println(exc.getMessage());
        } catch (InvocationException ie) {
            System.out.println("Exception in expression: " + 
                               ie.exception().referenceType().name());
        } catch (InvalidTypeException ite) {
            System.out.println(ite.getMessage());
        } catch (IncompatibleThreadStateException itse) {
            System.out.println(itse.getMessage());
        } catch (ClassNotLoadedException tnle) {
            System.out.println(tnle.getMessage());
        }

        if (val != null) {
            Env.setSavedValue(key, val);
            out.println(val.toString() + " saved");
        } else {
            out.println("Expression cannot be void");
        }
    }

    void commandSave(final StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            Set keys = Env.getSaveKeys();
            Iterator iter = keys.iterator();
            if (!iter.hasNext()) {
                out.println("No saved values");
                return;
            }
            while (iter.hasNext()) {
                String key = (String)iter.next();
                Value value = Env.getSavedValue(key);
                out.print(key + " = ");
                if ((value instanceof ObjectReference) &&
                    ((ObjectReference)value).isCollected()) {
                    out.println(" <collected>");
                } else {
                    out.println((value != null) ? value.toString() : "null");
                }
            }
        } else {
            final ThreadReference invokingThread = ThreadInfo.current.thread;
            Thread thread = new Thread("save command") {
                public void run() {
                    doSave(t);
                    // If events have been processing during this command,
                    // the cached stack may now be stale, so invalidate it.
                    ThreadInfo.invalidateAll();
                    ThreadInfo.setCurrentThread(invokingThread);
                    Env.printPrompt();
                }
            };
            thread.start();
        }


    }

   void commandBytecodes(final StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println("No class specified");
            return;
        }
        String className = t.nextToken();

        if (!t.hasMoreTokens()) {
            out.println("No method specified");
            return;
        }

        // Overloading is not handled here.

        String methodName = t.nextToken();

        List classes = Env.vm().classesByName(className);
        // TO DO: handle multiple classes found
        if (classes.size() == 0) {
            out.print(className + " not found");
            out.println((className.indexOf('.') > 0) ?
                               " (try the full name)" : "");
            return;
        } 
        
        ReferenceType rt = (ReferenceType)classes.get(0);
        if (!(rt instanceof ClassType)) {
            out.print(className + " is not a class");
            return;
        }

        byte[] bytecodes = null;                                               
        List list = rt.methodsByName(methodName);
        Iterator iter = list.iterator();
        while (iter.hasNext()) {
            Method method = (Method)iter.next();
            if (!method.isAbstract()) {
                bytecodes = method.bytecodes();
                break;
            }
        }

        StringBuffer line = new StringBuffer(80);
        line.append("0000: ");
        for (int i = 0; i < bytecodes.length; i++) {
            if ((i > 0) && (i % 16 == 0)) {
                out.println(line.toString());
                line.setLength(0);
                line.append(String.valueOf(i));
                line.append(": ");
                int len = line.length();
                for (int j = 0; j < 6 - len; j++) {
                    line.insert(0, '0');
                }
            }
            int val = 0xff & bytecodes[i];
            String str = Integer.toHexString(val);
            if (str.length() == 1) {
                line.append('0');
            }
            line.append(str);
            line.append(' ');
        }
        if (line.length() > 6) {
            out.println(line.toString());
        }
    }
    void commandExclude(StringTokenizer t) {
        if (!t.hasMoreTokens()) {
            out.println(Env.excludesString());
        } else {
            String rest = t.nextToken("");
            if (rest.equals("none")) {
                rest = "";
            }
            Env.setExcludes(rest);
        }
    }

    void commandVersion(String debuggerName,
                        String debuggerVersion,
                        StringTokenizer t) {
        out.println(debuggerName + ", version " + debuggerVersion);
        try {
            out.println(Env.vm().description());
        } catch (VMNotConnectedException e) {
            out.println("No VM connected");
        }
    }
    //   public void run() {}
    }

