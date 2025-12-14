import java.awt.*;
import java.awt.event.*;
import java.net.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;
import sck.*;

public class Framer40 extends Frame{
	Button Rightbutton = new Button();
  	Button Leftbutton = new Button();
	MyThread t ;  // = new MyThread();

	Framer40(){
		setTitle("Network Management Console");
		setLayout(null);

		Leftbutton.setBounds(new Rectangle(100, 100, 50, 25));
		Leftbutton.setLabel("Stop");
		Leftbutton.addMouseListener(new java.awt.event.MouseAdapter() {
		public void mouseClicked(MouseEvent e) {
			Leftbutton_mouseClicked(e);
		}
		});

		Rightbutton.setBounds(new Rectangle(200, 100, 50, 25));
		Rightbutton.setLabel("Start");
		Rightbutton.addMouseListener(new java.awt.event.MouseAdapter() {
		public void mouseClicked(MouseEvent e) {
			Rightbutton_mouseClicked(e);
		}
		});

		this.add(Leftbutton,null);
		this.add(Rightbutton,null);
	}


	public boolean handleEvent(Event e){
		if (e.id ==  Event.WINDOW_DESTROY)
		   System.exit(0);
		return super.handleEvent(e);
	}

	void Leftbutton_mouseClicked(MouseEvent e) {
		System.out.println("stoping");
		System.out.println();
		t.stop();

		Useful u = new Useful();
		u.deleteTable("device");
		u.deleteTable("interface");
		u.deleteTable("inoutdevice");
		u.deleteTable("keepalltime");
		u.deleteTable("datamid");
		u.deleteTable("forswitch");

	}

	void Rightbutton_mouseClicked(MouseEvent e) {
		t = new MyThread();
		t.start();
	}

	public static void main (String[] args)	{
		Framer40 f = new Framer40();  // first group variable & constructor
		   f.resize(300,200) ;	 // only	
		   f.show() ;			 // only
	}

}



class MyThread extends Thread {


	public void run(){

		int formid = new Useful().findmid(52448330); //50725201
//		System.out.println(formid);			//about 23.58 tuesday 7march2000 


		int hourref = 53837930;	//about 1.58 friday 24march2000 
		int curren  = (int)(System.currentTimeMillis()/1000-900000000);

		while (curren>hourref) hourref=hourref+3600;


		Pc pc6157 = new Pc("161.246.6.157",formid);		
		Pc pc6127 = new Pc("161.246.6.127",formid);		
		Pc pc6117 = new Pc("161.246.6.117",formid);	
		Pc pc652  = new Pc("161.246.6.52",formid);
		Pc pc653  = new Pc("161.246.6.53",formid);
		Pc pc654  = new Pc("161.246.6.54",formid);
		Pc pc658  = new Pc("161.246.6.58",formid);
		Pc pc670  = new Pc("161.246.6.70",formid);
		Pc pc6130 = new Pc("161.246.6.130",formid);
		Pc pc6121 = new Pc("161.246.6.121",formid);

		Server server43 = new Server("161.246.4.3",formid);
		Switch swit610  = new Switch("161.246.6.10",hourref);


		System.out.println();
		try{
			DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		} 
		catch ( Exception ex) { }


		 new Useful().keepFirst("161.246.6.157");
		new Useful().keepSecond("161.246.6.157");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.127");
		new Useful().keepSecond("161.246.6.127");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.117");
		new Useful().keepSecond("161.246.6.117");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.52");
		new Useful().keepSecond("161.246.6.52");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.53");
		new Useful().keepSecond("161.246.6.53");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.54");
		new Useful().keepSecond("161.246.6.54");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.58");
		new Useful().keepSecond("161.246.6.58");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.70");
		new Useful().keepSecond("161.246.6.70");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.130");
		new Useful().keepSecond("161.246.6.130");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.6.121");
		new Useful().keepSecond("161.246.6.121");try{sleep(2000);} catch (InterruptedException e){ }

		 new Useful().keepFirst("161.246.4.3");
		new Useful().keepSecond("161.246.4.3");try{sleep(2000);} catch (InterruptedException e){ }
		 new Useful().keepFirst("161.246.6.10");
		new Useful().keepSecond("161.246.6.10");try{sleep(2000);} catch (InterruptedException e){ }




		while (true) {	

			pc6157.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc6127.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc6117.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc652.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc653.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc654.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc658.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc670.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc6130.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }
			pc6121.conCheck(); 	try{sleep(8000);} catch (InterruptedException e){ }

			server43.conCheck();try{sleep(8000);} catch (InterruptedException e){ }
			swit610.conCheck();	try{sleep(8000);} catch (InterruptedException e){ }

		}



	}

}



class Pc {

	public boolean flag1=true, flag2=true, firsttime=true;
	public String ip;
	public int mid;
	Useful m = new Useful();

	Pc(String n,int formids){
		ip=n; mid=formids;
	}


