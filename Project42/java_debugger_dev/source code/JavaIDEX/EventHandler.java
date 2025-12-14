package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.event.*;
import com.sun.jdi.request.EventRequestManager;
import com.sun.jdi.request.EventRequest;

import java.io.PrintStream;
import java.util.StringTokenizer;
import java.util.Collection;
import java.util.Iterator;

public class EventHandler implements Runnable {

    EventNotifier notifier;
    //TTY notifier;
    Thread thread;
    volatile boolean connected = true;
    boolean completed = false;
    String shutdownMessage;
    boolean stopOnVMStart;
    EditWin eWin;

    EventHandler(EventNotifier notifier/*TTY notifier*/, boolean stopOnVMStart,EditWin eWin) {
        this.notifier = notifier;
        this.stopOnVMStart = stopOnVMStart;
        this.thread = new Thread(this, "event-handler");
        this.eWin = eWin;
        this.thread.start();

    }

    synchronized void shutdown() {
        connected = false;  // force run() loop termination
        thread.interrupt();
        while (!completed) {
            try {wait();} catch (InterruptedException exc) {}
        }
    }

    public void run() {
        EventQueue queue = Env.vm().eventQueue();
        while (connected) {
            try {
                EventSet eventSet = queue.remove();
//              System.err.println("Got Event Set, policy = " + eventSet.suspendPolicy());
                boolean resumeStoppedApp = false;
                EventIterator it = eventSet.eventIterator();
                while (it.hasNext()) {
                    resumeStoppedApp |= !handleEvent(it.nextEvent());
                }

                if (resumeStoppedApp) {
                    eWin.debugPane.stopIt();
                    eventSet.resume();

                } else if (eventSet.suspendPolicy() == EventRequest.SUSPEND_ALL) {
                    setCurrentThread(eventSet);
                    notifier.vmInterrupted();

                }
            } catch (InterruptedException exc) {
                // Do nothing. Any changes will be seen at top of loop.
            } catch (VMDisconnectedException discExc) {
                handleDisconnectedException();
                break;
            }
        }
        synchronized (this) {
            completed = true;
            notifyAll();
        }
    }

    private boolean handleEvent(Event event) {
        if (event instanceof ExceptionEvent) {
            return exceptionEvent(event);
        } else if (event instanceof BreakpointEvent) {
            return breakpointEvent(event);
        } else if (event instanceof WatchpointEvent) {
            return fieldWatchEvent(event);
        } else if (event instanceof StepEvent) {
            return stepEvent(event);
        } else if (event instanceof MethodEntryEvent) {
            return methodEntryEvent(event);
        } else if (event instanceof MethodExitEvent) {
            return methodExitEvent(event);
        } else if (event instanceof ClassPrepareEvent) {
            return classPrepareEvent(event);
        } else if (event instanceof VMStartEvent) {
            return vmStartEvent(event);
        } else {
            return handleExitEvent(event);
        }
    }

    private boolean vmDied = false;
    private boolean handleExitEvent(Event event) {
        if (event instanceof VMDeathEvent) {
            vmDied = true;

            return vmDeathEvent(event);
        } else if (event instanceof VMDisconnectEvent) {
            connected = false;
            if (!vmDied) {
                vmDisconnectEvent(event);
            }
            Env.shutdown(shutdownMessage);
            return false;
        } else {
//          out.println("ignoring event of kind " + event);
            return false;
        }
    }

    synchronized void handleDisconnectedException() {
        /*
         * A VMDisconnectedException has happened while dealing with
         * another event. We need to flush the event queue, dealing only
         * with exit events (VMDeath, VMDisconnect) so that we terminate
         * correctly.
         */
        EventQueue queue = Env.vm().eventQueue();
        while (connected) {
            try {
                EventSet eventSet = queue.remove();
                EventIterator iter = eventSet.eventIterator();
                while (iter.hasNext()) {
                    handleExitEvent((Event)iter.next());
                }
            } catch (InterruptedException exc) {
                // ignore
            }
        }
    }

