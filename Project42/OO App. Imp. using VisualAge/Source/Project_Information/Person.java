package Project_Information;

/**
 * This type was created in VisualAge.
 */
public abstract class Person {
	public String Firstname = "";
	public String Lastname = "";
	public String Sex = "";
	public String Nationality = "";
	public String Race = "";
	public String Religion = "";
	public String Status = "";
	public String PresentAddress = "";
	public String Street = "";
	public String District = "";
	public String Province = "";
	public String Telephone = "";
	public String Pager = "";
	public String IDcardNumber = "";
	public int    Salary = 0;
	public int    EnterID = 0;
	Month m = new Month();
	Calculate c = new Calculate();
/**
 * Customer constructor comment.
 */
public Person() {
	super();
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public int getNumber(String st) {
	if (st.equals("Salary")) {return Salary;}
	if (st.equals("EnterID")) {return EnterID;}
	return 0;
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public String getString(String st) {
	if (st.equals("Firstname")) {return Firstname;}
	if (st.equals("Lastname")) {return Lastname;}
	if (st.equals("Sex")) {return Sex;}
	if (st.equals("Nationality")) {return Nationality;}
	if (st.equals("Race")) {return Race;}
	if (st.equals("Religion")) {return Religion;}
	if (st.equals("Status")) {return Status;}
	if (st.equals("PresentAddress")) {return PresentAddress;}
	if (st.equals("Street")) {return Street;}
	if (st.equals("District")) {return District;}
	if (st.equals("Province")) {return Province;}
	if (st.equals("Telephone")) {return Telephone;}
	if (st.equals("Pager")) {return Pager;}
	if (st.equals("IDcardNumber")) {return IDcardNumber;}
	return "";
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setNumber(String st,int i) {
	if (st.equals("Salary")) {Salary = i;} else
	if (st.equals("EnterID")) {EnterID = i;}
}
/**
 * This method was created in VisualAge.
 * @return java.lang.String
 */
public void setString(String st,String st2) {
	if (st.equals("Firstname")) {Firstname = st2;} else
	if (st.equals("Lastname")) {Lastname = st2;} else
	if (st.equals("Sex")) {Sex = st2;} else
	if (st.equals("Nationality")) {Nationality = st2;} else
	if (st.equals("Race")) {Race = st2;} else
	if (st.equals("Religion")) {Religion = st2;} else
	if (st.equals("Status")) {Status = st2;} else
	if (st.equals("PresentAddress")) {PresentAddress = st2;} else
	if (st.equals("Street")) {Street = st2;} else
	if (st.equals("District")) {District = st2;} else
	if (st.equals("Province")) {Province = st2;} else
	if (st.equals("Telephone")) {Telephone = st2;} else
	if (st.equals("Pager")) {Pager = st2;} else
	if (st.equals("IDcardNumber")) {IDcardNumber = st2;}
}
}