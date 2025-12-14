package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.ClassPrepareRequest;
import java.util.StringTokenizer;


class PatternReferenceTypeSpec implements ReferenceTypeSpec {
    final String classId;
    String stem;

    PatternReferenceTypeSpec(String classId) throws ClassNotFoundException {
        this.classId = classId;
        stem = classId;
        if (classId.startsWith("*")) {
            stem = stem.substring(1);
        } else if (classId.endsWith("*")) {
            stem = stem.substring(0, classId.length() - 1);
        } 
        checkClassName(stem);
    }

    /**
     * Does the specified ReferenceType match this spec.
     */
    public boolean matches(ReferenceType refType) {
        if (classId.startsWith("*")) {
            return refType.name().endsWith(stem);
        } else if (classId.endsWith("*")) {
            return refType.name().startsWith(stem);
        } else {
            return refType.name().equals(classId);
        }
    }

    public ClassPrepareRequest createPrepareRequest() {
        ClassPrepareRequest request = 
            Env.vm().eventRequestManager().createClassPrepareRequest();
        request.addClassFilter(classId);
        request.addCountFilter(1);
        return request;
    }

    public int hashCode() {
        return classId.hashCode();
    }

    public boolean equals(Object obj) {
        if (obj instanceof PatternReferenceTypeSpec) {
            PatternReferenceTypeSpec spec = (PatternReferenceTypeSpec)obj;

            return classId.equals(spec.classId);
        } else {
            return false;
        }
    }

    private void checkClassName(String className) throws ClassNotFoundException {
        // Do stricter checking of class name validity on deferred
        //  because if the name is invalid, it will
        // never match a future loaded class, and we'll be silent
        // about it.
        StringTokenizer tokenizer = new StringTokenizer(className, ".");
        while (tokenizer.hasMoreTokens()) {
            String token = tokenizer.nextToken();
            // Each dot-separated piece must be a valid identifier
            // and the first token can also be "*". (Note that 
            // numeric class ids are not permitted. They must
            // match a loaded class.)
            if (!isJavaIdentifier(token)) {
                throw new ClassNotFoundException();
            }
        }
    }

    private boolean isJavaIdentifier(String s) {
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

    public String toString() {
        return classId;
    }
}


