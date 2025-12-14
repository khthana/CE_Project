package IsecQ;

class UserExtInfo 
{	private int			uin=0;
	private String	city="" ,state="" ,phone="" ,homepage="" ,about=""; 
	private short	country_code=0 ,age=0;
	private byte		country_status=0 ,sex=0;
	private short	search_seq=0;
	
	public void setSearchSeq		(short	seq )		{search_seq=seq;}
	public void setUIN					(int		uin)			{this.uin=uin;}
	public void setCity					(String city)			{this.city=city;}
	public void setCountryCode	(short	code)		{country_code=code;}
	public void setCountryStatus	(byte	cstatus)	{country_status=cstatus;}
	public void setState					(String state)		{this.state=state;}
	public void setAge					(short	age)			{this.age=age;}
	public void setSex					(byte	sex)			{this.sex=sex;}
	public void setPhone				(String phone)		{this.phone=phone;}
	public void setHomepage		(String homepage){this.homepage=homepage;}
	public void setAbout				(String about)		{this.about=about;}

	public short		getSearchSeq()		{return search_seq;}
	public int			getUIN()					{return uin;}
	public String	getCity()					{return city;}
	public short		getCountryCode()	{return country_code;}
	public byte		getCountryStatus()	{return country_status;}
	public String	getState()				{return state;}
	public short		getAge()					{return age;}
	public byte		getSex()					{return sex;}
	public String	getPhone()				{return phone;}
	public String	getHomepage()		{return homepage;}
	public String	getAbout()				{return about;}
}