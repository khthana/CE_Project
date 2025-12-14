package JavaIDEX;

import com.sun.jdi.event.*;

interface EventNotifier {
    void vmStartEvent(VMStartEvent se);
    void breakpointEvent(BreakpointEvent be);
    void fieldWatchEvent(WatchpointEvent fwe);
    void stepEvent(StepEvent se);
    void exceptionEvent(ExceptionEvent ee);
    void otherEvent(Event event);
    void vmInterrupted();
    void methodEntryEvent(MethodEntryEvent me);
    void methodExitEvent(MethodExitEvent me);
}