	public void conCheck(){

			String inoctetVar1  = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.10.1");
			String inoctetVar2  = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.10.2");

			String outoctetVar1 = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.16.1");
			String outoctetVar2 = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.16.2");

			if ( !inoctetVar1.equals("#")        && !inoctetVar2.equals("#")   && 
				 !outoctetVar1.equals("#")       && !outoctetVar2.equals("#")   ) { 	 			

					if (flag1==true && firsttime==true){

						java.util.Date d = new java.util.Date();
						String date = d.toString();
						int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
						String timemill = java.lang.Integer.toString(temptimemill);

						try{
							m.insertInOutDevice(ip+"#1",date,timemill,"true",m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n","e","e","e","e","n","n","n","n","n","n");
							m.insertInOutDevice(ip+"#2",date,timemill,"true",m.cutString(inoctetVar2),m.cutString(outoctetVar2),"n","n","n","n","n","n","e","e","e","e","n","n","n","n","n","n");
						}
						catch ( Exception ex) { }

						flag1 = false;
						System.out.println(ip+" completed pe1.1");
					}					
					else
					if (flag1==true && firsttime==false){

						java.util.Date d = new java.util.Date();
						String date = d.toString();
						int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
						String timemill = java.lang.Integer.toString(temptimemill);

						try{
							m.insertInOutDevice(ip+"#1",date,timemill,"false","0","0","n","n","n","n","n","n","e","e","e","e","n","n","n","n","n","n");
							m.insertInOutDevice(ip+"#2",date,timemill,"false","0","0","n","n","n","n","n","n","e","e","e","e","n","n","n","n","n","n");
						}
						catch ( Exception ex) { }

						flag1 = false;
						System.out.println(ip+" completed pe1.2");
					}



					int timetss = (int)(System.currentTimeMillis()/1000-900000000);

					if (timetss > mid ){

						int tt = timetss-mid;
						tt = tt/86400+1;								

						java.util.Date dz = new java.util.Date();
						String datez = dz.toString();

						String temptimetss = java.lang.Integer.toString(timetss);
						try{
							m.insertDataMid(ip+"#1",temptimetss,datez,m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n");
							m.insertDataMid(ip+"#2",temptimetss,datez,m.cutString(inoctetVar2),m.cutString(outoctetVar2),"n","n","n","n","n","n");
						}
						catch ( Exception ex) { }

						mid = mid + 86400*tt;
						System.out.println(ip+" "+mid);
					}



					if (flag2==true){
						try{
							m.insertKeepAllTime(ip+"#1",m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n");
							m.insertKeepAllTime(ip+"#2",m.cutString(inoctetVar2),m.cutString(outoctetVar2),"n","n","n","n","n","n");
						}
						catch ( Exception ex) { }

						flag2 = false;
						System.out.println(ip+" completed pe2.1");
					}					
					else {
						try{
							m.updateKeepAllTime(ip+"#1",m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n");
							m.updateKeepAllTime(ip+"#2",m.cutString(inoctetVar2),m.cutString(outoctetVar2),"n","n","n","n","n","n");
						}
						catch ( Exception ex) { }

						System.out.println(ip+" completed pe2.2");
					}

			}
			else {

					if (flag2==false){

						m.selectAndUpdate(ip+"#1",ip+"#2");
						m.deleteKeepAllTime(ip+"#1");
						m.deleteKeepAllTime(ip+"#2");

						flag1 = true;
						flag2 = true;
						
						System.out.println(ip+" full complete");
						if (ip.equals("161.246.6.157") || ip.equals("161.246.6.127") || 
						    ip.equals("161.246.6.58")  || //ip.equals("161.246.6.52")  || 
							ip.equals("161.246.4.3")   || ip.equals("161.246.6.10") ){
							m.Pager(ip);
							System.out.println(ip+" Pager complete");
						}

					}

			}			

			firsttime = false;
	}		

}




class Server {

	public boolean flag1=true, flag2=true, firsttime=true;
	public String ip;
	public int mid;
	Useful m = new Useful();

	Server(String n,int formids){
		ip=n; mid=formids;
	}


	public void conCheck(){

			String inoctetVar1  = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.10.3");
			String inoctetVar2  = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.10.4");

			String outoctetVar1 = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.16.3");
			String outoctetVar2 = m.queryHost(ip,"1.3.6.1.2.1.2.2.1.16.4");

			String singleCol    = m.queryHost(ip,"1.3.6.1.2.1.10.7.2.1.4.4");
			String multiCol     = m.queryHost(ip,"1.3.6.1.2.1.10.7.2.1.5.4");
			String deferTran    = m.queryHost(ip,"1.3.6.1.2.1.10.7.2.1.7.4");

			if ( !inoctetVar1.equals("#") && !inoctetVar2.equals("#") && !outoctetVar1.equals("#")  && !outoctetVar2.equals("#")  && 
				 !singleCol.equals("#")   && !multiCol.equals("#")    && !deferTran.equals("#")   ) { 	 			

					if (flag1==true && firsttime==true){

						java.util.Date d = new java.util.Date();
						String date = d.toString();
						int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
						String timemill = java.lang.Integer.toString(temptimemill);

						try{
							m.insertInOutDevice(ip+"#1",date,timemill,"true",m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n","e","e","e","e","n","n","n","n","n","n");
							m.insertInOutDevice(ip+"#2",date,timemill,"true",m.cutString(inoctetVar2),m.cutString(outoctetVar2),m.cutString(singleCol),m.cutString(multiCol),m.cutString(deferTran),"n","n","n","e","e","e","e","e","e","e","n","n","n");
						}
						catch ( Exception ex) { }

						flag1 = false;
						System.out.println(ip+" completed pe1.1");
					}					
					else
					if (flag1==true && firsttime==false){

						java.util.Date d = new java.util.Date();
						String date = d.toString();
						int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
						String timemill = java.lang.Integer.toString(temptimemill);

						try{
							m.insertInOutDevice(ip+"#1",date,timemill,"false","0","0","n","n","n","n","n","n","e","e","e","e","n","n","n","n","n","n");
							m.insertInOutDevice(ip+"#2",date,timemill,"false","0","0","0","0","0","n","n","n","e","e","e","e","e","e","e","n","n","n");
						}
						catch ( Exception ex) { }

						flag1 = false;
						System.out.println(ip+" completed pe1.2");
					}



					int timetss = (int)(System.currentTimeMillis()/1000-900000000);

					if (timetss > mid ){

						int tt = timetss-mid;
						tt = tt/86400+1;								

						java.util.Date dz = new java.util.Date();
						String datez = dz.toString();

						String temptimetss = java.lang.Integer.toString(timetss);
						try{
							m.insertDataMid(ip+"#1",temptimetss,datez,m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n");
							m.insertDataMid(ip+"#2",temptimetss,datez,m.cutString(inoctetVar2),m.cutString(outoctetVar2),m.cutString(singleCol),m.cutString(multiCol),m.cutString(deferTran),"n","n","n");
						}
						catch ( Exception ex) { }

						mid = mid + 86400*tt;
						System.out.println(ip+" "+mid);
					}




					if (flag2==true){
						try{
							m.insertKeepAllTime(ip+"#1",m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n");
							m.insertKeepAllTime(ip+"#2",m.cutString(inoctetVar2),m.cutString(outoctetVar2),m.cutString(singleCol),m.cutString(multiCol),m.cutString(deferTran),"n","n","n");
						}
						catch ( Exception ex) { }

						flag2 = false;
						System.out.println(ip+" completed pe2.1");
					}					
					else {
						try{
							m.updateKeepAllTime(ip+"#1",m.cutString(inoctetVar1),m.cutString(outoctetVar1),"n","n","n","n","n","n");
							m.updateKeepAllTime(ip+"#2",m.cutString(inoctetVar2),m.cutString(outoctetVar2),m.cutString(singleCol),m.cutString(multiCol),m.cutString(deferTran),"n","n","n");
						}
						catch ( Exception ex) { }

						System.out.println(ip+" completed pe2.2");
					}

			}
			else {

					if (flag2==false){

						m.selectAndUpdate(ip+"#1",ip+"#2");
						m.deleteKeepAllTime(ip+"#1");
						m.deleteKeepAllTime(ip+"#2");

						flag1 = true;
						flag2 = true;
						
						System.out.println(ip+" full complete");
						m.Pager(ip);
					}

			}			

			firsttime = false;
	}		

}



class Switch {

	public boolean flag1=true, flag2=true, firsttime=true, firstflag=true;
	public String ip;
	public int htime;
	public int tempvaria;
	Useful m = new Useful();

	Switch(String n,int hhtime){
		ip=n; htime=hhtime; //htime=53903630;
	}


	public void conCheck(){

			boolean sflag = true;
			String varia[]  = new String[19]; //0..18  0..6	

			int varia2[] = new int[19]; //0..18  0..6				
			int varia3[] = new int[19]; //0..18  0..6				
			String temph = "5.";
			String sumh  = "";

heres:		for (int i=1; i<19; i++){  //1..18  1..6    1,2,3  4,5,6
				sumh = "1.3.6.1.2.1.16.1.1.1." + temph + java.lang.Integer.toString((i-1)/3+1+100);
				varia[i] = m.queryHost(ip,sumh);
				if (varia[i].equals("#")) {sflag = false; break heres;}
				if (temph.equals("5.")) temph="8."; else if(temph.equals("8.")) temph="13."; else temph="5.";
			}


			if (sflag==true){

					if (flag1==true && firsttime==true){

						java.util.Date d = new java.util.Date();
						String date = d.toString();
						int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
						String timemill = java.lang.Integer.toString(temptimemill);

						for (int j=1; j<7; j++){  //1..2    1..6
								try{
									m.insertInOutDevice(ip+"#"+java.lang.Integer.toString(j) ,date,timemill,"true","n","n","n","n","n",m.cutString(varia[j*3-2]) ,m.cutString(varia[j*3-1]) ,m.cutString(varia[j*3]),"e","e","n","n","n","n","n","e","e","e");
								}
								catch ( Exception ex) { }
						}					

						flag1 = false;
						System.out.println(ip+" completed pe1.1");
					}					
					else
					if (flag1==true && firsttime==false){

						java.util.Date d = new java.util.Date();
						String date = d.toString();
						int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
						String timemill = java.lang.Integer.toString(temptimemill);

						for (int j=1; j<7; j++){  //1..2   1..6
								try{
									m.insertInOutDevice(ip+"#"+java.lang.Integer.toString(j) ,date,timemill,"false","n","n","n","n","n","0","0","0","e","e","n","n","n","n","n","e","e","e");
								}
								catch ( Exception ex) { }
						}					

						flag1 = false;
						System.out.println(ip+" completed pe1.2");
					}



					int rcurren = (int)(System.currentTimeMillis()/1000-900000000);

					if (rcurren > htime ){

						java.util.Date dx = new java.util.Date();
						String datex = dx.toString();

						String rcurrenn = java.lang.Integer.toString(rcurren);


						if (firstflag==false){
//latest past 
								varia2[1]  = finddb(rcurren,"161.246.6.10#1","octet");
								varia2[2]  = finddb(rcurren,"161.246.6.10#1","crc");
								varia2[3]  = finddb(rcurren,"161.246.6.10#1","colli");
								varia2[4]  = finddb(rcurren,"161.246.6.10#2","octet");
								varia2[5]  = finddb(rcurren,"161.246.6.10#2","crc");
								varia2[6]  = finddb(rcurren,"161.246.6.10#2","colli");
								varia2[7]  = finddb(rcurren,"161.246.6.10#3","octet");
								varia2[8]  = finddb(rcurren,"161.246.6.10#3","crc");
								varia2[9]  = finddb(rcurren,"161.246.6.10#3","colli");
								varia2[10] = finddb(rcurren,"161.246.6.10#4","octet");
								varia2[11] = finddb(rcurren,"161.246.6.10#4","crc");
								varia2[12] = finddb(rcurren,"161.246.6.10#4","colli");
								varia2[13] = finddb(rcurren,"161.246.6.10#5","octet");
								varia2[14] = finddb(rcurren,"161.246.6.10#5","crc");
								varia2[15] = finddb(rcurren,"161.246.6.10#5","colli");
								varia2[16] = finddb(rcurren,"161.246.6.10#6","octet");
								varia2[17] = finddb(rcurren,"161.246.6.10#6","crc");
								varia2[18] = finddb(rcurren,"161.246.6.10#6","colli");


							for (int j=1; j<19; j++) {

								tempvaria = java.lang.Integer.parseInt(m.cutString(varia[j]).trim()) ;
								varia3[j] = tempvaria-varia2[j];
							}

							for (int j=1; j<7; j++){  //1..2    1..6
									try{
										insertForSwitch(ip+"#"+java.lang.Integer.toString(j),rcurrenn,datex,m.cutString(varia[j*3-2]) ,m.cutString(varia[j*3-1]) ,m.cutString(varia[j*3]),java.lang.Integer.toString(varia3[j*3-2]),java.lang.Integer.toString(varia3[j*3-1]),java.lang.Integer.toString(varia3[j*3]));
									}
									catch ( Exception ex) { }
							}

//							for (int j=1; j<19 ; j++)  varia2[j]=varia[j];
							
							System.out.println(ip+" Cont "+htime);							


						}
						else{

							for (int j=1; j<7; j++){  //1..2    1..6
									try{
										insertForSwitch(ip+"#"+java.lang.Integer.toString(j),rcurrenn,datex,m.cutString(varia[j*3-2]) ,m.cutString(varia[j*3-1]) ,m.cutString(varia[j*3]),"n","n","n");
									}
									catch ( Exception ex) { }
							}
							System.out.println(ip+" Firsttime");							
							firstflag= false;
						}

						htime = htime+3600;
//						System.out.println(ip+" "+htime);

					}





					if (flag2==true){

						for (int j=1; j<7; j++){  //1..2    1..6
								try{
									m.insertKeepAllTime(ip+"#"+java.lang.Integer.toString(j) ,"n","n","n","n","n",m.cutString(varia[j*3-2]) ,m.cutString(varia[j*3-1]) ,m.cutString(varia[j*3]));
								}
								catch ( Exception ex) { }
						}					

						flag2 = false;
						System.out.println(ip+" completed pe2.1");
					}					
					else {

						for (int j=1; j<7; j++){  //1..2    1..6
								try{
									m.updateKeepAllTime(ip+"#"+java.lang.Integer.toString(j) ,"n","n","n","n","n",m.cutString(varia[j*3-2]) ,m.cutString(varia[j*3-1]) ,m.cutString(varia[j*3]));
								}
								catch ( Exception ex) { }
						}					

						System.out.println(ip+" completed pe2.2");
					}

			}
			else {

					if (flag2==false){

//						m.selectAndUpdate(ip+"#1",ip+"#2");
						selectAndUpdate(ip,6);

						for (int j=1; j<7; j++){  //1..2    1..6
								try{
									m.deleteKeepAllTime(ip+"#"+java.lang.Integer.toString(j));
								}
								catch ( Exception ex) { }
						}					

						flag1 = true;
						flag2 = true;
						
						System.out.println(ip+" full complete");
						m.Pager(ip);
					}

			}			

			firsttime = false;
	}		


  public int finddb(int re,String ip,String col){ 
   int wanted = 25000;
   re = re -3600;

   try{ 
	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
	Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");

	Statement stmt88 = null;	
	stmt88 = conn.createStatement();
	ResultSet rs88 = stmt88.executeQuery("select * from forswitch order by timemill");

bb:	while (rs88.next())
	{
		if (rs88.getString("inter").equals(ip) && 
			(java.lang.Integer.parseInt(rs88.getString("timemill")) <=(re+300) &&  java.lang.Integer.parseInt(rs88.getString("timemill")) >=(re-300) ) ){
			wanted = java.lang.Integer.parseInt(rs88.getString(col).trim());	
			break bb;
		}
	}

   } catch ( Exception ex) {} 

   return wanted;

  }



  public void insertForSwitch (String pinterVar,String tt,String dateq,String a,String b,String c,String d,String e,String f) throws SQLException {
	String sql = "INSERT INTO forswitch VALUES (?,?,?,?,?,?,?,?,?)";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinterVar);
		pstmt.setString (2,tt);
		pstmt.setString (3,dateq);
		pstmt.setString (4,a);
		pstmt.setString (5,b);
		pstmt.setString (6,c);
		pstmt.setString (7,d);
		pstmt.setString (8,e);
		pstmt.setString (9,f);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException ee) { System.err.println(ee.getMessage()); }
  }




  public void selectAndUpdate (String pinter,int num) {

	String  dtemp[] = new String[num+1];
	String  etemp[] = new String[num+1];
	String  ftemp[] = new String[num+1];

	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		Statement stmt4 = null;	
		stmt4 = conn.createStatement();
		ResultSet rs4 = stmt4.executeQuery("select * from keepalltime");

		while (rs4.next())     // not optimize : found but go , however it's ok
		{
			if (rs4.getString("inter").equals(pinter+"#1") ){ dtemp[1] = rs4.getString("octet"); etemp[1] = rs4.getString("crc"); ftemp[1] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#2") ){ dtemp[2] = rs4.getString("octet"); etemp[2] = rs4.getString("crc"); ftemp[2] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#3") ){ dtemp[3] = rs4.getString("octet"); etemp[3] = rs4.getString("crc"); ftemp[3] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#4") ){ dtemp[4] = rs4.getString("octet"); etemp[4] = rs4.getString("crc"); ftemp[4] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#5") ){ dtemp[5] = rs4.getString("octet"); etemp[5] = rs4.getString("crc"); ftemp[5] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#6") ){ dtemp[6] = rs4.getString("octet"); etemp[6] = rs4.getString("crc"); ftemp[6] = rs4.getString("colli"); } //else
/*
			if (rs4.getString("inter").equals(pinter+"#7") ){ dtemp[7] = rs4.getString("octet"); etemp[7] = rs4.getString("crc"); ftemp[7] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#8") ){ dtemp[8] = rs4.getString("octet"); etemp[8] = rs4.getString("crc"); ftemp[8] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#9") ){ dtemp[9] = rs4.getString("octet"); etemp[9] = rs4.getString("crc"); ftemp[9] = rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#10")){ dtemp[10]= rs4.getString("octet"); etemp[10]= rs4.getString("crc"); ftemp[10]= rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#11")){ dtemp[11]= rs4.getString("octet"); etemp[11]= rs4.getString("crc"); ftemp[11]= rs4.getString("colli"); } else
			if (rs4.getString("inter").equals(pinter+"#12")){ dtemp[12]= rs4.getString("octet"); etemp[12]= rs4.getString("crc"); ftemp[12]= rs4.getString("colli"); } 
*/
		}
	}
	catch ( Exception ex) { }


	java.util.Date d = new java.util.Date();
	String date = d.toString();
	int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
	String timemill = java.lang.Integer.toString(temptimemill);

	for (int j=1; j<7; j++){  //1..2      1..6
		try{
				updateInOutDevice(pinter+"#"+java.lang.Integer.toString(j) ,date,timemill,dtemp[j],etemp[j],ftemp[j],"e");
		}
		catch ( Exception ex) { }
	}					

	System.out.println("half complete");
 }


  public void updateInOutDevice (String pinterVar,String pdateVar2,String ptimemillVar2,String d,String e,String f,String pdateVar1) throws SQLException {
	String sql = "UPDATE inoutdevice SET date2 = ? , timemill2 = ? , octet2 = ? , crc2 = ? , colli2 = ? where inter = ? and date2 = ?";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pdateVar2);
		pstmt.setString (2,ptimemillVar2);
		pstmt.setString (3,d);
		pstmt.setString (4,e);
		pstmt.setString (5,f);
		pstmt.setString (6,pinterVar);
		pstmt.setString (7,pdateVar1);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException ee) { System.err.println(ee.getMessage()); }
  }

}



class Useful{
  URL ujung;
  String query_page;

public void Pager(String mesg)
{
		String s = "http://www.phonelink.net/cgi-bin/inetplcgi990601";
		String IP = mesg;
		int Num1 = IP.length();
		String charcount = java.lang.Integer.toString(Num1);


		
		query_page = "cPhone=320708&cMesg=" + URLEncoder.encode("Computer at IP: ");
		query_page += URLEncoder.encode(IP);
		query_page += URLEncoder.encode(" is dead. Please go to check it Now!");
		query_page += "&CHARCOUNT=" + charcount;
				
		try
		{
			ujung	 = new  URL(s);
			submitdata();
		}
		catch (MalformedURLException e)
		{}
}

	public void submitdata()
	{

		try
		{
			URLConnection uc = ujung.openConnection();
			uc.setDoOutput(true);
			uc.setDoInput(true);
			uc.setAllowUserInteraction(false);
			DataOutputStream dos = new DataOutputStream(uc.getOutputStream());
			dos.writeBytes(query_page);
			dos.close();

			DataInputStream dis = new DataInputStream(uc.getInputStream());
			String nextline;
			while ((nextline = dis.readLine()) != null)
			{
//			System.out.println(nextline);
			}
			dis.close();
			}
			catch (Exception e)
			{}
	}


  public void insertDataMid (String pinterVar,String tt,String dateq,String pinoctetVar,String poutoctetVar,String a,String b,String c,String d,String e,String f) throws SQLException {
	String sql = "INSERT INTO datamid VALUES (?,?,?,?,?,?,?,?,?,?,?)";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinterVar);
		pstmt.setString (2,tt);
		pstmt.setString (3,dateq);
		pstmt.setString (4,pinoctetVar);
		pstmt.setString (5,poutoctetVar);
		pstmt.setString (6,a);
		pstmt.setString (7,b);
		pstmt.setString (8,c);
		pstmt.setString (9,d);
		pstmt.setString (10,e);
		pstmt.setString (11,f);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException ee) { System.err.println(ee.getMessage()); }
  }


	public int findmid(int wanted){ 

			int timec = (int)(System.currentTimeMillis()/1000-900000000);
			System.out.println(timec);		
			
			if (timec > wanted){

				int forcu = timec - wanted;
				System.out.println(forcu);

				int be = forcu/86400+1;
				System.out.println(be);

				be = wanted + 86400*be;

				return be;
			}

			return wanted;

	}



  public void deleteTable (String ptableVar) {
	String sql = "DELETE FROM "+ ptableVar ;
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException e) { System.err.println(e.getMessage()); }
  }


  
  public void deleteKeepAllTime (String pinterVar) {
	String sql = "DELETE FROM keepalltime WHERE inter = ?";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinterVar);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException e) { System.err.println(e.getMessage()); }
  }



  public void selectAndUpdate (String pinterVar1,String pinterVar2) {
	String  inoctet1temp = "",inoctet2temp = "",outoctet1temp = "",outoctet2temp = "";
	String  atemp1 = "",atemp2 = "",btemp1 = "",btemp2 = "",ctemp1 = "",ctemp2 = "";
	
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		Statement stmt4 = null;	
		stmt4 = conn.createStatement();
		ResultSet rs4 = stmt4.executeQuery("select * from keepalltime");

		while (rs4.next())     // not optimize : found but go , however it's ok
		{
			if (rs4.getString("inter").equals(pinterVar1) ){
					inoctet1temp = rs4.getString("inoctet");
					outoctet1temp = rs4.getString("outoctet");
					atemp1 = rs4.getString("singlecol");
					btemp1 = rs4.getString("multicol");
					ctemp1 = rs4.getString("defertran");
			}
			else
			if (rs4.getString("inter").equals(pinterVar2) ){
					inoctet2temp = rs4.getString("inoctet");
					outoctet2temp = rs4.getString("outoctet");
					atemp2 = rs4.getString("singlecol");
					btemp2 = rs4.getString("multicol");
					ctemp2 = rs4.getString("defertran");
			}
		}
	}
	catch ( Exception ex) { }


	java.util.Date d = new java.util.Date();
	String date = d.toString();
	int  temptimemill = (int)(System.currentTimeMillis()/1000-900000000);
	String timemill = java.lang.Integer.toString(temptimemill);

	try{
		updateInOutDevice(pinterVar1,date,timemill,inoctet1temp,outoctet1temp,atemp1,btemp1,ctemp1,"e");
		updateInOutDevice(pinterVar2,date,timemill,inoctet2temp,outoctet2temp,atemp2,btemp2,ctemp2,"e");
	}
	catch ( Exception ex) { }					

	System.out.println("half complete");

 }


  public void updateInOutDevice (String pinterVar,String pdateVar2,String ptimemillVar2,String pinoctetVar2,String poutoctetVar2,String a,String b,String c,String pdateVar1) throws SQLException {
	String sql = "UPDATE inoutdevice SET date2 = ? , timemill2 = ? , inoctet2 = ? , outoctet2 = ? , singlecol2 = ? , multicol2 = ? , defertran2 = ? where inter = ? and date2 = ?";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pdateVar2);
		pstmt.setString (2,ptimemillVar2);
		pstmt.setString (3,pinoctetVar2);
		pstmt.setString (4,poutoctetVar2);
		pstmt.setString (5,a);
		pstmt.setString (6,b);
		pstmt.setString (7,c);
		pstmt.setString (8,pinterVar);
		pstmt.setString (9,pdateVar1);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException e) { System.err.println(e.getMessage()); }
  }



  public void updateKeepAllTime (String pinterVar,String pinoctetVar,String poutoctetVar,String a,String b,String c,String d,String e,String f) throws SQLException {
	String sql = "UPDATE keepalltime SET inoctet = ? , outoctet = ? , singlecol = ? , multicol = ? , defertran = ? , octet = ? , crc = ? , colli = ? where inter = ?";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinoctetVar);
		pstmt.setString (2,poutoctetVar);
		pstmt.setString (3,a);
		pstmt.setString (4,b);
		pstmt.setString (5,c);
		pstmt.setString (6,d);
		pstmt.setString (7,e);
		pstmt.setString (8,f);
		pstmt.setString (9,pinterVar);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException ee) { System.err.println(ee.getMessage()); }
  }


  public void insertKeepAllTime (String pinterVar,String pinoctetVar,String poutoctetVar,String a,String b,String c,String d,String e,String f) throws SQLException {
	String sql = "INSERT INTO keepalltime VALUES (?,?,?,?,?,?,?,?,?)";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinterVar);
		pstmt.setString (2,pinoctetVar);
		pstmt.setString (3,poutoctetVar);
		pstmt.setString (4,a);
		pstmt.setString (5,b);
		pstmt.setString (6,c);
		pstmt.setString (7,d);
		pstmt.setString (8,e);
		pstmt.setString (9,f);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException ee) { System.err.println(ee.getMessage()); }
  }



  public void insertInOutDevice (String pinterVar,String pdateVar1,String ptimemillVar1,String pbackingVar,String pinoctetVar1,String poutoctetVar1,String a,String b,String c,String d,String e,String f,String pdateVar2,String ptimemillVar2,String pinoctetVar2,String poutoctetVar2,String a2,String b2,String c2,String d2,String e2,String f2) throws SQLException {
	String sql = "INSERT INTO inoutdevice VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinterVar);
		pstmt.setString (2,pdateVar1);
		pstmt.setString (3,ptimemillVar1);
		pstmt.setString (4,pbackingVar);
		pstmt.setString (5,pinoctetVar1);
		pstmt.setString (6,poutoctetVar1);
		pstmt.setString (7,a);
		pstmt.setString (8,b);
		pstmt.setString (9,c);
		pstmt.setString (10,d);
		pstmt.setString (11,e);
		pstmt.setString (12,f);

		pstmt.setString (13,pdateVar2);
		pstmt.setString (14,ptimemillVar2);
		pstmt.setString (15,pinoctetVar2);
		pstmt.setString (16,poutoctetVar2);
		pstmt.setString (17,a2);
		pstmt.setString (18,b2);
		pstmt.setString (19,c2);
		pstmt.setString (20,d2);
		pstmt.setString (21,e2);
		pstmt.setString (22,f2);

		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException ee) { System.err.println(ee.getMessage()); }
  }


  public void insertInterface (String pinterVar,String pdescriptionVar,String ptypeVar,String pspeedVar) throws SQLException {
	String sql = "INSERT INTO interface VALUES (?,?,?,?)";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pinterVar);
		pstmt.setString (2,pdescriptionVar);
		pstmt.setString (3,ptypeVar);
		pstmt.setString (4,pspeedVar);
		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException e) { System.err.println(e.getMessage()); }
  }


  public void insertDevice (String pipVar,String pdescriptionVar,String pobjectidVar,String puptimeVar,String pcontactVar,String pnameVar,String plocationVar,String pservicesVar) throws SQLException {
	String sql = "INSERT INTO device VALUES (?,?,?,?,?,?,?,?)";
	try{
		Connection conn = DriverManager.getConnection ("jdbc:oracle:thin:@161.246.6.160:1521:kai","system", "manager");
		PreparedStatement pstmt = conn.prepareStatement (sql);
		pstmt.setString (1,pipVar);
		pstmt.setString (2,pdescriptionVar);
		pstmt.setString (3,pobjectidVar);
		pstmt.setString (4,puptimeVar);
		pstmt.setString (5,pcontactVar);
		pstmt.setString (6,pnameVar);
		pstmt.setString (7,plocationVar);
		pstmt.setString (8,pservicesVar);
		pstmt.execute();
		pstmt.close();
		conn.close();
	} catch (SQLException e) { System.err.println(e.getMessage()); }
  }



  public String queryHost(String host, String oid) {
	String temp = "#";
	try { 
 
		InetAddress snmpHost = InetAddress.getByName(host);
		DatagramSocket sock = new DatagramSocket();
		sock.setSoTimeout(3000);

	    // create pdu.
		Var var = new Var(oid);
		OctetString c = new OctetString("public");
		sck.Integer requestId = new sck.Integer(0);
		sck.Integer errorIndex = new sck.Integer(0);
		sck.Integer errorStatus = new sck.Integer(0);
		PduCmd pdu = new PduCmd(Pdu.GET,requestId,errorStatus,errorIndex,new VarList(var));
		sck.Message m = new sck.Message(c,pdu);

		// send
		byte[] b = m.codeBer();
		DatagramPacket packet = new DatagramPacket(b,b.length,snmpHost,161);
		byte[] b2 = new byte[1024];
		DatagramPacket p2 = new DatagramPacket(b2,b2.length);

	    sock.send(packet);
		sock.receive(p2); 
        
	    // display 
	    ByteArrayInputStream ber = new ByteArrayInputStream(b2,1,p2.getLength()-1); // without tag !
		sck.Message m2 = new sck.Message(ber);
  
		temp = m2.getPdu().getVarList().elementAt(0).toString();	

		sock.close();
	} 
	catch ( Exception ex) { 
//		System.out.println(ex);
	}
	return temp;	
  }


	public String cutString(String forcut){
		String ready = "";
		StringTokenizer st = new StringTokenizer(forcut);
		String s1 = st.nextToken();
		String s2 = st.nextToken();
		while (st.hasMoreTokens())
			ready = ready + st.nextToken() + " ";
		return ready;
	}


	public void keepFirst(String hostname){

		String result     = queryHost(hostname,"1.3.6.1.2.1.1.1.0");
		if (!result.equals("#")){
		
			String descriptionVar = queryHost(hostname,"1.3.6.1.2.1.1.1.0");
			String objectidVar    = queryHost(hostname,"1.3.6.1.2.1.1.2.0");
			String uptimeVar      = queryHost(hostname,"1.3.6.1.2.1.1.3.0");
			String contactVar     = queryHost(hostname,"1.3.6.1.2.1.1.4.0");
			String nameVar        = queryHost(hostname,"1.3.6.1.2.1.1.5.0");
			String locationVar    = queryHost(hostname,"1.3.6.1.2.1.1.6.0");
			String servicesVar    = queryHost(hostname,"1.3.6.1.2.1.1.7.0");


			if ( !descriptionVar.equals("#") && !objectidVar.equals("#") &&
		  		 !uptimeVar.equals("#")      && !contactVar.equals("#")  &&
				 !nameVar.equals("#")        && !locationVar.equals("#") &&
				 !servicesVar.equals("#")  ) {

					try{
						insertDevice(hostname,cutString(descriptionVar),cutString(objectidVar),cutString(uptimeVar),cutString(contactVar),cutString(nameVar),cutString(locationVar),cutString(servicesVar));
					}
					catch ( Exception ex) { }
			}

		}
			System.out.println("completed KeepFirst");
		
	}




	public void keepSecond(String hostname){
											//other but 161.246.4.3 and 161.246.6.10
here: if (!hostname.equals("161.246.4.3") && !hostname.equals("161.246.6.10") ){ 
		
		String result     = queryHost(hostname,"1.3.6.1.2.1.1.1.0");
		if (!result.equals("#")){
		
			String descriptionVar1 = queryHost(hostname,"1.3.6.1.2.1.2.2.1.2.1");
			String typeVar1        = queryHost(hostname,"1.3.6.1.2.1.2.2.1.3.1");
			String speedVar1       = queryHost(hostname,"1.3.6.1.2.1.2.2.1.5.1");

			String descriptionVar2 = queryHost(hostname,"1.3.6.1.2.1.2.2.1.2.2");
			String typeVar2		   = queryHost(hostname,"1.3.6.1.2.1.2.2.1.3.2");
			String speedVar2       = queryHost(hostname,"1.3.6.1.2.1.2.2.1.5.2");

			if ( !descriptionVar1.equals("#") && !typeVar1.equals("#") && !speedVar1.equals("#") &&
				 !descriptionVar2.equals("#") && !typeVar2.equals("#") && !speedVar2.equals("#")    ) {

					try{
						insertInterface(hostname+"#1",cutString(descriptionVar1),cutString(typeVar1),cutString(speedVar1));
						insertInterface(hostname+"#2",cutString(descriptionVar2),cutString(typeVar2),cutString(speedVar2));
					}
					catch ( Exception ex) { }
			}

		}
	   
	  }
	  else
	  if (hostname.equals("161.246.4.3") ){

		String result     = queryHost(hostname,"1.3.6.1.2.1.1.1.0");
		if (!result.equals("#")){
		
			String descriptionVar1 = queryHost(hostname,"1.3.6.1.2.1.2.2.1.2.3");
			String typeVar1        = queryHost(hostname,"1.3.6.1.2.1.2.2.1.3.3");
			String speedVar1       = queryHost(hostname,"1.3.6.1.2.1.2.2.1.5.3");

			String descriptionVar2 = queryHost(hostname,"1.3.6.1.2.1.2.2.1.2.4");
			String typeVar2		   = queryHost(hostname,"1.3.6.1.2.1.2.2.1.3.4");
			String speedVar2       = queryHost(hostname,"1.3.6.1.2.1.2.2.1.5.4");

			if ( !descriptionVar1.equals("#") && !typeVar1.equals("#") && !speedVar1.equals("#") &&
				 !descriptionVar2.equals("#") && !typeVar2.equals("#") && !speedVar2.equals("#")    ) {

					try{
						insertInterface(hostname+"#1",cutString(descriptionVar1),cutString(typeVar1),cutString(speedVar1));
						insertInterface(hostname+"#2",cutString(descriptionVar2),cutString(typeVar2),cutString(speedVar2));
					}
					catch ( Exception ex) { }
			}

		}	   	   
	  
	  }
      else{  //161.246.6.10

		String result     = queryHost(hostname,"1.3.6.1.2.1.1.1.0");
		if (!result.equals("#")){

			String varia[] = new String[19]; //0..6 0..18		
			String temph = "2.";
			String sumh  = "";

			for (int i=1; i<19; i++){  //1..6 1..18
				sumh = "1.3.6.1.2.1.2.2.1." + temph + java.lang.Integer.toString((i-1)/3+1+100);
				varia[i] = queryHost(hostname,sumh);
				if (varia[i].equals("#")) break here;
				if (temph.equals("2.")) temph="3."; else if(temph.equals("3.")) temph="5."; else temph="2.";
			}
			
			for (int j=1; j<7; j++){  //1..2 1..6
					try{
						insertInterface(hostname+"#"+java.lang.Integer.toString(j) ,cutString(varia[j*3-2]) ,cutString(varia[j*3-1]) ,cutString(varia[j*3]));
					}
					catch ( Exception ex) { }
			}					

		}  //first if (result)   	   
	  }	  // continued from else
			
	  System.out.println("completed KeepSecond");
	}  //end method


}