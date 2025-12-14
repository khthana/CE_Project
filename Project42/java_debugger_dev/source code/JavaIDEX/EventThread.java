package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.*;
import com.sun.jdi.event.*;

public class EventThread extends Thread {
  private final VirtualMachine vm;

  public EventThread(VirtualMachine vm) {
    super("event-handler");
    this.vm = vm;
  }

  void setEventRequests() {
        EventRequestManager erm = vm.eventRequestManager();
        //I'm not sure with the following 3 lines.
        //StepRequest stepReq = erm.createStepRequest(null,true,true);
        //stepReq.setSuspendPolicy(EventRequest.SUSPEND_NONE);
        //stepReq.enable();

        MethodEntryRequest menr = erm.createMethodEntryRequest();
        menr.setSuspendPolicy(EventRequest.SUSPEND_NONE);
        menr.enable();

        MethodExitRequest mexr = erm.createMethodExitRequest();
        mexr.setSuspendPolicy(EventRequest.SUSPEND_NONE);
        mexr.enable();
  }
}
