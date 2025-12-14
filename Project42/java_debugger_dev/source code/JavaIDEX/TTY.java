package JavaIDEX;
import com.sun.jdi.*;
import com.sun.jdi.event.*;
import com.sun.jdi.connect.*;
import javax.swing.*;

import java.util.*;
import java.io.*;


public class TTY implements EventNotifier {

    PrintStream out;
    JTextArea AWatchWin,ThreadWin;
    EventHandler handler = null;
    EditWin eWin;

    /**
     * List of Strings to execute at each stop.
     */
    private List monitorCommands = new ArrayList();
    private int monitorCount = 0;
    private static final String progname = "jdb";
    private static final String version = "99/06/11";
    public void vmStartEvent(VMStartEvent se)  {
        Thread.yield();  // fetch output
        out.print("\nVM Started: ");
        otherEvent(se);
    }

    public void breakpointEvent(BreakpointEvent be)  {
        Thread.yield();  // fetch output
        out.print("\nBreakpoint hit: ");
        otherEvent(be);
    }

    public void fieldWatchEvent(WatchpointEvent fwe)  {
        Field field = fwe.field();
        ObjectReference obj = fwe.object();
        Thread.yield();  // fetch output
        out.print("\nField (" + field + ") ");
        if (fwe instanceof ModificationWatchpointEvent) {
            out.print("is ");
            out.print(fwe.valueCurrent());
            out.print(", will be ");
            out.print(((ModificationWatchpointEvent)fwe).valueToBe());
            out.print(": ");
        } else {
            out.print("access encountered: ");
        }
        otherEvent(fwe);
    }

    public void stepEvent(StepEvent se)  {
        Thread.yield();  // fetch output
        out.print("\nStep completed: ");
        otherEvent(se);
    }

    public void exceptionEvent(ExceptionEvent ee) {
        Thread.yield();  // fetch output
        out.print("\nException occurred: ");
        out.print(ee.exception().referenceType().name());
        Location catchLocation = ee.catchLocation();
        if (catchLocation == null) {
            out.print(" (uncaught) ");
        } else {
            out.print(" (to be caught at: ");
            out.print(Commands.locationString(catchLocation));
            out.print(") ");
        }
        otherEvent(ee);
    }

    public void methodEntryEvent(MethodEntryEvent me) {
        Thread.yield();  // fetch output
        /*
         * These can be very numerous, so be as efficient as possible.
         */
        StringBuffer buffer = new StringBuffer("\nMethod Entered: ");
        buffer.append(me.method().declaringType().name());
        buffer.append(".");
        buffer.append(me.method().name());
        buffer.append(" ");
        out.print(buffer.toString());
        otherEvent(me);
    }

    public void methodExitEvent(MethodExitEvent me) {
        Thread.yield();  // fetch output
        /*
         * These can be very numerous, so be as efficient as possible.
         */
        StringBuffer buffer = new StringBuffer("\nMethod Exited: ");
        buffer.append(me.method().declaringType().name());
        buffer.append(".");
        buffer.append(me.method().name());
        buffer.append(" ");
        out.print(buffer.toString());
        otherEvent(me);
    }

    public void otherEvent(Event event) {
    }

    public void vmInterrupted() {
        Thread.yield();  // fetch output
        printCurrentLocation();
        Iterator it = monitorCommands.iterator();
        while (it.hasNext()) {
            StringTokenizer t = new StringTokenizer((String)it.next());
            t.nextToken();  // get rid of monitor number
            executeCommand(t);
        }
        printPrompt();
    }

    private void printPrompt() {
        Env.printPrompt();
    }

    private void printCurrentLocation() {
        ThreadInfo tinfo = ThreadInfo.current;
        StackFrame frame;
        try {
            frame = tinfo.getCurrentFrame();
        } catch (IncompatibleThreadStateException exc) {
            out.println("current thread isn't suspended anymore?!?");
            return;
        }
        if (frame == null) {
            out.println("No frames on the current call stack");
        } else {
            Location loc = frame.location();
            out.print("thread=\"" + tinfo.thread.name() +"\"");
            out.print(", ");
            out.println(Commands.locationString(loc));
            // Output the current source line, if possible
            if (loc.lineNumber() != -1) {
                String line;
                try {
                    line = Env.sourceLine(loc, loc.lineNumber());
                } catch (java.io.IOException e) {
                    line = null;
                }
                if (line != null) {
                    out.println("  " + loc.lineNumber() + " " + line);
                }
            }
        }
        out.println();
    }

