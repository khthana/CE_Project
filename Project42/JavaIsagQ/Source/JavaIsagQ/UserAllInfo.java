package	IsecQ;
import		java.math.BigInteger;
import		java.net.*;
import		java.io.*;
import		java.awt.TextArea;
import		IsecQ.*;

class UserAllInfo
{
	Util u = new Util();
//	TextArea ta = new TextArea();

	private String	password = "" ,nick = "" ,first = "" ,last = "" ,email = "" ;
	private String	city = "" ,state = "" ,phone = "" ,homepage = "" ,about = "" ;
	private String	IPstring = "" ,displayStr = "" ,statusStr = "OFFLINE"; 
	private byte		authorize = 0 ,country_status = 0 ,sex = 0;
	private int			UIN=0 ,IP = 0 ,Real_IP = 0 ,Status = 0;
	private short	Port = 0 ,country_code = 0 ,age = 0;
	private boolean online = false ,IsagQ = false;
	private BigInteger E =new BigInteger("0");
	private BigInteger N =new BigInteger("0");
	private BigInteger D =new BigInteger("0");
	private byte[]	DES=new byte[0];
//=============================== GET USER INFO CLASS ===========================	
	public void UserInfo(UserInfo uinfo)
	{	UIN = uinfo.getUIN();
		nick = uinfo.getNick();
		first = uinfo.getFirst();
		last = uinfo.getLast();
		email = uinfo.getEmail();
		authorize = uinfo.getAuth();
		if (!nick.equals(""))
		{	displayStr = nick + " (" + statusStr + ")";
		}else displayStr = UIN + " (" + statusStr + ")";
		System.out.println("user all info receive "+UIN);
	}
//============================ GET USER ONLINE INFO CLASS =========================
	public void UserOnlineInfo (UserOnlineInfo uoninfo) throws UnknownHostException ,IOException
	{	UIN = uoninfo.getUIN();
		IP = uoninfo.getIP();
		Real_IP = uoninfo.getReal_IP();
		Status = uoninfo.getStatus();
		Port = uoninfo.getPort();
		IPstring = u.IPint2String(IP);
		statusStr=uoninfo.getStatusStr();
//		displayStr = Integer.toString(UIN) + " (" + statusStr + ")";
		displayStr= nick+" (" + statusStr + ")";
		online = true;
	}
//=============================== GET USER EXT INFO CLASS ===========================	
	public void UserExtInfo(UserExtInfo uextinfo)
	{	city = uextinfo.getCity();
		country_code = uextinfo.getCountryCode();
		country_status = uextinfo.getCountryStatus();
		state = uextinfo.getState();
		age = uextinfo.getAge();
		sex = uextinfo.getSex();
		phone = uextinfo.getPhone();
		homepage = uextinfo.getHomepage();
		about = uextinfo.getAbout();
	}
//=============================== SET FUCTION ===========================	
	public void setUIN		(int uin)			{UIN = uin;	 displayStr = Integer.toString(UIN);}
	public void setPWD	(String pwd)		{password = pwd;}
	public void setNick		(String nick)	
	{	this.nick = nick;
		if (!nick.equals(""))
		{	displayStr = nick;
		}
	}
	public void setFirst		(String first)		{this.first = first;}
	public void setLast		(String last)		{this.last = last;}
	public void setEmail	(String email)	{this.email = email;}
	public void setAuth		(byte auth)		{authorize = auth;}
	public void setCity		(String city)		{this.city = city;}
	public void setCountryCode	(short ctcode)		{country_code = ctcode;}
	public void setCountryStatus	(byte ctstatus)		{country_status= ctstatus;}
	public void setState		(String state)	{this.state =  state;}
	public void setAge		(short age)		{this.age = age;}
	public void setSex		(byte sex)		{this.sex = sex;}
	public void setPhone	(String phone)	{this.phone = phone;}
	public void setHomepage		(String hp)			{homepage = hp;}
	public void setAbout	(String about)	{this.about = about;}
	public void setIP			(int ip)				{IP = ip;}
	public void setReal_IP(int ip)				{ Real_IP = ip;}
	public void setPort		(short port)		{Port = port;}
	public void setStatus	(int status)		
	{	Status = 0x0000ffff&status;
		switch (Status)
		{	case 0		:statusStr="ONLINE";		break;
			case 1		:statusStr="AWAY";		break;
			case 19	:statusStr="DND";			break;
			case 256	:statusStr="INVISIBLE";	break;
			case 17	:statusStr="OCCUPIED";break;
			case 5		:statusStr="NA";				break;
			case 32	:statusStr="CHAT";		
		}
		if (!nick.equals(""))
		{	displayStr = nick + " (" + statusStr + ")";
		}
	}
	public void setOffline()	
	{	online = false; 
		statusStr="OFFLINE" ; 
		IsagQ = false;
		displayStr = nick+" ("+statusStr+") ";
	}
	public void setOnline()	{online = true;}
	public void setIsagQ()		{IsagQ = true;}

	public void setKey_E		(BigInteger e)	{E = e;}
	public void setKey_D		(BigInteger d)	{D = d;}
	public void setKey_N		(BigInteger n)	{N = n;}
	public void setKey_DES	(byte[] des)		{DES = des;}
//=============================== GET FUCTION ===========================	
	public int			getUIN()			{return UIN;}
	public String	getPWD()		{return password;}
	public String	getNick()			{return nick;}
	public String	getFirst()			{return first;}
	public String	getLast()			{return last;}
	public String	getEmail()		{return email;}
	public byte		getAuth()			{return authorize;}
	public String	getCity()			{return city;}
	public short		getCountryCode()	{return country_code;}
	public byte		getCountryStatus()	{return country_status;}
	public String	getState()		{return state;}
	public short		getAge()			{return age;}
	public byte		getSex()			{return sex;}
	public String	getPhone()		{return phone;}
	public String	getHomepage()		{return homepage;}
	public String	getAbout()		{return about;}
	public int			getIP()				{return IP;}
	public String	getIPStr()			{return IPstring;}
	public short		getPort()			{return Port;}
	public int			getReal_IP()	{return Real_IP;}
	public int			getStatus()		{return Status;}
	public String	getStatusStr()	{return statusStr;}
	public String	getDisplayStr(){return displayStr;}
	public boolean		getOnline()	{return online;}
	public boolean		getIsagQ()	{return IsagQ;}
	public BigInteger getKey_E()	{return E;}
	public BigInteger getKey_D()	{return D;}
	public BigInteger getKey_N()	{return N;}
	public byte[]			getKey_DES()		{return DES;}
}