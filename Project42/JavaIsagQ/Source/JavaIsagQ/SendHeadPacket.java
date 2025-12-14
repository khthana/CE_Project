package IsecQ;

import java.io.*;
import IsecQ.*;
class SendHeadPacket extends HeadPacket 
{
	int UIN=0;
	public void setUIN(int uin){UIN=uin;}
	public int getUIN(){return UIN;}
	public short getHeadSize(){return 10;} //byte size
}