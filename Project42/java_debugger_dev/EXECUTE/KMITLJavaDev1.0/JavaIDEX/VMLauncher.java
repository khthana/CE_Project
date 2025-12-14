package JavaIDEX;

import com.sun.jdi.VirtualMachine;
import com.sun.jdi.connect.*;
import com.sun.jdi.event.*;
import com.sun.jdi.Bootstrap;


import java.io.IOException;

import java.util.Map;
import java.util.Iterator;
import java.util.List;

public class VMLauncher{
    // Running remote VM
   public  VirtualMachine debuggeeVM;
   public Thread myThread = null;
   public Thread outThread = null;
   public Thread errThread = null;

   public VMLauncher(String classArgs,boolean op,String opFile,boolean all, boolean field) {
    debuggeeVM = launchTarget(classArgs);
    System.out.println("Initializing debuggee virtual machine....");
    redirectOutput();
    debuggeeVM.resume();
    try {
	    errThread.join(); // Make sure output is forwarded
	    outThread.join(); // before we exit
  	} catch (InterruptedException exc) {
	     //we don't interrupt
 	  }
  }

  VirtualMachine launchTarget(String mainArgs) {
    LaunchingConnector connector = findLaunchingConnector();
    Map arguments = connectorArguments(connector,mainArgs);
    try {
	    return connector.launch(arguments);
        } catch (IOException exc) {
            throw new Error("Unable to launch target VM: " + exc);
        } catch (IllegalConnectorArgumentsException exc) {
            throw new Error("Internal error: " + exc);
        } catch (VMStartException exc) {
            throw new Error("Target VM failed to initialize: " +
			    exc.getMessage());
    }
  }

  LaunchingConnector findLaunchingConnector() {
    List connectors = Bootstrap.virtualMachineManager().allConnectors();
    Iterator iter = connectors.iterator();
    while (iter.hasNext()) {
      Connector connector = (Connector)iter.next();
      if (connector.name().equals("com.sun.jdi.CommandLineLaunch")) {
        return (LaunchingConnector)connector;
      }
    }
    throw new Error("No launching connector");

  }

  Map connectorArguments(LaunchingConnector connector,String mainArgs) {
    Map arguments = connector.defaultArguments();
    Connector.Argument mainArg = (Connector.Argument)arguments.get("main");
    if (mainArg == null) {
      throw new Error("Bad launching connector");
    }
  	mainArg.setValue(mainArgs);
	  return arguments;
  }

  void redirectOutput() {
        Process process = debuggeeVM.process();

        // Copy target's output and error to our output and error.
        errThread = new StreamRedirectThread("error reader",
                                             process.getErrorStream(),
                                             System.err);
        outThread = new StreamRedirectThread("output reader",
                                             process.getInputStream(),
                                             System.out);
        errThread.start();
        outThread.start();
    }

}
