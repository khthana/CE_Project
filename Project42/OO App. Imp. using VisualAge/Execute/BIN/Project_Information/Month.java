package Project_Information;

/**
 * This type was created in VisualAge.
 */
public class Month {
/**
 * Month constructor comment.
 */
public Month() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int toInt(String st) {
	if (st.equals("Jan")) {return 1;}  else
	if (st.equals("Feb")) {return 2;}  else
	if (st.equals("Mar")) {return 3;}  else
	if (st.equals("Apr")) {return 4;}  else
	if (st.equals("May")) {return 5;}  else
	if (st.equals("Jun")) {return 6;}  else
	if (st.equals("Jul")) {return 7;}  else
	if (st.equals("Aug")) {return 8;}  else
	if (st.equals("Sep")) {return 9;}  else
	if (st.equals("Oct")) {return 10;} else
	if (st.equals("Nov")) {return 11;} else
	if (st.equals("Dec")) {return 12;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String toString(int i) {
	if (i == 1) {return  "Jan";} else
	if (i == 2) {return  "Feb";} else
	if (i == 3) {return  "Mar";} else
	if (i == 4) {return  "Apr";} else
	if (i == 5) {return  "May";} else
	if (i == 6) {return  "Jun";} else
	if (i == 7) {return  "Jul";} else
	if (i == 8) {return  "Aug";} else
	if (i == 9) {return  "Sep";} else
	if (i == 10) {return  "Oct";} else
	if (i == 11) {return  "Nov";} else
	if (i == 12) {return  "Dec";} 
	return null;
}
}