    void help() {
            out.println("** command list **");
            out.println("run [class [args]]        -- start execution of application's main class");
            out.println();
            out.println("threads [threadgroup]     -- list threads");
            out.println("thread <thread id>        -- set default thread");
            out.println("suspend [thread id(s)]    -- suspend threads (default: all)");
            out.println("resume [thread id(s)]     -- resume threads (default: all)");
            out.println("where [thread id] | all   -- dump a thread's stack");
            out.println("wherei [thread id] | all  -- dump a thread's stack, with pc info");
            out.println("up [n frames]             -- move up a thread's stack");
            out.println("down [n frames]           -- move down a thread's stack");
            out.println("kill <thread> <expr>      -- kill a thread with the given exception object");
            out.println("interrupt <thread>        -- interrupt a thread");
            out.println();
            out.println("print <expr>              -- print value of expression");
            out.println("dump <expr>               -- print all object information");
            out.println("eval <expr>               -- evaluate expression (same as print)");
            out.println("set <lvalue> = <expr>     -- assign new value to field/variable/array element");
            out.println("locals                    -- print all local variables in current stack frame");
            out.println();
            out.println("classes                   -- list currently known classes");
            out.println("class <class id>          -- show details of named class");
            out.println("methods <class id>        -- list a class's methods");
            out.println("fields <class id>         -- list a class's fields");
            out.println();
            out.println("threadgroups              -- list threadgroups");
            out.println("threadgroup <name>        -- set current threadgroup");
            out.println();
            out.println("stop in <class id>.<method>[(argument_type,...)]");
            out.println("                          -- set a breakpoint in a method");
            out.println("stop at <class id>:<line> -- set a breakpoint at a line");
            out.println("clear <class id>.<method>[(argument_type,...)]");
            out.println("                          -- clear a breakpoint in a method");
            out.println("clear <class id>:<line>   -- clear a breakpoint at a line");
            out.println("clear                     -- list breakpoints");
            out.println("catch <class id>          -- break when specified exception thrown");
            out.println("ignore <class id>         -- cancel 'catch'  for the specified exception");
            out.println("watch [access|all] <class id>.<field name>");
            out.println("                          -- watch access/modifications to a field");
            out.println("unwatch [access|all] <class id>.<field name>");
            out.println("                          -- discontinue watching access/modifications to a field");
            out.println("trace methods [thread]    -- trace method entry and exit");
            out.println("untrace methods [thread]  -- stop tracing method entry and exit");
            out.println("step                      -- execute current line");
            out.println("step up                   -- execute until the current method returns to its caller");  
            out.println("stepi                     -- execute current instruction");
            out.println("next                      -- step one line (step OVER calls)");
            out.println("cont                      -- continue execution from breakpoint");
            out.println();
            out.println("list [line number|method] -- print source code");
            out.println("use (or sourcepath) [source file path]");
            out.println("                          -- display or change the source path");
            out.println("exclude [class id ... | \"none\"]");
            out.println("                          -- do not report step or method events for specified classes");
            out.println("classpath                 -- print classpath info from target VM");
            out.println();
            out.println("monitor <command>         -- execute command each time the program stops");
            out.println("monitor                   -- list monitors");
            out.println("unmonitor <monitor#>      -- delete a monitor");
            out.println("read <filename>           -- read and execute a command file");
            out.println();
            out.println("lock <expr>               -- print lock info for an object");
            out.println("threadlocks [thread id]   -- print lock info for a thread");
            out.println();
            out.println("disablegc <expr>          -- prevent garbage collection of an object");
            out.println("enablegc <expr>           -- permit garbage collection of an object");
            out.println();
            out.println("!!                        -- repeat last command");
            out.println("<n> <command>             -- repeat command n times");
            out.println("help (or ?)               -- list commands");
            out.println("version                   -- print version information");
            out.println("exit (or quit)            -- exit debugger");
            out.println();
            out.println("<class id>: full class name with package qualifiers or a ");
            out.println("pattern with a leading or trailing wildcard ('*').");
            out.println("<thread id>: thread number as reported in the 'threads' command");
            out.println("<expr>: a Java(tm) Programming Language expression.");
            out.println("Most common syntax is supported.");
            out.println();
            out.println("Startup commands can be placed in either \"jdb.ini\" or \".jdbrc\"");
            out.println("in user.home or user.dir");

            // Undocumented commands useful for testing:
            //out.println("save [0..9] <expr>        -- save the value of an expression");
            //out.println("lines <class id> [method] -- print executable source lines");
            //out.println("bytecodes <class id>.<method>");
            //out.println("                          -- display the bytecodes of a method");
        }

