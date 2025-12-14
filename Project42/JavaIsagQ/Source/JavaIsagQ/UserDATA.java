package IsecQ;
public class UserDATA 
{
	int      uin;
	String nick;
	String password;
	public UserDATA(){}
	public UserDATA(int uin,String nick,String password)
	{
		this.uin=uin;
		this.nick=nick;
		this.password=password;
	}
	public int getUIN(){return uin;}
	public String getNick(){return nick;}
	public String toString(){return password;}
	public String getPwd(){return password;}
//	public void setNick(String n){nick=n;}
	public void setData(int u,String n,String p)
	{
		uin=u;
		nick=n;
		password=p;
	}
}