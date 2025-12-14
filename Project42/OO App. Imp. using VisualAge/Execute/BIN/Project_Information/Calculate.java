package Project_Information;

/**
 * This type was created in VisualAge.
 */
public class Calculate {
/**
 * Calculate constructor comment.
 */
public Calculate() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return int
 * @param st java.lang.String
 */
public int toInt(String s) {
String st = ""+s;
	if ( !st.equals("null") && st.length() > 0 && st.charAt(0) != ' ' ) {
	return Integer.parseInt(st);
	}
	return 0;
}
}