    /*
     * These commands require a connected VM
     */
    private String[]  disconnectCmds = {
        "run", "catch", "ignore", "stop", "clear", "watch", "unwatch",
        "use", "sourcepath", "quit", "exit", "help", "?", "read",
        "version"
    };

    private boolean isDisconnectCmd(String cmd) {
        for (int i = 0; i < disconnectCmds.length; i++) {
            if (disconnectCmds[i].equals(cmd)) {
                return true;
            }
        }
        return false;
    }

    void executeCommand(StringTokenizer t) {
        String cmd = t.nextToken().toLowerCase();
        Commands evaluator = new Commands(out, eWin);

        // Normally, prompt for the next command after this one is done
        boolean showPrompt = true;

        /*
         * Do this check ahead of time so that it precedes any syntax
         * checking in the command itself. If the command is not
         * properly classified by isDisconnectCmd, the exception catch
         * below will still protect us.
         */
        if (!Env.connection().isOpen() && !isDisconnectCmd(cmd)) {
            out.println("Command '" + cmd + "' is not valid until the VM is started with the 'run' command");
        } else {
            try {
                if (cmd.equals("print")) {
                    evaluator.commandPrint(t, false);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("eval")) {
                    evaluator.commandPrint(t, false);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("set")) {
                    evaluator.commandSet(t);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("dump")) {
                    evaluator.commandPrint(t, true);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("locals")) {
                    evaluator.commandLocals();
                } else if (cmd.equals("classes")) {
                    evaluator.commandClasses();
                } else if (cmd.equals("class")) {
                    evaluator.commandClass(t);
                } else if (cmd.equals("methods")) {
                    evaluator.commandMethods(t);
                } else if (cmd.equals("fields")) {
                    evaluator.commandFields(t);
                } else if (cmd.equals("threads")) {
                    evaluator.commandThreads(t);
                } else if (cmd.equals("thread")) {
                    evaluator.commandThread(t);
                } else if (cmd.equals("suspend")) {
                    evaluator.commandSuspend(t);
                } else if (cmd.equals("resume")) {
                    evaluator.commandResume(t);
                } else if (cmd.equals("cont")) {
                    evaluator.commandCont();
                } else if (cmd.equals("threadgroups")) {
                    evaluator.commandThreadGroups();
                } else if (cmd.equals("threadgroup")) {
                    evaluator.commandThreadGroup(t);
                } else if (cmd.equals("catch")) {
                    evaluator.commandCatchException(t);
                } else if (cmd.equals("ignore")) {
                    evaluator.commandIgnoreException(t);
                } else if (cmd.equals("step")) {
                    evaluator.commandStep(t);
                } else if (cmd.equals("stepi")) {
                    evaluator.commandStepi();
                } else if (cmd.equals("next")) {
                    evaluator.commandNext();
                } else if (cmd.equals("kill")) {
                    evaluator.commandKill(t);
                } else if (cmd.equals("interrupt")) {
                    evaluator.commandInterrupt(t);
                } else if (cmd.equals("trace")) {
                    evaluator.commandTrace(t);
                } else if (cmd.equals("untrace")) {
                    evaluator.commandUntrace(t);
                } else if (cmd.equals("where")) {
                    evaluator.commandWhere(t, false);
                } else if (cmd.equals("wherei")) {
                    evaluator.commandWhere(t, true);
                } else if (cmd.equals("up")) {
                    evaluator.commandUp(t);
                } else if (cmd.equals("down")) {
                    evaluator.commandDown(t);
                } else if (cmd.equals("load")) {
                    evaluator.commandLoad(t);
                } else if (cmd.equals("run")) {
                    evaluator.commandRun(t);
                    /*
                     * Fire up an event handler, if the connection was just
                     * opened. Since this was done from the run command
                     * we don't stop the VM on its VM start event (so
                     * arg 2 is false).
                     */
                      if ((handler == null) && Env.connection().isOpen()) {
                        handler = new EventHandler(this, false,eWin);
                    }
                } else if (cmd.equals("memory")) {
                    evaluator.commandMemory();
                } else if (cmd.equals("gc")) {
                    evaluator.commandGC();
                } else if (cmd.equals("stop")) {
                    evaluator.commandStop(t);
                } else if (cmd.equals("clear")) {
                    evaluator.commandClear(t);
                } else if (cmd.equals("watch")) {
                    evaluator.commandWatch(t);
                } else if (cmd.equals("unwatch")) {
                    evaluator.commandUnwatch(t);
                } else if (cmd.equals("list")) {
                    evaluator.commandList(t);
                } else if (cmd.equals("lines")) {
                    evaluator.commandLines(t);
                } else if (cmd.equals("classpath")) {
                    evaluator.commandClasspath(t);
                } else if (cmd.equals("use") || cmd.equals("sourcepath")) {
                    evaluator.commandUse(t);
                } else if (cmd.equals("monitor")) {
                    monitorCommand(t);
                } else if (cmd.equals("unmonitor")) {
                    unmonitorCommand(t);
                } else if (cmd.equals("lock")) {
                    evaluator.commandLock(t);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("threadlocks")) {
                    evaluator.commandThreadlocks(t);
                } else if (cmd.equals("disablegc")) {
                    evaluator.commandDisableGC(t);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("enablegc")) {
                    evaluator.commandEnableGC(t);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("save")) {
                    evaluator.commandSave(t);
                    showPrompt = false;        // asynchronous command
                } else if (cmd.equals("bytecodes")) {
                    evaluator.commandBytecodes(t);
                } else if (cmd.equals("exclude")) {
                    evaluator.commandExclude(t);
                } else if (cmd.equals("read")) {
                    readCommand(t);
                } else if (cmd.equals("help") || cmd.equals("?")) {
                    help();
                } else if (cmd.equals("version")) {
                    evaluator.commandVersion(progname, version, t);
                } else if (cmd.equals("quit") || cmd.equals("exit")) {
                    if (handler != null) {
                        handler.shutdown();
                    }
                    Env.shutdown();

                } else {
                    if (t.hasMoreTokens()) {
                        try {            
                            int repeat = Integer.parseInt(cmd);
                            String subcom = t.nextToken("");
                            while (repeat-- > 0) {
                                executeCommand(new StringTokenizer(subcom));
                            }
                            return;
                        } catch (NumberFormatException exc) {
                        }
                    }                
                    Env.errorln("Unrecognized command. Try help...");
                }
            } catch (UnsupportedOperationException uoe) {
                out.println("Command '" + cmd + "' is not supported on the target VM");
            } catch (VMNotConnectedException vmnse) {
                out.println("Command '" + cmd + "' is not valid until the VM is started with the 'run' command");
            } catch (Exception e) {
                out.println("Internal exception:");
                out.flush();
                e.printStackTrace();
            }
        }

        if (showPrompt) {
            printPrompt();
        }
    }

