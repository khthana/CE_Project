package DBandGUI_Management;

/**
 * This type was created in VisualAge.
 */
public class GetCustomerColName extends com.ibm.ivj.db.uibeans.Select {
/**
 * GetColumnName constructor comment.
 */
public GetCustomerColName() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param column int
 */
public String getColumnName(int column) {
	switch (column) {
		case 0: return "ID";		
		case 1: return "FirstName";
		case 2: return "LastName";
		case 3: return "Address";
		case 4: return "Street";
		case 5: return "District";
		case 6: return "Province";
		case 7: return "Tel.";
		case 8: return "Occupation";
		case 9: return "Company";
		case 10: return "Salary";
		default: return super.getColumnName(column);
	}
}
}