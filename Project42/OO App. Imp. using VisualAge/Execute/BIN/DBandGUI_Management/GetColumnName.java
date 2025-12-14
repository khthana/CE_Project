package DBandGUI_Management;

/**
 * This type was created in VisualAge.
 */
public class GetColumnName extends com.ibm.ivj.db.uibeans.Select {
/**
 * GetColumnName constructor comment.
 */
public GetColumnName() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return int
 */
public int getColumnCount() {
	return super.getColumnCount()-1;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 * @param column int
 */
public String getColumnName(int column) {
	switch (column) {
		case 0: return "CustomerID";
		case 1: return "Firstname";
		case 2: return "Lastname";
		default: return super.getColumnName(column);
	}
}
}