    /*
     * Maintain a list of commands to execute each time the VM is suspended.
     */
    void monitorCommand(StringTokenizer t) {
        if (t.hasMoreTokens()) {
            ++monitorCount;
            monitorCommands.add(monitorCount + ": " + t.nextToken(""));
        } else {
            Iterator it = monitorCommands.iterator();
            while (it.hasNext()) {
                out.println((String)it.next());
            }
        }
    }

    void unmonitorCommand(StringTokenizer t) {
        if (t.hasMoreTokens()) {
            String monTok = t.nextToken();
            int monNum;
            try {            
                monNum = Integer.parseInt(monTok);
            } catch (NumberFormatException exc) {
                Env.errorln("Not a monitor number: '" + monTok + "'");
                return;
            }
            String monStr = monTok + ":";
            Iterator it = monitorCommands.iterator();
            while (it.hasNext()) {
                String cmd = (String)it.next();
                StringTokenizer ct = new StringTokenizer(cmd);
                if (ct.nextToken().equals(monStr)) {
                    monitorCommands.remove(cmd);
                    out.println("Unmonitoring " + cmd);
                    return;
                }
            }
            Env.errorln("No monitor numbered: " + monTok);
        } else {
            Env.errorln("usage: unmonitor <monitor#>");
        }            
    }


