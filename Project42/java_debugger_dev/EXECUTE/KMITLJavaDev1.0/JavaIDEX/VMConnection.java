package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.connect.*;
import com.sun.jdi.request.EventRequestManager;
import com.sun.jdi.request.ExceptionRequest;

import java.util.*;
import java.io.*;
import javax.swing.*;

class VMConnection {

    private VirtualMachine vm;    
    private Process process = null;
    private int outputCompleteCount = 0;

    private final Connector connector;
    private final Map connectorArgs;
    private final int traceFlags;

    synchronized void notifyOutputComplete() {
        outputCompleteCount++;
        notifyAll();
    }

    synchronized void waitOutputComplete() {
        // Wait for stderr and stdout
        if (process != null) {
            while (outputCompleteCount < 2) {
                try {wait();} catch (InterruptedException e) {}
            }
        }
    }

    private Connector findConnector(String name) {
        List connectors = Bootstrap.virtualMachineManager().allConnectors();
        Iterator iter = connectors.iterator();
        while (iter.hasNext()) {
            Connector connector = (Connector)iter.next();
            String temp = connector.name();
            if (connector.name().equals(name)) {

                return connector;
            }
        }
        return null;
    }

    private Map parseConnectorArgs(Connector connector, String argString) {
        StringTokenizer tokenizer = new StringTokenizer(argString, ",");
        Map arguments = connector.defaultArguments();

        while (tokenizer.hasMoreTokens()) {
            String token = tokenizer.nextToken();
            int index = token.indexOf('=');
            if (index == -1) {
                throw new IllegalArgumentException("Illegal connector argument: " +
                                                   token);
            }
            String name = token.substring(0, index);
            String value = token.substring(index + 1);
            Connector.Argument argument = (Connector.Argument)arguments.get(name);
            if (argument == null) {
                throw new IllegalArgumentException("Argument " + name + 
                                               "is not defined for connector: " +
                                               connector.name());
            }
            argument.setValue(value);
        }
        return arguments;
    }

    VMConnection(String connectSpec, int traceFlags) {
        String nameString;
        String argString;
        int index = connectSpec.indexOf(':');
        if (index == -1) {
            nameString = connectSpec;
            argString = "";
        } else {
            nameString = connectSpec.substring(0, index);
            argString = connectSpec.substring(index + 1);
        }

        connector = findConnector(nameString);
        if (connector == null) {
            throw new IllegalArgumentException("No connector named: " + 
                                               nameString);
        } 

        connectorArgs = parseConnectorArgs(connector, argString);
        this.traceFlags = traceFlags;
    }
        
    synchronized VirtualMachine open() {
        if (connector instanceof LaunchingConnector) {
            vm = launchTarget();
        } else if (connector instanceof AttachingConnector) {
            vm = attachTarget();
            // Allow debugger operations like 'cont'
            ThreadInfo.setCurrentThread(ThreadInfo.getThread(1).thread);
        } else if (connector instanceof ListeningConnector) {
            vm = listenTarget();
            // Allow debugger operations like 'cont'
            ThreadInfo.setCurrentThread(ThreadInfo.getThread(1).thread);
        } else {
            throw new InternalError("Invalid connect type");
        }
        vm.setDebugTraceMode(traceFlags);
        setEventRequests(vm);
        resolveEventRequests();
//          Env.out.println("Connected to " + target);
        return vm;
    }

    boolean setConnectorArg(String name, String value) {
        /*
         * Too late if the connection already made
         */
        if (vm != null) {
            return false;
        }

        Connector.Argument argument = (Connector.Argument)connectorArgs.get(name);
        if (argument == null) {
            return false;
        }
        argument.setValue(value);
        return true;
    }

    String connectorArg(String name) {
        Connector.Argument argument = (Connector.Argument)connectorArgs.get(name);
        if (argument == null) {
            return "";
        }
        return argument.value();
    }

    public synchronized VirtualMachine vm() {
        if (vm == null) {
            throw new VMNotConnectedException();
        } else {
            return vm;
        }
    }

    boolean isOpen() {
        return (vm != null);
    }

