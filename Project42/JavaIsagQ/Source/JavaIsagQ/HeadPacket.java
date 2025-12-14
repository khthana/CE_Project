package IsecQ;
import java.io.*; 
import IsecQ.*;

class HeadPacket
{
	Util u=new Util();
	HeadPacket()
	{
	}
	HeadPacket(byte[] bytes)
	{
		byte[] tmp=new byte[2];
		tmp[0]=bytes[0];
		tmp[1]=bytes[1];
		version=u.bytes2ShortSW(tmp);
		tmp[0]=bytes[2];
		tmp[1]=bytes[3];
		command=u.bytes2ShortSW(tmp);
		tmp[0]=bytes[4];
		tmp[1]=bytes[5];
		seq_num=u.bytes2ShortSW(tmp);
	}

	public short version=2;
	public short command=0;
	public short seq_num=1;

	// set function
	public void setVersion(short ver){version=ver;}
	public void setCommand(short cmd){command=cmd;}
	public void setSeqNum(short seq){seq_num=seq;}

	// get function
	public short getVersion(){return version;}
	public short getCommand(){return command;}
	public short getSeqNum(){return seq_num;}
	public short getHeadSize(){return 6;} //byte size

	public void receiveData(byte[] data)
	{
				byte[] tmp=new byte[2];
				tmp[0]=data[0];
				tmp[1]=data[1];
				version=u.bytes2ShortSW(tmp);
				tmp[0]=data[2];
				tmp[1]=data[3];
				command=u.bytes2ShortSW(tmp);
				tmp[0]=data[4];
				tmp[1]=data[5];
				seq_num=u.bytes2ShortSW(tmp);
	}
}