    void readCommand(StringTokenizer t) {
        if (t.hasMoreTokens()) {
            String cmdfname = t.nextToken();
            if (!readCommandFile(cmdfname)) {
                Env.errorln("Could not open: " + cmdfname);
            }
        } else {
            Env.errorln("usage: read <command-filename>");
        }
    }

    /**
     * Read and execute a command file.  Return true if the
     * file could be opened.
     */
    boolean readCommandFile(String filename) {
        File f = new File(filename);
        BufferedReader inFile = null;
        try {
            if (f.canRead()) {
                Env.out.println("*** Reading commands from " + f.getCanonicalPath());
                // Process initial commands.
                inFile = new BufferedReader(new FileReader(f));
                String ln;
                while ((ln = inFile.readLine()) != null) {
                    StringTokenizer t = new StringTokenizer(ln);
                    if (t.hasMoreTokens()) {
                        executeCommand(t);
                    }
                }
            }
        } catch (IOException e) {
        } finally {
            if (inFile != null) {
                try {
                    inFile.close();
                } catch (Exception exc) {
                }
            }
        }
        return inFile != null;
    }

    public TTY(PrintStream out, EditWin eWin) throws Exception {
        System.out.println("Initializing " + progname + "...");
        this.out = out;
        this.eWin = eWin;
        if (Env.connection().isOpen()) {
            /*
             * Connection opened on startup. Start event handler
             * immediately, telling it (through arg 2) to stop on the
             * VM start event.
             */
            this.handler = new EventHandler(this, true,eWin);
        }
        try {

            BufferedReader in =
                    new BufferedReader(new InputStreamReader(System.in));

            String lastLine = null;

            Thread.currentThread().setPriority(Thread.NORM_PRIORITY);

            /*
             * Try reading user's home startup file. Handle Unix and
             * and Win32 conventions for the names of these files.
             */
            if (!readCommandFile(System.getProperty("user.home") +
                                 File.separator + "jdb.ini")) {
                readCommandFile(System.getProperty("user.home") +
                                File.separator + ".jdbrc");
            }

            // Try startup file in local directory
            if (!readCommandFile(System.getProperty("user.dir") +
                                 File.separator + "jdb.ini")) {
                readCommandFile(System.getProperty("user.dir") +
                               File.separator + ".jdbrc");
            }

            // Process interactive commands.
            printPrompt();
            //while (true) {
                String ln=null;// = in.readLine();
                if (ln == null) {
                   out.println("Input stream closed.");
                   return;
                }

                if (ln.startsWith("!!") && lastLine != null) {
                    ln = lastLine + ln.substring(2);
                    out.println(ln);
                }

                StringTokenizer t = new StringTokenizer(ln);
                if (t.hasMoreTokens()) {
                    lastLine = ln;
                      VMConnection connection = Env.connection();
            if (!connection.isLaunch()) {
            if (!t.hasMoreTokens()) {
                Env.vm().resume();
            } else {
                out.println("'run <args>' command valid only with launched VMs");
            }
            return;
        }
            executeCommand(t);
                } else {
                    printPrompt();
                }

            //}
        } catch (VMDisconnectedException e) {
            handler.handleDisconnectedException();
        }
    }

