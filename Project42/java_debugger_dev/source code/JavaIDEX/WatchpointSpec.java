package JavaIDEX;

import com.sun.jdi.*;

abstract class WatchpointSpec extends EventRequestSpec {
    final String fieldId;

    WatchpointSpec(ReferenceTypeSpec refSpec, String fieldId) 
                                       throws MalformedMemberNameException {
        super(refSpec);
        this.fieldId = fieldId;
        if (!isJavaIdentifier(fieldId)) {
            throw new MalformedMemberNameException(fieldId);
        }
    }

    public int hashCode() {
        return refSpec.hashCode() + fieldId.hashCode() + 
            getClass().hashCode();
    }

    public boolean equals(Object obj) {
        if (obj instanceof WatchpointSpec) {
            WatchpointSpec watchpoint = (WatchpointSpec)obj;

            return fieldId.equals(watchpoint.fieldId) &&
                   refSpec.equals(watchpoint.refSpec) &&
                   getClass().equals(watchpoint.getClass());
        } else {
            return false;
        }
    }

    String errorMessageFor(Exception e) { 
        if (e instanceof NoSuchFieldException) {
            return ("No field " + fieldId + " in " + refSpec);
        } else {
            return super.errorMessageFor(e);
        } 
    }
}


