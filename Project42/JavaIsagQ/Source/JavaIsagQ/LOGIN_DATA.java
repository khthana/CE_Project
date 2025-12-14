package IsecQ;
class LOGIN_DATA 
{
		public short  port=14245;
		public short  ext_port=0;
		public short  pass_len=0;
		public String password="";
		public byte   endpwd=0;
		public int		x1=0x72000400;
		public int		IP;//=0xa1f6050b;
		public byte   x2=4;
		public int		status=0x00000000; 	//     online 00 00 00 00 | away  01 00 00 00
		public int		x3=0x03000000;
		public int		log_seq_num=0x02000000;
		public int		x4=0x00000400;
		public short  x5=(short)0x7200;

		public void setPassword(String pwd)
		{
			password=pwd;
			pass_len=(short)(pwd.length()+1);
		}		
		public void setPort(int p){port=(short)p;}
		public void setIP(int ip){IP=ip;}
		public void setStatus(int s){status=s;}
//		public void setIP(int ip)
//		{	}
}