    boolean isLaunch() {
        return (connector instanceof LaunchingConnector);
    }

    public void disposeVM() {
        try {
            if (vm != null) {
                vm.dispose();
                vm = null;
            }
        } finally {
            if (process != null) {
                process.destroy();
                process = null;
            }
            waitOutputComplete();
        }
    }

    private void setEventRequests(VirtualMachine vm) {
        EventRequestManager erm = vm.eventRequestManager();
        // want all uncaught exceptions
        ExceptionRequest excReq = erm.createExceptionRequest(null, 
                                                             false, true); 
        excReq.enable();
    }

    private void resolveEventRequests() {
        Env.specList.resolveAll();
    }

    private void dumpStream(InputStream stream) throws IOException {
        PrintStream outStream = Env.out;
        BufferedReader in =
            new BufferedReader(new InputStreamReader(stream));
        String line;
        JDialog debugOutput = new JDialog();
        debugOutput.setTitle("Output");
        JTextArea outputText = new JTextArea();
        debugOutput.getContentPane().add(outputText);
        while ((line = in.readLine()) != null) {
            outStream.println(line);
            outputText.append(line);
        }

    }

    /**	
     *	Create a Thread that will retrieve and display any output.
     *	Needs to be high priority, else debugger may exit before
     *	it can be displayed.
     */
    private void displayRemoteOutput(final InputStream stream) {
	Thread thr = new Thread("output reader") { 
	    public void run() {
                try {
                    dumpStream(stream);
                } catch (IOException ex) {
                    Env.fatalError("Failed reading output of child java interpreter.");
                } finally {
                    notifyOutputComplete();
                }
	    }
	};
	thr.setPriority(Thread.MAX_PRIORITY-1);
	thr.start();
    }

    private void dumpFailedLaunchInfo(Process process) {
        try {
            dumpStream(process.getErrorStream());
            dumpStream(process.getInputStream());
        } catch (IOException e) {
            System.err.println("Unable to display process output: " +
                               e.getMessage());
        }
    }

    /* launch child target vm */
    private VirtualMachine launchTarget() {
        LaunchingConnector launcher = (LaunchingConnector)connector;
        try {
            VirtualMachine vm = launcher.launch(connectorArgs);
            process = vm.process();
            displayRemoteOutput(process.getErrorStream());
            displayRemoteOutput(process.getInputStream());
            return vm;
        } catch (IOException ioe) {
            ioe.printStackTrace();
            Env.fatalError("\n Unable to launch target VM.");
        } catch (IllegalConnectorArgumentsException icae) {
            icae.printStackTrace();
            Env.fatalError("\n Internal debugger error.");
        } catch (VMStartException vmse) {
            System.err.println(vmse.getMessage() + "\n");
            dumpFailedLaunchInfo(vmse.process());
            Env.fatalError("\n Target VM failed to initialize.");
        }
        return null; // Shuts up the compiler
    }

    /* attach to running target vm */
    private VirtualMachine attachTarget() {
        AttachingConnector attacher = (AttachingConnector)connector;
        try {
            return attacher.attach(connectorArgs);
        } catch (IOException ioe) {
            ioe.printStackTrace();
            Env.fatalError("\n Unable to attach to target VM.");
        } catch (IllegalConnectorArgumentsException icae) {
            icae.printStackTrace();
            Env.fatalError("\n Internal debugger error.");
        }
        return null; // Shuts up the compiler
    }

    /* listen for connection from target vm */
    private VirtualMachine listenTarget() {
        ListeningConnector listener = (ListeningConnector)connector;
        try {
            String retAddress = listener.startListening(connectorArgs);
            System.out.println("Listening at address: " + retAddress);
            vm = listener.accept(connectorArgs);
            listener.stopListening(connectorArgs);
            return vm;
        } catch (IOException ioe) {
            ioe.printStackTrace();
            Env.fatalError("\n Unable to attach to target VM.");
        } catch (IllegalConnectorArgumentsException icae) {
            icae.printStackTrace();
            Env.fatalError("\n Internal debugger error.");
        }
        return null; // Shuts up the compiler
    }
}
