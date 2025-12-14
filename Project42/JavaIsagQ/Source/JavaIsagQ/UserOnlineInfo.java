package IsecQ;
import IsecQ.*;

class  UserOnlineInfo
{
	Util u=new Util();
	private int UIN=0 ,IP=0 ,Real_IP=0, Status=0;
	private short Port=0;
	private String statusStr="OFFLINE";
	
	public int getUIN(){return UIN;}
	public int getIP(){return IP;}
	public short getPort(){return Port;}
	public int getReal_IP(){return Real_IP;}
	public int getStatus(){return Status;}
	public String getStatusStr(){return statusStr;}

	public void setUIN(int uin){UIN=uin;}
	public void setIP(int ip){IP=ip;Real_IP=ip;}
	public void setIP(byte[] ip)
	{
		int ip1;
		ip1=u.bytes2Int(ip);
		IP=ip1;Real_IP=ip1;
	}

	public void setPort(short port){Port=port;}
	public void setStatus(int status){Status=status;}
	
	public void receiveData(byte[] data) // 6E 00 (110)
	{	int index=6;
		UIN=u.bytes2IntSW(u.copyBytes(data,6,4));
		IP=u.bytes2Int(u.copyBytes(data,10,4));
		Port=u.bytes2ShortSW(u.copyBytes(data,14,2));
		Real_IP=u.bytes2Int(u.copyBytes(data,18,4));
		Status=u.bytes2IntSW(u.copyBytes(data,23,4));
		Status=Status&0x0000ffff;
		switch (Status)
		{
		case 0:	statusStr="ONLINE";	break;
		case 1	:	statusStr="AWAY";		break;
		case 19:	statusStr="DND";		break;
		case 256:statusStr="INVISIBLE";	break;
		case 17:	statusStr="OCCUPIED";break;
		case 5:	statusStr="NA";			break;
		case 32:	statusStr="CHAT";		break;
//		default  :  statusStr="OFFLINE";	
		}
	}
}