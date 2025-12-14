
package IsecQ;
import java.net.*;
import java.io.*;
import java.awt.*;
import IsecQ.*;

public class  ServerListener extends Thread
{
	ServerConnect sconnect=new ServerConnect();
	UserAllInfo[] usrArr;
	TextArea ta;
	List searchList;

	IsagQ f;
	Util u=new Util();
	int num_remoteUIN;
	
	ServerListener(){}

	public void setInformation(IsagQ f ,ServerConnect sconnect ,UserAllInfo[] usrArr ) 
	{
		this.sconnect=sconnect;
		this.usrArr=usrArr;
		ta=sconnect.getTextArea();
		this.f=f;
	}

	short rcv_version = 0 ,rcv_command = 0 ,rcv_seq_num = 0 ,snd_seq_num = 0;
	ServerToClientCMD response = new ServerToClientCMD();
	HeadPacket rcvHeadPacket = new HeadPacket();
	UserOnlineInfo onlineInfo = new UserOnlineInfo();
	UserExtInfo uextinfo = new UserExtInfo();
	ReceiveMessage receiveMessage;
	
	public void run()
	{	try
		{	while(true)
			{	byte[] receivedData=sconnect.receivePacket();
				rcvHeadPacket.receiveData(receivedData);
				rcv_version=rcvHeadPacket.getVersion();
				rcv_command=rcvHeadPacket.getCommand();
				rcv_seq_num=rcvHeadPacket.getSeqNum();
				ta.append("RECEIVE :"+u.bytes2HxStr(receivedData)+"\n");
				ta.append("version :"+rcv_version+" | seq_num :"+rcv_seq_num+" | command :"+rcv_command);
				switch (rcv_command)
				{	case  10:		ta.append(": ACK\n");
										break;
					case  40:		ta.append(" : GO_AWAY\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  70:		ta.append(": NEW UIN\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  90:		ta.append(" : LOGIN_REPLY\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  100:	ta.append(" :BAD_PASS\n ");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  110:	ta.append(" : USER ONLINE\n");
										sconnect.sendACK(rcv_seq_num);
										onlineInfo=response.USER_ONLINE(receivedData);
										ta.append("uin:"+onlineInfo.getUIN()+"\n");
										ta.append("ip:"+Integer.toHexString(onlineInfo.getIP())+"\n");
										ta.append("port:"+onlineInfo.getPort()+"\n");
										ta.append("real IP"+Integer.toHexString(onlineInfo.getReal_IP())+"\n");
										ta.append("status"+onlineInfo.getStatus()+"\n");
										ta.append("status"+onlineInfo.getStatusStr()+"\n");
										for (int i = 0 ; i < f.getNumRemoteUIN() ;i++ )
											if (usrArr[i].getUIN()==onlineInfo.getUIN()) usrArr[i].UserOnlineInfo(onlineInfo);
										f.repaint();
										break;
					case  120:	ta.append(" : USER OFFLINE\n");
										int useroffline=response.USER_OFFLINE(receivedData);
										ta.append("uin "+useroffline+" offline\n");
										sconnect.sendACK(rcv_seq_num);
										for (int i = 0 ; i < f.getNumRemoteUIN() ;i++ )
											if (usrArr[i].getUIN() == useroffline)
											{	usrArr[i].setOffline();
												if (usrArr[i].getIsagQ())
												{	
												}
												ta.append(usrArr[i].getNick() + "\n  status : "+ usrArr[i].getStatusStr()+ "online: " + usrArr[i].getOnline() + "  secure: " + usrArr[i].getIsagQ() + "\n");
											}
										f.repaint();
										break;
					case  130:	ta.append(" : QUERY\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  140:	ta.append(" : USER_FOUND\n");
										UserInfo uinfo=new UserInfo();
										uinfo=response.USER_FOUND(receivedData);
										ta.append(":UIN:"+uinfo.getUIN()+"\n ");
										ta.append(":NICK NAME: "+uinfo.getNick()+"\n ");
										ta.append(":FIRST NAME: " +uinfo.getFirst()+"\n ");
										ta.append(":LAST NAME: " +uinfo.getLast()+" \n ");
										ta.append(":EMAIL NAME:  " +uinfo.getEmail()+"\n ");
										ta.append(":AUTHORIZE: " +uinfo.getAuth()+" \n ");
										for (int i = 0 ; i < f.getNumRemoteUIN() ;i++ )
											if (usrArr[i].getUIN()==uinfo.getUIN()) usrArr[i].UserInfo(uinfo);
										sconnect.sendACK(rcv_seq_num);
//										sconnect.addFoundUser(uinfo);
										sconnect.newFoundUser(uinfo);
										break;
					case  160:	ta.append(" :END OF SEARCH\n ");
										sconnect.sendACK(rcv_seq_num);
										sconnect.setSearchComplete(true);
										break;
					case  180:	ta.append(" : NEW USER\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  200:	ta.append(" : UPDATE EXT\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  220:	ta.append(" : RECV MESSAGE\n");
										response.RECV_MESSAGE(receivedData);
										ta.append(" : Sender UIN "+response.getSender()+"\n");
										ta.append(" : Date: "+ response.getDate()+"\n");
										ta.append(" : Time: "+response.getTime()+"\n");
										ta.append(" : Msg type: "+response.getMsgType()+"\n");
										ta.append(" : Msg len: "+response.getMsgLen()+"\n");
										ta.append(" : Message: "+ response.getMessage()+"\n");
										sconnect.sendACK(rcv_seq_num);
										boolean inlist=false;
										for (int i=0;i<f.getNumRemoteUIN() ;i++ )
										{	if (response.getSender()==usrArr[i].getUIN())
											{	receiveMessage=new ReceiveMessage(usrArr[i] ,response.getMessage(),sconnect ,f.getTcpConnect());
												inlist=true;
											}
										}
										if (!inlist)
										{	receiveMessage=new ReceiveMessage(response.getSender() ,response.getMessage(),sconnect ,f.getTcpConnect());
										}
										sconnect.AckMessage();
						 				break;
					case  230:	ta.append(" : X2\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  240:	ta.append(" : NOT CONNECT\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  250:	ta.append(" : TRY AGAIN\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  260:	ta.append(" : SYS DELIVERED MESS\n");
										response.SYS_DELIVERED_MESS(receivedData);
										ta.append(" : Sender UIN "+ response.getSender()+" | ");
										ta.append(" : Msg type: "+response.getMsgType()+" | ");
										ta.append(" : Msg len: "+response.getMsgLen()+" | ");
										ta.append(" : Message: "+response.getMessage()+"\n");
										sconnect.sendACK(rcv_seq_num);
										inlist=false;
										for (int i = 0 ;i < f.getNumRemoteUIN() ;i++ )
										{	if (response.getSender()==usrArr[i].getUIN())
											{	receiveMessage=new ReceiveMessage(usrArr[i] ,response.getMessage(),sconnect ,f.getTcpConnect());
												inlist=true;
											}
										}
										if (!inlist)
										{	receiveMessage=new ReceiveMessage(response.getSender() ,response.getMessage(),sconnect ,f.getTcpConnect());
										}
										break;
					case  280:	ta.append(" : INFO REPLY\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  290:	ta.append(" : EXT INFO REPLY\n");
										sconnect.sendACK(rcv_seq_num);
										uextinfo=response.EXT_INFO_REPLY(receivedData);
										ta.append(":UIN:"+uextinfo.getUIN()+"\n ");
										ta.append(":CITY: "+uextinfo.getCity()+"\n ");
										ta.append(":COUNTRY CODE: " +uextinfo.getCountryCode()+"\n ");
										ta.append(":COUNTRY STATUS: " +uextinfo.getCountryStatus()+"\n ");
										ta.append(":STATE: " +uextinfo.getState()+" \n ");
										ta.append(":AGE:  " +uextinfo.getAge()+"\n ");
										ta.append(":SEX: " +uextinfo.getSex()+" \n ");
										ta.append(":PHONE: " +uextinfo.getPhone()+" \n ");
										ta.append(":HOMEPAGE:  " +uextinfo.getHomepage()+"\n ");
										ta.append(":ABOUT: " +uextinfo.getAbout()+" \n ");
//										for (int i = 0 ; i < f.getNumRemoteUIN() ;i++ )
//											if (usrArr[i].getUIN() == uextinfo.getUIN()) usrArr[i].UserExtInfo(uextinfo);
//										uextinfo=response.EXT_INFO_REPLY(receivedData);
										sconnect.receiveExtInfo(uextinfo);
										break;
					case  300:	ta.append(" : NO INFO AVAILABLE\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  310:	ta.append(" : NO EXT INFO AVAILABLE\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  420:	ta.append(" : STATUS UPDATE\n");
										response.STATUS_UPDATE(receivedData);
										ta.append(":UIN: " + response.getUpdateUIN()+"\n ");
										ta.append(":updated status: " +Integer.toHexString(response.getUpdateStatus())+"\n ");
										for (int i=0 ; i < f.getNumRemoteUIN() ;i++ )
											if (usrArr[i].getUIN()==response.getUpdateUIN()) usrArr[i].setStatus(response.getUpdateStatus());
										f.repaint();
										sconnect.sendACK(rcv_seq_num);
										break;
					case  450:	ta.append(" : SYSTEM MESSAGE\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  480:	ta.append(" : UPDATE SUCCESS\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  490:	ta.append(" : UPDATE FAIL\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  500:	ta.append(" : AUTH UPDATE\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  530:	ta.append(" : MULTI PACKET\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  540:	ta.append(" : X1\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  590:	ta.append(" : RAN USER\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					case  990:	ta.append(" : META USER\n");
										sconnect.sendACK(rcv_seq_num);
										break;
					default :		ta.append(" : Invalid command\n");
										sconnect.sendACK(rcv_seq_num);
				}// end switch
				f.repaint();
			}// end while
		}catch(IOException e){}
	}// end run
}// end class