package JavaIDEX;

import com.sun.jdi.ReferenceType;
import com.sun.jdi.request.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

class ExceptionSpec extends EventRequestSpec {

    ExceptionSpec(ReferenceTypeSpec refSpec) {
        super(refSpec);
    }

    /**
     * The 'refType' is known to match, return the EventRequest.
     */
    EventRequest resolveEventRequest(ReferenceType refType) {
        EventRequestManager em = refType.virtualMachine().eventRequestManager();
        ExceptionRequest excReq = em.createExceptionRequest(refType, 
                                                            true, true);
        excReq.enable();
        return excReq;
    }


    public int hashCode() {
        return refSpec.hashCode();
    }

    public boolean equals(Object obj) {
        if (obj instanceof ExceptionSpec) {
            ExceptionSpec es = (ExceptionSpec)obj;

            return refSpec.equals(es.refSpec);
        } else {
            return false;
        }
    }

    public String toString() {
        StringBuffer buffer = new StringBuffer("exception catch ");
        buffer.append(refSpec.toString());
        return buffer.toString();
    }
}
