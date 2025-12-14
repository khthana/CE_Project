package JavaIDEX;

import com.sun.jdi.*;
import com.sun.jdi.request.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

class BreakpointSpec extends EventRequestSpec {
    String methodId;
    List methodArgs;
    int lineNumber;

    BreakpointSpec(ReferenceTypeSpec refSpec, int lineNumber) {
        super(refSpec);
        this.methodId = null;
        this.methodArgs = null;
        this.lineNumber = lineNumber;
    }

    BreakpointSpec(ReferenceTypeSpec refSpec, String methodId, 
                   List methodArgs) throws MalformedMemberNameException {
        super(refSpec);
        this.methodId = methodId;
        this.methodArgs = methodArgs;
        this.lineNumber = 0;
        if (!isValidMethodName(methodId)) {
            throw new MalformedMemberNameException(methodId);
        }
    }

    /**
     * The 'refType' is known to match, return the EventRequest.
     */
    EventRequest resolveEventRequest(ReferenceType refType) 
                                      throws AmbiguousMethodException,
                                             InvalidTypeException,
                                             NoSuchMethodException,
                                             LineNotFoundException {
        Location location = location(refType);
        EventRequestManager em = refType.virtualMachine().eventRequestManager();
        EventRequest bp = em.createBreakpointRequest(location);
        bp.setSuspendPolicy(suspendPolicy);
        bp.enable();
        return bp;
    }

    String methodName() {
        return methodId;
    }

    int lineNumber() {
        return lineNumber;
    }

    List methodArgs() {
        return methodArgs;
    }

    boolean isMethodBreakpoint() {
        return (methodId != null);
    }

    public int hashCode() {
        return refSpec.hashCode() + lineNumber + 
            ((methodId != null) ? methodId.hashCode() : 0) +
            ((methodArgs != null) ? methodArgs.hashCode() : 0);
    }

    public boolean equals(Object obj) {
        if (obj instanceof BreakpointSpec) {
            BreakpointSpec breakpoint = (BreakpointSpec)obj;

            return ((methodId != null) ? 
                        methodId.equals(breakpoint.methodId) 
                      : methodId == breakpoint.methodId) &&
                   ((methodArgs != null) ? 
                        methodArgs.equals(breakpoint.methodArgs)
                      : methodArgs == breakpoint.methodArgs) &&
                   refSpec.equals(breakpoint.refSpec) &&
                   (lineNumber == breakpoint.lineNumber);
        } else {
            return false;
        }
    }

    String errorMessageFor(Exception e) { 
        if (e instanceof AmbiguousMethodException) {
            return ("Method " + methodName() + " is overloaded; specify arguments");
            /*
             * TO DO: list the methods here
             */
        } else if (e instanceof NoSuchMethodException) {
            return ("No method " + methodName() + " in " + refSpec);
        } else if (e instanceof LineNotFoundException) {
            return ("No code at line " + lineNumber() + " in " + refSpec);
        } else if (e instanceof InvalidTypeException) {
            return ("Breakpoints can be located only in classes. " + 
                        refSpec + " is an interface or array");
        } else {
            return super.errorMessageFor( e);
        } 
    }

    public String toString() {
        StringBuffer buffer = new StringBuffer("breakpoint ");
        buffer.append(refSpec.toString());
        if (isMethodBreakpoint()) {
            buffer.append('.');
            buffer.append(methodId);
            if (methodArgs != null) {
                Iterator iter = methodArgs.iterator();
                boolean first = true;
                buffer.append('(');
                while (iter.hasNext()) {
                    if (!first) {
                        buffer.append(',');
                    }
                    buffer.append((String)iter.next());
                    first = false;
                }
                buffer.append(")");
            }
        } else {
            buffer.append(':');
            buffer.append(lineNumber);
        }
        return buffer.toString();
    }

    private Location location(ReferenceType refType) throws 
                                               AmbiguousMethodException,
                                               NoSuchMethodException,
                                               LineNotFoundException {
        Location location = null;
        if (isMethodBreakpoint()) {
            Method method = findMatchingMethod(refType);
            location = method.location();
        } else {
            try {
                List locs = refType.locationsOfLine(lineNumber());
                if (locs.size() == 0) {
                    throw new LineNotFoundException();
                }
                // TO DO: handle multiple locations
                location = (Location)locs.get(0);
                if (location.method() == null) {
                    throw new LineNotFoundException();
                } 
            } catch (AbsentInformationException e) {
                /*
                 * TO DO: throw something more specific, or allow
                 * AbsentInfo exception to pass through. 
                 */
                throw new LineNotFoundException();
            }
        }
        return location;
    }

