package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.ClassPrepareRequest;

interface ReferenceTypeSpec {
    /**
     * Does the specified ReferenceType match this spec.
     */
    boolean matches(ReferenceType refType);
    ClassPrepareRequest createPrepareRequest();

    int hashCode();

    boolean equals(Object obj);
}


