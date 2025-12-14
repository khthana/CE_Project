package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.EventRequest;
import com.sun.jdi.request.ClassPrepareRequest;
import com.sun.jdi.event.ClassPrepareEvent;
import java.util.List;
import java.util.Iterator;

abstract class EventRequestSpec {

    final ReferenceTypeSpec refSpec;

    int suspendPolicy = EventRequest.SUSPEND_ALL;

    EventRequest resolved = null;
    ClassPrepareRequest prepareRequest = null;

    EventRequestSpec(ReferenceTypeSpec refSpec) {
        this.refSpec = refSpec;
    }

    /**
     * The 'refType' is known to match, return the EventRequest.
     */
    abstract EventRequest resolveEventRequest(ReferenceType refType) 
                                           throws Exception;

    /**
     * @return If this EventRequestSpec matches the 'refType'
     * return the cooresponding EventRequest.  Otherwise
     * return null.
     */
    synchronized EventRequest resolve(ClassPrepareEvent event) throws Exception {
        if ((resolved == null) && 
            (prepareRequest != null) &&
            prepareRequest.equals(event.request())) {

            resolved = resolveEventRequest(event.referenceType());
            prepareRequest.disable();
            prepareRequest = null;
        }
        return resolved;
    }   

    private EventRequest resolveAgainstPreparedClasses() throws Exception {
        Iterator iter = Env.vm().allClasses().iterator();
        while ((resolved == null) && iter.hasNext()) {
            ReferenceType refType = (ReferenceType)iter.next();
            if (refType.isPrepared() && refSpec.matches(refType)) {
                resolved = resolveEventRequest(refType);
            }
        }
        return resolved;
    }

    synchronized EventRequest resolveEagerly() throws Exception {
        try {
            resolveAgainstPreparedClasses();
            if (resolved == null) {
                prepareRequest = refSpec.createPrepareRequest();
                prepareRequest.enable();
    
                // Try again in case the class became resolvable between
                // the first attampt and the deferResolution()
                resolveAgainstPreparedClasses();
                if (resolved != null) {
                    prepareRequest.disable();
                    prepareRequest = null;
                }
            }
        } catch (VMNotConnectedException e) {
            // Do nothing. Another resolve will be attempted when the 
            // VM is started.
        }
        return resolved;
    }

    /**
     * @return the eventRequest this spec has been resolved to,
     * null if so far unresolved.
     */
    EventRequest resolved() {
        return resolved;
    }

    /**
     * @return true if this spec has been resolved.
     */
    boolean isResolved() {
        return resolved != null;
    }

    protected boolean isJavaIdentifier(String s) {
        if (s.length() == 0) {                              
            return false;
        }

        if (! Character.isJavaIdentifierStart(s.charAt(0))) {
            return false;
        }

        for (int i = 1; i < s.length(); i++) {
            if (! Character.isJavaIdentifierPart(s.charAt(i))) {
                return false;
            }
        }

        return true;
    }

    String errorMessageFor(Exception e) { 
        if (e instanceof IllegalArgumentException) {
            return ("Invalid command syntax");
        } else if (e instanceof RuntimeException) {
            // A runtime exception that we were not expecting
            throw (RuntimeException)e;
        } else {
            return ("Internal error; unable to set" + this);
        } 
    }
}