    private static void usage() {
        String separator = File.pathSeparator;
        System.out.println("Usage: " + progname + " <options> <class> <arguments>");
        System.out.println();
        System.out.println("where options include:");
        System.out.println("    -help             print out this message and exit");
        System.out.println("    -sourcepath <directories separated by \"" +
                           separator + "\">");
        System.out.println("                      directories in which to look for source files");
        System.out.println("    -attach <address>");
        System.out.println("                      attach to a running VM at the specified address using standard connector");
        System.out.println("    -listen <address>");
        System.out.println("                      wait for a running VM to connect at the specified address using standard connector");
        System.out.println("    -listenany");
        System.out.println("                      wait for a running VM to connect at any available address using standard connector");
        System.out.println("    -launch");
        System.out.println("                      launch VM immediately instead of waiting for 'run' command");
        System.out.println("    -connect <connector-name>:<name1>=<value1>,...");
        System.out.println("                      connect to target VM using named connector with listed argument values");
        System.out.println("    -dbgtrace [flags] print info for debugging " + progname);
        System.out.println("    -thotspot         run the application in the Hotspot(tm) Performance Engine");
        System.out.println("    -tclassic         run the application in the Classic VM");
        System.out.println();
        System.out.println("options forwarded to debuggee process:");
        System.out.println("    -v -verbose[:class|gc|jni]");
        System.out.println("                      turn on verbose mode");
        System.out.println("    -D<name>=<value>  set a system property");
        System.out.println("    -classpath <directories separated by \"" +
                           separator + "\">");
        System.out.println("                      list directories in which to look for classes");
        System.out.println("    -X<option>        non-standard target VM option");
        System.out.println();
        System.out.println("<class> is the name of the class to begin debugging");
        System.out.println("<arguments> are the arguments passed to the main() method of <class>");
        System.out.println();
        System.out.println("For command help type 'help' at " + progname + " prompt");
    }

    static void usageError(String message) {
        System.err.println(message);
        System.err.println();
        usage();
        System.exit(1);
    }

    private static Connector findConnector(String transportName, List availableConnectors) {
        Iterator iter = availableConnectors.iterator();
        while (iter.hasNext()) {
            Connector connector = (Connector)iter.next();
            if (connector.transport().name().equals(transportName)) {
                return connector;
            }
        }

        // not found
        throw new IllegalArgumentException("Invalid transport name: " + transportName);
    }

    private static boolean supportsSharedMemory() {
        List connectors = Bootstrap.virtualMachineManager().allConnectors();
        Iterator iter = connectors.iterator();
        while (iter.hasNext()) {

            Connector connector = (Connector)iter.next();
            if (connector.transport().name().equals("dt_shmem")) {
                return true;
            }
        }
        return false;
    }

    private static String addressToSocketArgs(String address) {
        int index = address.indexOf(':');
        if (index != -1) {
            String hostString = address.substring(0, index);
            String portString = address.substring(index + 1);
            return "hostname=" + hostString + ",port=" + portString;
        } else {
            return "port=" + address;
        }
    }