    private boolean isValidMethodName(String s) {
        return isJavaIdentifier(s) || 
               s.equals("<init>") ||
               s.equals("<clinit>");
    }

    /* 
     * Compare a method's argument types with a Vector of type names.
     * Return true if each argument type has a name identical to the 
     * corresponding string in the vector and if the number of 
     * arguments in the method matches the number of names passed
     */
    private boolean compareArgTypes(Method method, List nameList) {
        List argTypeNames = method.argumentTypeNames();

        // If argument counts differ, we can stop here
        if (argTypeNames.size() != nameList.size()) {
            return false;
        }

        // Compare each argument type's name
        for (int i=0; i<argTypeNames.size(); ++i) {
            String comp1 = (String)argTypeNames.get(i);
            String comp2 = (String)nameList.get(i);
            if (! comp1.equals(comp2)) {
                return false;
            }
        }

        return true;
    }


    /*
     * Remove unneeded spaces and expand class names to fully 
     * qualified names, if necessary and possible.
     */
    private String normalizeArgTypeName(String name) {
        /* 
         * Separate the type name from any array modifiers, 
         * stripping whitespace after the name ends
         */
        int i = 0;
        StringBuffer typePart = new StringBuffer();
        StringBuffer arrayPart = new StringBuffer();
        name = name.trim();
        while (i < name.length()) {
            char c = name.charAt(i);
            if (Character.isWhitespace(c) || c == '[') {
                break;      // name is complete
            }
            typePart.append(c);
            i++;
        }
        while (i < name.length()) {
            char c = name.charAt(i);
            if ( (c == '[') || (c == ']') ) {
                arrayPart.append(c);
            } else if (!Character.isWhitespace(c)) {
                throw new IllegalArgumentException("Invalid argument type name");
            }
            i++;
        }
        name = typePart.toString();

        /*
         * When there's no sign of a package name already, try to expand the 
         * the name to a fully qualified class name
         */
        if ((name.indexOf('.') == -1) || name.startsWith("*.")) {
            try {
                ReferenceType argClass = Env.getReferenceTypeFromToken(name);
                if (argClass != null) {
                    name = argClass.name();
                }
            } catch (IllegalArgumentException e) {
                // We'll try the name as is 
            }
        }
        name += arrayPart.toString();
        return name;
    }

    /* 
     * Attempt an unambiguous match of the method name and 
     * argument specification to a method. If no arguments 
     * are specified, the method must not be overloaded.
     * Otherwise, the argument types much match exactly 
     */
    private Method findMatchingMethod(ReferenceType refType) 
                                        throws AmbiguousMethodException,
                                               NoSuchMethodException {

        // Normalize the argument string once before looping below.
        List argTypeNames = null;
        if (methodArgs() != null) {
            argTypeNames = new ArrayList(methodArgs().size());
            Iterator iter = methodArgs().iterator();
            while (iter.hasNext()) {
                String name = (String)iter.next();
                name = normalizeArgTypeName(name);
                argTypeNames.add(name);
            }
        }

        // Check each method in the class for matches
        Iterator iter = refType.methods().iterator();
        Method firstMatch = null;  // first method with matching name
        Method exactMatch = null;  // (only) method with same name & sig
        int matchCount = 0;        // > 1 implies overload
        while (iter.hasNext()) {
            Method candidate = (Method)iter.next();

            if (candidate.name().equals(methodName())) {
                matchCount++;

                // Remember the first match in case it is the only one
                if (matchCount == 1) {
                    firstMatch = candidate;
                }

                // If argument types were specified, check against candidate
                if ((argTypeNames != null) 
                        && compareArgTypes(candidate, argTypeNames) == true) {
                    exactMatch = candidate;
                    break;
                }
            }
        }

        // Determine method for breakpoint
        Method method = null;
        if (exactMatch != null) {
            // Name and signature match
            method = exactMatch;
        } else if ((argTypeNames == null) && (matchCount > 0)) {
            // At least one name matched and no arg types were specified
            if (matchCount == 1) {
                method = firstMatch;       // Only one match; safe to use it
            } else {
                throw new AmbiguousMethodException();
            }
        } else {
            throw new NoSuchMethodException(methodName());
        }
        return method;
    }
}