    private ThreadReference eventThread(Event event) {
        if (event instanceof ClassPrepareEvent) {
            return ((ClassPrepareEvent)event).thread();
        } else if (event instanceof LocatableEvent) {
            return ((LocatableEvent)event).thread();
        } else if (event instanceof ThreadStartEvent) {
            return ((ThreadStartEvent)event).thread();
        } else if (event instanceof ThreadDeathEvent) {
            return ((ThreadDeathEvent)event).thread();
        } else if (event instanceof VMStartEvent) {
            return ((VMStartEvent)event).thread();
        } else {
            return null;
        }
    }

    private void setCurrentThread(EventSet set) {
        ThreadReference thread;
        if (set.size() > 0) {
            /*
             * If any event in the set has a thread associated with it, 
             * they all will, so just grab the first one. 
             */
            Event event = (Event)set.iterator().next(); // Is there a better way?
            thread = eventThread(event);
        } else {
            thread = null;
        }
        setCurrentThread(thread);
    }

    private void setCurrentThread(ThreadReference thread) {
        ThreadInfo.invalidateAll();
        ThreadInfo.setCurrentThread(thread); 
    }

    private boolean vmStartEvent(Event event)  {
        VMStartEvent se = (VMStartEvent)event;
        notifier.vmStartEvent(se);
        return stopOnVMStart;
    }

    private boolean breakpointEvent(Event event)  {
        BreakpointEvent be = (BreakpointEvent)event;
        notifier.breakpointEvent(be);
        return true;
    }

    private boolean methodEntryEvent(Event event)  {
        MethodEntryEvent me = (MethodEntryEvent)event;
        notifier.methodEntryEvent(me);
        return true;
    }

    private boolean methodExitEvent(Event event)  {
        MethodExitEvent me = (MethodExitEvent)event;
        notifier.methodExitEvent(me);
        return true;
    }

    private boolean fieldWatchEvent(Event event)  {
        WatchpointEvent fwe = (WatchpointEvent)event;
        notifier.fieldWatchEvent(fwe);
        return true;
    }

    private boolean stepEvent(Event event)  {
        StepEvent se = (StepEvent)event;
        notifier.stepEvent(se);
        return true;
    }

    private boolean classPrepareEvent(Event event)  {
        ClassPrepareEvent cle = (ClassPrepareEvent)event;

        if (!Env.specList.resolve(cle)) {
            Env.errorln("\nStopping due to deferred breakpoint errors.\n");
            notifier.otherEvent(event);
            return true;
        } else {
//            out.print("ignoring event. ");
            return false;
        }
    }

    private boolean exceptionEvent(Event event) {
        ExceptionEvent ee = (ExceptionEvent)event;
        notifier.exceptionEvent(ee);
        return true;
    }

    private boolean threadDeathEvent(Event event) {
        ThreadDeathEvent tee = (ThreadDeathEvent)event;
        ThreadReference thread = tee.thread();
        if (ThreadInfo.current != null && 
                  ThreadInfo.current.equals(thread)) {

            String currentThreadName;
            
            // Be careful getting the thread name. If this event happens
            // as part of VM termination, it may be too late to get the 
            // information, and an exception will be thrown.
            try {
               currentThreadName = " \"" + thread.name() + "\"";
            } catch (Exception e) {
               currentThreadName = "";
            }
                 
            setCurrentThread((ThreadReference)null);

            Env.errorln("");
            Env.errorln("Current thread" + currentThreadName + 
                        " died. Execution continuing...");
        }
        return false;
    }

    public boolean vmDeathEvent(Event event) {
        shutdownMessage = "\nThe application exited";
        return false;
    }

    public boolean vmDisconnectEvent(Event event) {
        shutdownMessage = "\nThe application has been disconnected";
        return false;
    }
}