  /*  public static void main(String argv[]) {
        String cmdLine = "";
        String javaArgs = "";
        int traceFlags = VirtualMachine.TRACE_NONE;
        boolean launchImmediately = false;
        String connectSpec = null;
        
        for (int i = 0; i < argv.length; i++) {
            String token = argv[i];
            if (token.equals("-dbgtrace")) {
            if ((i == argv.length - 1) ||
                ! Character.isDigit(argv[i+1].charAt(0))) {
                traceFlags = VirtualMachine.TRACE_ALL;
            } else {
                String flagStr = argv[++i];
                traceFlags = Integer.decode(flagStr).intValue();
            }
        } else if (token.equals("-X")) {
                usageError("Use 'java -X' to see the available non-standard options");
                return;
            } else if (
                   // Standard VM options passed on
                   token.equals("-v") || token.startsWith("-v:") ||  // -v[:...]
                   token.startsWith("-verbose") ||                  // -verbose[:...]
                   token.startsWith("-D") ||
                   // -classpath handled below
                   // NonStandard options passed on
                   token.startsWith("-X") ||
                   // Old-style options (These should remain in place as long as
                   //  the standard VM accepts them)
                   token.equals("-noasyncgc") || token.equals("-prof") ||
                   token.equals("-verify") || token.equals("-noverify") ||
                   token.equals("-verifyremote") ||
                   token.equals("-verbosegc") ||
                   token.startsWith("-ms") || token.startsWith("-mx") ||
                   token.startsWith("-ss") || token.startsWith("-oss") ) {

                javaArgs += token + " ";
            } else if (token.equals("-tclassic")) {
                // -classic must be the first one
                javaArgs = "-classic " + javaArgs;
            } else if (token.equals("-thotspot")) {
                // -hotspot must be the first one
                javaArgs = "-hotspot " + javaArgs;
            } else if (token.equals("-sourcepath")) {
                if (i == (argv.length - 1)) {
                    usageError("No sourcepath specified.");
                    return;
                }
                Env.setSourcePath(argv[++i]);
            } else if (token.equals("-classpath")) {
                if (i == (argv.length - 1)) {
                    usageError("No classpath specified.");
                    return;
                }
                javaArgs += token + " " + argv[++i] + " ";
            } else if (token.equals("-attach")) {
                if (connectSpec != null) {
                    usageError(token + " can't redefine existing connection");
                    return;
                }
                if (i == (argv.length - 1)) {
                    usageError("No attach address specified.");
                    return;
                }
                String address = argv[++i];

                /*
                 * -attach is shorthand for one of the reference implementation's
                 * attaching connectors. Use the shared memory attach if it's
                 * available; otherwise, use sockets. Build a connect
                 * specification string based on this decision.
                 *
                if (supportsSharedMemory()) {
                    connectSpec = "com.sun.jdi.SharedMemoryAttach:name=" +
                                   address;
                } else {
                    String suboptions = addressToSocketArgs(address);
                    connectSpec = "com.sun.jdi.SocketAttach:" + suboptions;
                }
            } else if (token.equals("-listen") || token.equals("-listenany")) {
                if (connectSpec != null) {
                    usageError(token + " can't redefine existing connection");
                    return;
                }
                String address = null;
                if (token.equals("-listen")) {
                    if (i == (argv.length - 1)) {
                        usageError("No attach address specified.");
                        return;
                    }
                    address = argv[++i];
                }

                /*
                 * -listen[any] is shorthand for one of the reference implementation's
                 * listening connectors. Use the shared memory listen if it's
                 * available; otherwise, use sockets. Build a connect
                 * specification string based on this decision.
                 *
                if (supportsSharedMemory()) {
                    connectSpec = "com.sun.jdi.SharedMemoryListen";
                    if (address != null) {
                        connectSpec += (":name=" + address);
                    }
                } else {
                    String suboptions = addressToSocketArgs(address);
                    connectSpec = "com.sun.jdi.SocketListen";
                    if (address != null) {
                        connectSpec += (":port=" + address);
                    }
                }
            } else if (token.equals("-launch")) {
                launchImmediately = true;
            } else if (token.equals("-connect")) {
                /*
                 * -connect allows the user to pick the connector
                 * used in bringing up the target VM. This allows 
                 * use of connectors other than those in the reference
                 * implementation.
                 *
                if (connectSpec != null) {
                    usageError(token + " can't redefine existing connection");
                    return;
                }
                if (i == (argv.length - 1)) {
                    usageError("No connect specification.");
                    return;
                }
                connectSpec = argv[++i];
            } else if (token.equals("-help")) {
                usage();
                System.exit(0);
            } else if (token.equals("-version")) {
                System.out.println(progname + " version " + version);
                System.exit(0);
            } else if (token.startsWith("-")) {
                usageError("invalid option: " + token);
                return;
            } else {
                // Everything from here is part of the command line
                cmdLine = token + " ";
                for (i++; i < argv.length; i++) {
                    cmdLine += argv[i] + " ";
                }
                break;
            }
        }

        /*
         * Unless otherwise specified, set the default connect spec.
         *
        if (connectSpec == null) {
            connectSpec = "com.sun.jdi.CommandLineLaunch:";
        }

        cmdLine = cmdLine.trim();
        javaArgs = javaArgs.trim();

        if (cmdLine.length() > 0) {
            if (!connectSpec.startsWith("com.sun.jdi.CommandLineLaunch:")) {
                usageError("Cannot specify command line with connector: " + connectSpec);
                return;
            }
            connectSpec += "main=" + cmdLine + ",";
        }

        if (javaArgs.length() > 0) {
            if (!connectSpec.startsWith("com.sun.jdi.CommandLineLaunch:")) {
                usageError("Cannot specify target VM arguments with connector: " + connectSpec);
                return;
            }
            connectSpec += "options=" + javaArgs + ",";
        }

        try {
            Env.out = System.out;
            Env.init(connectSpec, launchImmediately, traceFlags);
            new TTY(Env.out);
        } catch(Exception e) {
            System.out.print("Internal exception:  ");
            System.out.flush();
            e.printStackTrace();
        }
    }     */
}


