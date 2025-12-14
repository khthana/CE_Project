package IsecQ;
import IsecQ.*;

class ServerToClientCMD extends HeadPacket
{
	Util u=new Util();
	//-----------------------------USER ONLINE-----------------------------------------------------
	public UserOnlineInfo  USER_ONLINE(byte[] data) // 6E 00 (110)
	{
		UserOnlineInfo uoi=new UserOnlineInfo();
		uoi.receiveData(data);
		return uoi;
	}
	//-----------------------------USER OFFLINE--------------------------------------------------------
	public int  USER_OFFLINE(byte[] data) // 6E 00 (110)
	{		return u.bytes2IntSW(u.copyBytes(data,6,4));;
	}
	//-----------------------------USER FOUND---------------------------------------------------------

	public UserInfo USER_FOUND(byte[] data) // 6E 00 (110)
	{	
		int index=6;
		short nick_len,  first_len,  last_len,  email_len,    search_seq;
		UserInfo uinfo=new UserInfo();

		search_seq=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index=index+2;
		uinfo.setUIN(u.bytes2IntSW(u.copyBytes(data,index,4)));
		index=index+4;
		nick_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		=index+2;
		uinfo.setNick(new String(data,index,(int)(nick_len-1)));
		index		=index+nick_len;
		first_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		=index+2;
		uinfo.setFirst(new String(data,index,(int)(first_len-1)));
		index		=index+first_len;
		last_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		=index+2;
		uinfo.setLast(new String(data,index,(int)(last_len-1)));
		index		=index+last_len;
		email_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		=index+2;
		uinfo.setEmail(new String(data,index,(int)(email_len-1)));
		index		=index+email_len;
		uinfo.setAuth(data[index]);
		return uinfo;
	}
	//------------------------RECEIVE MESSAGE------------------------------------------------------------------
	int senderUIN;
	short year;
	byte month,day,hour,minute;
	short msg_type,msg_len;
	String rcv_msg="i love icq";

	public void RECV_MESSAGE(byte[] data) // DC 00 (220)
	{	senderUIN = u.bytes2IntSW(u.copyBytes(data,6,4));
		year = u.bytes2ShortSW(u.copyBytes(data,10,2));
		month = data[12];
		day = data[13];
		hour = data[14];
		minute = data[15];
		msg_type = u.bytes2ShortSW(u.copyBytes(data,16,2));
		msg_len = u.bytes2ShortSW(u.copyBytes(data,18,2));
		rcv_msg = new String(data,20,(int)(msg_len-1));
	}
	public int getSender(){return senderUIN;}
	public String getDate()		{return day+"/"+month+"/"+year;}
	public String getTime()		{return hour+":"+minute;}
	public short getMsgType()	{return msg_type;}
	public short getMsgLen()	{return msg_len;}
	public String getMessage(){return rcv_msg;}

	//--------------------------SYS DELIVERED MESS-------------------------------------------------------------
	public void SYS_DELIVERED_MESS(byte[] data) //  04 01 (260)
	{	senderUIN=u.bytes2IntSW(u.copyBytes(data,6,4));
		msg_type=u.bytes2ShortSW(u.copyBytes(data,10,2));
		msg_len=u.bytes2ShortSW(u.copyBytes(data,12,2));
		rcv_msg=new String(data,14,(int)(msg_len-1));
	}
//-----------------------------EXT INFO REPLY-----------------------------------------------------

	public UserExtInfo EXT_INFO_REPLY(byte[] data) // 22 01 (290)
	{	short search_seq ,city_len ,state_len ,phone_len ,page_len ,about_len;
		int index=6;

		UserExtInfo uextinfo=new UserExtInfo();

		uextinfo.setSearchSeq(u.bytes2ShortSW(u.copyBytes(data,index,2)));
//		System.out.println("seq "+u.bytes2ShortSW(u.copyBytes(data,index,2)));
//		System.out.println("seq "+uextinfo.getSearchSeq());
		index	+=2;

		uextinfo.setUIN(u.bytes2IntSW(u.copyBytes(data,index,4)));
//		System.out.println("uin "+u.bytes2IntSW(u.copyBytes(data,index,4)));
//		System.out.println("uin "+uextinfo.getUIN());
		index	+=4;

		city_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index	+=2;
		uextinfo.setCity(new String(data,index,(int)(city_len-1)));
//		System.out.println("city "+new String(data,index,(int)(city_len-1)));
//		System.out.println("city "+uextinfo.getCity());
		index	+=city_len;

		uextinfo.setCountryCode(u.bytes2ShortSW(u.copyBytes(data,index,2)));
//		System.out.println("code "+u.bytes2ShortSW(u.copyBytes(data,index,2)));
//		System.out.println("code "+uextinfo.getCountryCode());
		index	+=2;
		
		uextinfo.setCountryStatus(data[index]);
//		System.out.println("status "+data[index]);
//		System.out.println("status "+uextinfo.getCountryStatus());
		index++;

		state_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index	+=2;
		uextinfo.setState(new String(data,index,(int)(state_len-1)));
//		System.out.println("state "+new String(data,index,(int)(state_len-1)));
//		System.out.println("state "+uextinfo.getState());
		index	+=state_len;

		uextinfo.setAge(u.bytes2ShortSW(u.copyBytes(data,index,2)));
//		System.out.println("age "+u.bytes2ShortSW(u.copyBytes(data,index,2)));
//		System.out.println("age "+uextinfo.getAge());
		index	+=2;
		
		uextinfo.setSex(data[index]);
//		System.out.println("sex "+data[index]);
//		System.out.println("sex "+uextinfo.getSex());
		index++;

		phone_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		+=2;
		uextinfo.setPhone(new String(data,index,(int)(phone_len-1)));
//		System.out.println("phone "+new String(data,index,(int)(phone_len-1)));
//		System.out.println("phone "+uextinfo.getPhone());
		index		+=phone_len;

		page_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		+=2;
		uextinfo.setHomepage(new String(data,index,(int)(page_len-1)));
//		System.out.println("homepage "+new String(data,index,(int)(page_len-1)));
//		System.out.println("homepage "+uextinfo.getHomepage());
		index		+=page_len;

		about_len	=u.bytes2ShortSW(u.copyBytes(data,index,2));
		index		+=2;
		uextinfo.setAbout(new String(data,index,(int)(about_len-1)));
//		System.out.println("homepage "+new String(data,index,(int)(about_len-1)));
//		System.out.println("homepage "+uextinfo.getAboute());
		index		+=about_len;

		return uextinfo;
	}	//--------------------------STATUS UPDATE--------------------------------------------------------------------
	int updateStatus;
	int updateUIN;
	public void STATUS_UPDATE(byte[] data) //420
	{	updateUIN=u.bytes2IntSW(u.copyBytes(data,6,4));
		updateStatus=u.bytes2IntSW (u.copyBytes(data,10,4));
	}
	public int getUpdateUIN(){return updateUIN;}
	public int getUpdateStatus(){return updateStatus;}
}