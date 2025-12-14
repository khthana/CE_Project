package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.EventRequest;
import com.sun.jdi.event.ClassPrepareEvent;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

class EventRequestSpecList {

    private static final int statusResolved = 1;
    private static final int statusUnresolved = 2;
    private static final int statusError = 3;
    
    // all specs
    private List eventRequestSpecs = Collections.synchronizedList(
                                                  new ArrayList());

    EventRequestSpecList() {
    }

    /** 
     * Resolve all deferred eventRequests waiting for 'refType'.
     * @return true if it completes successfully, false on error.
     */
    boolean resolve(ClassPrepareEvent event) {
        boolean failure = false;
        synchronized(eventRequestSpecs) {
            Iterator iter = eventRequestSpecs.iterator();
            while (iter.hasNext()) {
                EventRequestSpec spec = (EventRequestSpec)iter.next();
                if (!spec.isResolved()) {
                    try {
                        EventRequest eventRequest = spec.resolve(event);
                        if (eventRequest != null) {
                            Env.noticeln("Set deferred " + eventRequest);
                        }
                    } catch (Exception e) {
                        Env.errorln("Unable to set deferred "  + spec + " : " +
                                    spec.errorMessageFor(e));
                        failure = true;
                    }
                }
            }
        }
        return !failure;
    }

    void resolveAll() {
        Iterator iter = eventRequestSpecs.iterator();
        while (iter.hasNext()) {
            EventRequestSpec spec = (EventRequestSpec)iter.next();
            try {
                EventRequest eventRequest = spec.resolveEagerly();
                if (eventRequest != null) {
                    Env.noticeln("Set deferred" + eventRequest);
                } 
            } catch (Exception e) {
            }
        }
    }

    boolean addEagerlyResolve(EventRequestSpec spec) {
        try {
            eventRequestSpecs.add(spec);
            EventRequest eventRequest = spec.resolveEagerly();
            if (eventRequest != null) {
                Env.noticeln("Set " + eventRequest);
            } 
            return true;
        } catch (Exception exc) {
            Env.errorln("Unable to set " + spec + " : " +
                        spec.errorMessageFor(exc));
            return false;
        }
    }

    void add(EventRequestSpec spec) {
        eventRequestSpecs.add(spec);
    }        
        
    EventRequestSpec createBreakpoint(String classPattern, 
                                 int line) throws ClassNotFoundException {
        ReferenceTypeSpec refSpec = 
            new PatternReferenceTypeSpec(classPattern);
        return new BreakpointSpec(refSpec, line);
    }
        
    EventRequestSpec createBreakpoint(String classPattern, 
                                 String methodId, 
                                 List methodArgs) 
                                throws MalformedMemberNameException,
                                       ClassNotFoundException {
        ReferenceTypeSpec refSpec = 
            new PatternReferenceTypeSpec(classPattern);
        return new BreakpointSpec(refSpec, methodId, methodArgs);
    }
        
    EventRequestSpec createExceptionCatch(String classPattern)
                                            throws ClassNotFoundException {
        ReferenceTypeSpec refSpec = 
            new PatternReferenceTypeSpec(classPattern);
        return new ExceptionSpec(refSpec);
    }
        
    EventRequestSpec createAccessWatchpoint(String classPattern, 
                                       String fieldId) 
                                      throws MalformedMemberNameException, 
                                             ClassNotFoundException {
        ReferenceTypeSpec refSpec = 
            new PatternReferenceTypeSpec(classPattern);
        return new AccessWatchpointSpec(refSpec, fieldId);
    }
        
    EventRequestSpec createModificationWatchpoint(String classPattern, 
                                       String fieldId) 
                                      throws MalformedMemberNameException, 
                                             ClassNotFoundException {
        ReferenceTypeSpec refSpec = 
            new PatternReferenceTypeSpec(classPattern);
        return new ModificationWatchpointSpec(refSpec, fieldId);
    }

    boolean delete(EventRequestSpec proto) {
        synchronized (eventRequestSpecs) {
            int inx = eventRequestSpecs.indexOf(proto);
            if (inx != -1) {
                EventRequestSpec spec = (EventRequestSpec)eventRequestSpecs.get(inx);
                eventRequestSpecs.remove(inx);
                if (spec.isResolved()) {
                    Env.vm().eventRequestManager().deleteEventRequest(spec.resolved());
                }
                return true;
            } else {
                return false;
            }
        }
    }

    List eventRequestSpecs() {
       // We need to make a copy to avoid synchronization problems
        synchronized (eventRequestSpecs) {
            return new ArrayList(eventRequestSpecs);
        }
    }
}



