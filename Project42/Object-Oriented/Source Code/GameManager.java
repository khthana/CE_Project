import java.awt.*;
import java.util.*;
import java.net.*;
import java.io.*;
import java.applet.*;

public class GameManager extends Applet
{
	int				diceX =	100,diceY = 87;
	int				scoreX = 540,scoreY = 100;
	int				countQuestion = 0;

	boolean			startG = false,mouseClick = true,drawAll = false;
	boolean			readKey = false,AnswerKey = false,drawP = false;
	String			Question = "",answer = "",history = "";
	String			flag = null,flagKey = null;
	Image			ImageDice[] = new Image[6],ImageMap,ImagePlayer;
	Image			ImagePlayer1,ImagePlayer2,ImagePlayer3,ImagePlayer4;
	Image			imageBlock,imageQuestion,imageBonus,imageMinus;
	MediaTracker	t;
	boolean			TheEnd = false,choiceQ = false;

	Graphics		offscreen;
	Image			buffer_image;

	Image			ImageTurn,ImageAns;


	PlayerControl p = new PlayerControl(this);
	PlayerControl PlayerPlay = new PlayerControl(this);
	Dice		  d = new Dice(this);
	MapType		  m = new MapType(this);

	Vector arrayOfPlayer = new Vector();
	
	promtpFrame pf;
	public SWClient client;
	String theHost;
	int thePort;

	public void init()
	{
		setBackground(Color.black);

		ImageTurn	= getImage(getCodeBase(),"Image/Turn.gif");
		ImageAns	= getImage(getCodeBase(),"Image/Ans.gif");
//============== load image ================
		ImagePlayer1  = getImage(getCodeBase(),"Image/Player1.gif");
		ImagePlayer2  = getImage(getCodeBase(),"Image/Player2.gif");
		ImagePlayer3  = getImage(getCodeBase(),"Image/Player3.gif");
		ImagePlayer4  = getImage(getCodeBase(),"Image/Player4.gif");
		imageBlock    = getImage(getCodeBase(),"Image/Normal.jpg");
		imageQuestion = getImage(getCodeBase(),"Image/Question1.jpg");
		imageBonus    = getImage(getCodeBase(),"Image/Bonus.jpg");
		imageMinus    = getImage(getCodeBase(),"Image/Minus.jpg");
//============== / load image ================
		t = new MediaTracker(this);
//============== load image to MediaTracker ===================
		for (int i=0; i<6; i++) {
		ImageDice[i] = getImage(getCodeBase(),"Image/Dice" +i+ ".gif");
		t.addImage(ImageDice[i],0);
		}

System.out.println("Loading");
		// wait for all image
		try {
			t.waitForAll();
		}
		catch (InterruptedException e) {
		}
		// check error
		if (t.isErrorAny()) {
System.out.println("Error Load Image");
		}
		else if (t.checkAll()) {
System.out.println("Successfully Load");
		}
//*************
		promptUser();
		getHostName();
	}

//*************
	public void promptUser() 
	{
		pf = new promtpFrame(this);
		pf.setTitle("Logon box");
		pf.resize(330,260);
		pf.show();
	}

	public void getHostName()
	{
		String temp;

		temp = getParameter("host");
		if ( temp == null) theHost = "161.246.6.114";
		else theHost = temp;

		temp = getParameter("port");

		try 
		{
			thePort = Integer.valueOf(temp).intValue();
		}
		catch(Exception e) 
		{
			thePort = 5000;
		}
	}

	public void onConnect()
	{
		try
		{
			if (client == null)
			{
				InetAddress ip = InetAddress.getByName(theHost);
				client = new SWClient(this,ip,thePort);
				client.start();
			}
		}
		catch(IOException ex)
		{
			ex.printStackTrace();
		}
	}

	public void onDisconnect()
	{
		if (client != null)
		{
			client.Stop();
			client = null;
		}
	}

	public boolean mouseDown(Event evt,int x,int y)
	{
		if (mouseClick && (flag.compareTo(client.clientName) == 0) && !p.chkEndOfPlayer())
		{
			int	image_width,image_height;
			image_width  = ImageDice[0].getWidth(null);
			image_height = ImageDice[0].getHeight(null);

			if (x >= diceX)								// start point of X position
				if (y >= diceY)							// start point of Y position
					if (x <= diceX + image_width)		// 
						if (y <= diceY + image_height)	//
						{
							mouseClick	= false;
							client.MessageToServer("Dice&&" +d.RandomDice());	// 0-5
						}
		}
		return true;
	}

	public boolean keyDown(Event evt,int key)
	{
		if (readKey)
		{
			if (!AnswerKey & (flag.compareTo(client.clientName) == 0) & !p.chkEndOfPlayer())
			{
				PlayerControl onePlayer = new PlayerControl(this);

				if (key == 49)
				{
					onePlayer = (PlayerControl)arrayOfPlayer.elementAt(0);
				}
				else if (key == 50 & arrayOfPlayer.size() == 2)
				{
					onePlayer = (PlayerControl)arrayOfPlayer.elementAt(1);
				}
				else if (key == 51 & arrayOfPlayer.size() == 3)
				{
					onePlayer = (PlayerControl)arrayOfPlayer.elementAt(2);
				}
				else if (key == 52 & arrayOfPlayer.size() == 4)
				{
					onePlayer = (PlayerControl)arrayOfPlayer.elementAt(3);
				}
				else 
				{
					onePlayer = p;
				}

				AnswerKey = true;
				client.MessageToServer("WhoAreAns&&" +onePlayer.getName());
			}
			else if (flagKey.compareTo(client.clientName) == 0)
			{
				if ((key == 49) && answer.equals("1"))
				{
					client.MessageToServer("Answer&&true" );
				}
				else if ((key == 50) && answer.equals("2"))
					{
						client.MessageToServer("Answer&&true" );
					}
				else if ((key == 51) && answer.equals("3"))
					{
						client.MessageToServer("Answer&&true" );
					}
				else if ((key == 52) && answer.equals("4"))
					{
						client.MessageToServer("Answer&&true" );
					}
				else 
				{
					client.MessageToServer("Answer&&false" );
				}

				AnswerKey = false;
			}
		}
		return true;
	}

// this method for Main class call & send value of block 
	public void CheckMap(int noBlock)
	{
		String temp;

		temp = m.arrayOfMap[noBlock - 1].getTypeOfBlock();
		if (temp.compareTo("question") == 0) 
		{ 
			readKey	= true;
			mouseClick	= false;
			drawP = true;

//			AnswerKey = true;
			choiceQ = true;
			drawPlayerAnswer();

/*			if (flag.compareTo(client.clientName) == 0)
			{
				client.MessageToServer("getQuestion&& ");
			}
*/		}
		else if (temp.compareTo("bonus") == 0) 
			{
				int tmp = 0;
				tmp = p.getScore();
				p.score += m.arrayOfMap[p.blockNumber-1].getScore();
				drawScore();

				mouseClick	= true;
				if (flag.compareTo(client.clientName) == 0)
				{
					client.MessageToServer("NextPlayer&&" +flag);
				}

			}
		else if (temp.compareTo("minus") == 0) 
			{
				int tmp = 0;
				tmp = p.getScore();
				p.score += m.arrayOfMap[p.blockNumber-1].getScore();
				drawScore();

				mouseClick	= true;
				if (flag.compareTo(client.clientName) == 0)
				{
					client.MessageToServer("NextPlayer&&" +flag);
				}
			}
		else
		{
			mouseClick	= true;
			if (flag.compareTo(client.clientName) == 0)
			{
				client.MessageToServer("NextPlayer&&" +flag);
			}
		}
	}

	public void chkAnswer(boolean chkanswer)
	{
		PlayerControl onePlayer = new PlayerControl(this);

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			if (onePlayer.getName().compareTo(flagKey) == 0) break;
		}

		if (chkanswer )
		{
			if (flagKey.compareTo(client.clientName) == 0) drawMessage("คุณตอบถูกแล้ว คำตอบคือข้อ " +answer +" )",480,325,Color.green,4); 
			onePlayer.setScore(onePlayer.getScore() + 10);		//m.arrayOfMap[blockNumber-1].getScore();
		}
		else 
		{
			if (flagKey.compareTo(client.clientName) == 0) drawMessage("คุณตอบผิด คำตอบคือข้อ " +answer +" )",480,325,Color.red,4); 
			onePlayer.setScore(onePlayer.getScore() - 10);		//m.arrayOfMap[blockNumber-1].getScore();
		}

		drawAllScore();

		if (flag.compareTo(client.clientName) == 0)
		{
			client.MessageToServer("NextPlayer&&" +client.clientName);
		}
	}

	public void initGame()
	{
		Graphics g = getGraphics();
		g.setColor(Color.black);
		g.fillRect(0,0,800,600);
		g.dispose();

		m.initBlock();

		p.initPlayer();
		d.initDice();

		scoreX = 540;scoreY = 100;
		readKey = false;mouseClick = true;
		Question = "";answer = "";

		drawP = false;
		AnswerKey = false;
		choiceQ = false;
		TheEnd = false;

		repaint();
	}

	public void clearAllPlayer()
	{
		 arrayOfPlayer.removeAllElements();
	}

	public void removeOnePlayer(String nameForRemove)
	{
		PlayerControl onePlayer = new PlayerControl(this);

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			if (onePlayer.getName().compareTo(nameForRemove) == 0) arrayOfPlayer.removeElementAt(i);
		}
	}

	public void initAllPlayer(String NameList)
	{
		StringTokenizer st = new StringTokenizer(NameList,"@@");

		// clear vector before
		if (!arrayOfPlayer.isEmpty()) clearAllPlayer();
		
		while (st.hasMoreTokens())
		{
			PlayerControl onePlayer = new PlayerControl(this);
		
			onePlayer.setName(st.nextToken());
			
			if (arrayOfPlayer.size() == 0)
			{
				onePlayer.setNumber(0);
				onePlayer.setImagePlayer(ImagePlayer1);
				onePlayer.setScoreY(scoreY);
			}
			else if (arrayOfPlayer.size() == 1)
				{
					onePlayer.setNumber(1);
					onePlayer.setImagePlayer(ImagePlayer2);
					onePlayer.setScoreY(scoreY += 20);
				}
			else if (arrayOfPlayer.size() == 2)
				{
					onePlayer.setNumber(2);
					onePlayer.setImagePlayer(ImagePlayer3);
					onePlayer.setScoreY(scoreY += 20);
				}
			else if (arrayOfPlayer.size() == 3)
				{
					onePlayer.setNumber(3);
					onePlayer.setImagePlayer(ImagePlayer4);
					onePlayer.setScoreY(scoreY += 20);
				}
			
			arrayOfPlayer.addElement(onePlayer);
		}
		drawAll = true;

		p = (PlayerControl)arrayOfPlayer.elementAt(0);
	}

	public void NextPlayer(String nextToPlayer)
	{
		PlayerControl onePlayer = new PlayerControl(this);

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);

			if (onePlayer.getName().compareTo(flag)==0)
			{
				arrayOfPlayer.setElementAt(p,i);
				break;
			}
		}

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);

			if (onePlayer.getName().compareTo(nextToPlayer)==0)
			{
				p = (PlayerControl)arrayOfPlayer.elementAt(i);
				break;
			}
		}
	}

	public void chkEndGame()
	{
		boolean chkEndGame = true;
		PlayerControl onePlayer = new PlayerControl(this);

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			if (!onePlayer.chkEndOfPlayer()) chkEndGame = false;
		}

		if (chkEndGame)
		{
client.MessageToServer("***** Game is End Turn *****&& ");
			TheEnd = true;
			EndGame();
		}
	}
// * + * + * + * + * + * + * + * + * + * + * + * + * + * + * + * + * + *
	public void EndPlayer(String PlayerRemoved)
	{
		PlayerControl onePlayer = new PlayerControl(this);

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			if (onePlayer.getName().compareTo(PlayerRemoved) == 0)
			{
				onePlayer.endOfPlayer = true;
				break;
			}
		}
	}
// * + * + * + * + * + * + * + * + * + * + * + * + * + * + * + * + * + *
	public void EndGame()
	{
		String	his = "";

		PlayerControl onePlayer = new PlayerControl(this);
		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			his += onePlayer.getName() +"||" +onePlayer.getScore();
			if (i != arrayOfPlayer.size()-1) his += "@@";
		}

		onePlayer = (PlayerControl)arrayOfPlayer.elementAt(0);
		if (client.clientName.compareTo(onePlayer.getName())==0) pf.onPlay.enable();
		if (client.clientName.compareTo(flag)==0) client.MessageToServer("History&&" +his);
		TheEnd = true;
		startG = false;

/**		String	ScoreForHis = "";
		Graphics g = getGraphics();
		g.setColor(Color.pink);
		g.fillRect(0,0,800,600);
		
		int j = 100;
		Color c = Color.blue;
		PlayerControl onePlayer = new PlayerControl(this);
		Font f = new Font("Dialog",Font.BOLD,18);
		g.setFont(f);
//======= draw Names & Scores =======
		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			if (onePlayer.getNumber() == 0)
			{
				drawMessage(onePlayer.getName() +" : ",200,100,Color.blue,2);
				g.setColor(Color.blue);
				g.drawString(onePlayer.getScore()+"",scoreX,onePlayer.scoreY);
			}
			else if (onePlayer.getNumber() == 1)
			{
				drawMessage(onePlayer.getName() +" : ",200,120,Color.magenta,2);
				g.setColor(Color.magenta);
				g.drawString(onePlayer.getScore()+"",scoreX,onePlayer.scoreY);
			}
			else if (onePlayer.getNumber() == 2)
			{
				drawMessage(onePlayer.getName() +" : ",200,140,Color.yellow,2);
				g.setColor(Color.yellow);
				g.drawString(onePlayer.getScore()+"",scoreX,onePlayer.scoreY);
			}
			else if (onePlayer.getNumber() == 3)
			{
				drawMessage(onePlayer.getName() +" : ",200,160,Color.green,2);
				g.setColor(Color.green);
				g.drawString(onePlayer.getScore()+"",scoreX,onePlayer.scoreY);
			}
		}

		g.dispose();
		startG = false;

		onePlayer = (PlayerControl)arrayOfPlayer.elementAt(0);
		if (onePlayer.getName().compareTo(client.clientName)==0) pf.onPlay.enable();
//client.MessageToServer("EndGame&&" +ScoreForHis);
*/	}

	public void delay(int i)
	{
		try	{ Thread.sleep(i); }
		catch (InterruptedException e) {}
	}

	public void update(Graphics g)
	{
		paint(g);
	}	

	public void paint(Graphics g)
	{
		if (startG)
		{
			m.initBlock();
//			drawPlayer();
			drawDice(d.getDice());
			drawNameForScore();		//***************
			drawAllScore();
			drawAllPlayer();	
//			drawScore();
			if (choiceQ) drawPlayerAnswer();
			else drawQuestion(Question);
			if (drawP) drawPlayerAnswer();
			drawTurn();
		}
		else if (TheEnd) drawHistory();//EndGame();
	}

	public void drawTurn()
	{
		String chk;
		if (AnswerKey) chk = flagKey;
		else chk = flag;

		if (!TheEnd)
		{
			int		x = 375,y = 90;
			int		width  = ImageTurn.getWidth(null);

			Graphics g = getGraphics();

			g.setColor(Color.black);
			g.fillRect(375,90,width,80);
			PlayerControl onePlayer = new PlayerControl(this);

			for (int i=0; i<arrayOfPlayer.size(); i++)
			{
				onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
				if (onePlayer.getName().compareTo(chk) == 0)
				{
					if (onePlayer.getNumber() == 0)
					{
						x = 375;
						y = 90;
					}
					else if (onePlayer.getNumber() == 1)
						{
							x = 375;
							y = 110;
						}
					else if (onePlayer.getNumber() == 2)
						{
							x = 375;
							y = 130;
						}
					else if (onePlayer.getNumber() == 3)
						{
							x = 375;
							y = 150;
						}
				}
			}
			if (!AnswerKey) g.drawImage(ImageTurn,x,y,this);
			else g.drawImage(ImageAns,x,y,this);
			g.dispose();
		}
	}

	public void drawHistory()
	{
		int hisX = 500,hisY = 100;
		String temp = null;

		Graphics g = getGraphics();

		g.setColor(Color.pink);
		g.fillRect(0,0,800,600);
		Font f = new Font("Dialog",Font.PLAIN,18);
		g.setFont(f);
		g.setColor(Color.red);
		g.drawString("== History ==",310,50);

		StringTokenizer st = new StringTokenizer(history,"@@");
		while (st.hasMoreTokens())
		{
			StringTokenizer st2 = new StringTokenizer(st.nextToken(),"||");
			//R.setName(st2.nextToken());
			g.setColor(Color.black);
			g.drawString(st2.nextToken(),200,hisY);
			//R.setScore(st2.nextToken());
			g.setColor(Color.black);
			temp = st2.nextToken();
			if (temp.length() >= 4) g.drawString(temp,hisX-30,hisY);
			else if (temp.length() == 3) g.drawString(temp,hisX-20,hisY);
			else if (temp.length() == 2) g.drawString(temp,hisX-10,hisY);
			else if (temp.length() == 1) g.drawString(temp,hisX,hisY);
			hisY += 20;
		}
		g.dispose();
	}

	public void drawPlayerAnswer()
	{
		Graphics g = getGraphics();

		int iiX = 110,iiY = 212;
		Color color = Color.pink;

		g.setColor(Color.black);		// =====|
		g.fillRect(101,191,549,137);	// clear old 
		g.setColor(color);				// =====|
		g.drawRect(100,190,551,139);	// draw frame 

		PlayerControl onePlayer = new PlayerControl(this);
		int i = arrayOfPlayer.size();

		drawMessage(" จะให้ใครเป็นคนตอบคำถามนี้ดีล่ะ",iiX,iiY,color,2);

		onePlayer = (PlayerControl)arrayOfPlayer.elementAt(0);
		drawMessage("1 : " +onePlayer.getName(),iiX+20,iiY += 40,color,1);

		if (i >= 2)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(1);
			drawMessage("2 : " +onePlayer.getName(),iiX+20,iiY += 20,color,1);
		}
		if (i >= 3)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(2);
			drawMessage("3 : " +onePlayer.getName(),iiX+20,iiY += 20,color,1);
		}
		if (i >= 4)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(3);
			drawMessage("4 : " +onePlayer.getName(),iiX+20,iiY += 20,color,1);
		}
			g.dispose();
	}

	public void drawDice(int i)
	{
		Graphics g = getGraphics();
		g.drawImage(ImageDice[i],diceX,diceY,this);
		g.dispose();
	}

	public void drawQuestion(String s)
	{
		int iiX = 110,iiY = 212;
		Color colors = Color.orange;
		Question = s;

		Graphics g = getGraphics();
		g.setColor(colors);				// =====|
		g.drawRect(100,190,551,139);	// draw frame question
		g.setColor(Color.black);		// =====|
		g.fillRect(101,191,549,137);	// clear old question
		g.dispose();


		StringTokenizer st = new StringTokenizer(s,"|");
		String temp = st.nextToken();

		if (temp.length() >= 90)
		{
			drawMessage(temp.substring(0,90),iiX,iiY,colors,2);
			drawMessage(temp.substring(90,temp.length()),iiX,iiY+20,colors,2);
		}
		else drawMessage(temp,iiX,iiY,colors,2);
		drawMessage(st.nextToken(),iiX+20,iiY += 40,colors,1);
		drawMessage(st.nextToken(),iiX+20,iiY += 20,colors,1);
		drawMessage(st.nextToken(),iiX+20,iiY += 20,colors,1);
		drawMessage(st.nextToken(),iiX+20,iiY += 20,colors,1);
		answer = st.nextToken();
	}

	public void drawMessage(String s,int x,int y,Color c,int type)
	{
		Font f1 = new Font("Dialog",Font.PLAIN,14);
		Font f2 = new Font("Dialog",Font.BOLD,14);
		Font f3 = new Font("Dialog",Font.PLAIN,10);
		Font f4 = new Font("Dialog",Font.BOLD,10);
		Font f5 = new Font("Dialog",Font.PLAIN,22);
		Font f6 = new Font("Dialog",Font.BOLD,22);
		
		Graphics g = getGraphics();

		if ( type == 2 ) g.setFont(f2);
		else if ( type == 3 ) g.setFont(f2);
		else if ( type == 4 ) g.setFont(f2);
		else if ( type == 5 ) g.setFont(f2);
		else if ( type == 6 ) g.setFont(f2);
		else g.setFont(f1);

		g.setColor(c);
		g.drawString(s,x,y);

		g.dispose();
	}

	public void drawMap()
	{
		int x,y;
		String temp = "";

		Graphics g = getGraphics();
		for (int i=0; i<32; i++)
		{		
			x = m.arrayOfMap[i].getPositionX();
			y = m.arrayOfMap[i].getPositionY();

			temp = m.arrayOfMap[i].getTypeOfBlock();

			if (temp.compareTo("question") == 0) g.drawImage(imageQuestion,x,y,this);
			else if (temp.compareTo("bonus") == 0) g.drawImage(imageBonus,x,y,this);
			else if (temp.compareTo("minus") == 0) g.drawImage(imageMinus,x,y,this);
			else g.drawImage(imageBlock,x,y,this);
		}
		g.dispose();
	}

	public void drawBlock(String type,int x,int y)
	{
		Graphics g = getGraphics();
		if (type.compareTo("question") == 0) g.drawImage(imageQuestion,x,y,this);
		else if (type.compareTo("bonus") == 0) g.drawImage(imageBonus,x,y,this);
		else if (type.compareTo("minus") == 0) g.drawImage(imageMinus,x,y,this);
		else g.drawImage(imageBlock,x,y,this);
		g.dispose();
	} 

	public void drawAllPlayer()
	{
		PlayerControl onePlayer  = new PlayerControl(this);
		Color color;

		Graphics g = getGraphics();

		if (drawAll) 
		{
			for (int j=0; j < arrayOfPlayer.size(); j++)
			{
				onePlayer = (PlayerControl)arrayOfPlayer.elementAt(j);
				g.drawImage(onePlayer.getImagePlayer(),onePlayer.getPositionX(),onePlayer.getPositionY(),this);
			}
		}
		g.dispose();
	}

	public void drawPlayer()
	{
		Graphics g = getGraphics();
		g.drawImage(p.getImagePlayer(),p.getPositionX(),p.getPositionY(),this);
		g.dispose();
	}

	public void drawPlayer(int i,int x,int y)
	{
		String  temp;
		Graphics g = getGraphics();

		g.drawImage(p.getImagePlayer(),x,y,this);
		
		delay(100);

		if (i == 1) { i = 31; }
		else i -= 2;
// ===== repair block =====
		temp = m.arrayOfMap[i].getTypeOfBlock();
		if (temp.compareTo("question") == 0) g.drawImage(imageQuestion,m.arrayOfMap[i].getPositionX(),m.arrayOfMap[i].getPositionY(),this);
		else if (temp.compareTo("bonus") == 0) g.drawImage(imageBonus,m.arrayOfMap[i].getPositionX(),m.arrayOfMap[i].getPositionY(),this);
		else if (temp.compareTo("minus") == 0) g.drawImage(imageMinus,m.arrayOfMap[i].getPositionX(),m.arrayOfMap[i].getPositionY(),this);
		else g.drawImage(imageBlock,m.arrayOfMap[i].getPositionX(),m.arrayOfMap[i].getPositionY(),this);
		drawMessage(m.arrayOfMap[i].getNumber()+"",m.arrayOfMap[i].getPositionX()+50,m.arrayOfMap[i].getPositionY()+55,Color.blue,3);

		drawAllPlayer();
		g.dispose();
	}

	public void drawScore()
	{
		Font f = new Font("Dialog",Font.BOLD,16);
		
		Graphics g = getGraphics();
		
		g.setColor(Color.black);
		g.fillRect(480,p.scoreY-12,100,13);
		g.setFont(f);
		g.setColor(Color.pink);
		chkDigit(p.getScore());
		g.drawString(p.getScore()+"",scoreX,p.scoreY);
		g.dispose();
	}

	public void drawAllScore()
	{
		PlayerControl onePlayer = new PlayerControl(this);
		Font f = new Font("Dialog",Font.BOLD,16);
		
		Graphics g = getGraphics();
		g.setFont(f);		
		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			g.setColor(Color.black);
			g.fillRect(480,onePlayer.scoreY-12,100,13);
			g.setColor(Color.pink);
			chkDigit(onePlayer.getScore());
			g.drawString(onePlayer.getScore()+"",scoreX,onePlayer.scoreY);
		}
		g.dispose();
	}

	public void drawNameForScore()
	{
		PlayerControl onePlayer = new PlayerControl(this);

		for (int i=0; i<arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)arrayOfPlayer.elementAt(i);
			if (onePlayer.getNumber() == 0)
				drawMessage(onePlayer.getName() +" : ",400,100,Color.blue,2);
			else if (onePlayer.getNumber() == 1)
				drawMessage(onePlayer.getName() +" : ",400,120,Color.magenta,2);
			else if (onePlayer.getNumber() == 2)
				drawMessage(onePlayer.getName() +" : ",400,140,Color.yellow,2);
			else if (onePlayer.getNumber() == 3)
				drawMessage(onePlayer.getName() +" : ",400,160,Color.green,2);
		}
		drawTurn();
	}

	public void chkDigit(int digitScore)
	{
		if (digitScore < 0) digitScore *= -10;
		if (digitScore / 10 == 0) scoreX = 540;
		else if (digitScore/10 > 0 && digitScore/10  < 10) scoreX = 530;
		else if (digitScore/100 >= 0 && digitScore/100 < 10) scoreX = 520;
		else if (digitScore/1000 >= 0 && digitScore/1000 < 10) scoreX = 510;
		else if (digitScore/10000 >= 0 && digitScore/10000 < 10) scoreX = 500;
	}

}
// *************** Class ******************
class Dice
{
	GameManager main;
	int statusDice = 0;

	Dice(GameManager game)
	{
		main = game;
	}

	public void initDice()
	{
		statusDice = 0;
	}

	public void setDice(int i)
	{
		statusDice = i;
	}

	public int getDice()
	{
		return statusDice;
	}

	public void runDice()
	{
		for (int i=0; i<12; i++) {
			main.drawDice(RandomDice());
			main.delay(100);
		}
		main.drawDice(statusDice);
	}

	public int RandomDice()
	{
		Random r1 = new Random();
		int rand;

		// random by use Random() method
		rand = r1.nextInt();
		while (rand < 0)
		{
			rand = r1.nextInt();
		}
		// if random > 5 then rand mod 6 
		if (rand > 5) { rand = rand % 6; }

		return rand;
	}
}
// *************** Class ******************
class MapType
{
	GameManager main;

	int		temp = 0;

	public  Block[] arrayOfMap = new Block[32];		// array 0-31 = 32 block
	
	int[]	arrayRandomQuestion = new int[86];

	MapType(GameManager game)
	{
		main = game;
	}

	public void initMap(String randomMap)
	{
		int		x = 680,y = 348;
	// create normal block in map 
		for(int i=0; i<32; i++)
		{
			Block	b = new Block();
	
			b.setScore(0); 
			b.setTypeOfBlock("normal"); 
				
			if (i+1 == 1) {}
			else if (i+1 <= 11) { x -= 68; }
			else if (i+1 <= 17) { y -= 58; }
			else if (i+1 <= 27) { x += 68; }
			else if (i+1 <= 32) { y += 58; }
			b.setPosition(x,y);
			b.setNumber(i+1);

			arrayOfMap[i] = b;
		}
	
		String	Rblock = null;
		StringTokenizer st = new StringTokenizer(randomMap,"@@");
		for(int i=0; i<32; i++)
		{
			Rblock = st.nextToken();
		// if token = "1" that block is 'question block'
			if (Rblock.compareTo("1") == 0)
			{	
				arrayOfMap[i].setScore(10);
				arrayOfMap[i].setTypeOfBlock("question"); 
			}
		// if token = "2" that block is 'bonus block'
			else if (Rblock.compareTo("2") == 0)
			{
				arrayOfMap[i].setScore(50);
				arrayOfMap[i].setTypeOfBlock("bonus");
			}
		// if token = "3" that block is 'minus block'
			else if (Rblock.compareTo("3") == 0)
			{
				arrayOfMap[i].setScore(-50);
				arrayOfMap[i].setTypeOfBlock("minus");
			}
		}
		
		for (int i=0; i >=arrayRandomQuestion.length; i++)
		{
			arrayRandomQuestion[i] = 0;
		}
	}

	public void initBlock()	// draw all of block with arrange by arrayOfMap
	{
		for (int i=0; i <32; i++)
		{
			main.drawBlock(arrayOfMap[i].getTypeOfBlock(),arrayOfMap[i].getPositionX(),arrayOfMap[i].getPositionY());
			main.drawMessage(arrayOfMap[i].getNumber()+"",arrayOfMap[i].getPositionX()+50,arrayOfMap[i].getPositionY()+55,Color.blue,3);
		}
	}

}
// *************** Class ******************
class Block
{
	String  TypeChk;
	int		score;
	int		posX,posY;
	
	int		number;

	public void setNumber(int n)
	{
		number = n;
	}

	public int getNumber()
	{
		return number;
	}

	public void setPosition(int x,int y)
	{
		posX = x;
		posY = y;
	}

	public int getPositionX()
	{
		return posX;
	}

	public int getPositionY()
	{
		return posY;
	}

	public void setScore(int c)
	{
		score = c;
	}

	public int getScore()
	{
		return score;
	}

	public void setTypeOfBlock(String q)
	{
		TypeChk = q;
	}

	public String getTypeOfBlock()
	{
		return TypeChk;
	}
}
// *************** Class ******************
class PlayerControl
{
	GameManager main;

	int NumberOfPlayer = 0;
	int	x = 680, y = 348;
	int blockNumber = 1,round = 0;
	int scoreY = 174;
	int score = 50;
	String Name;
	boolean endOfPlayer = false;
	Image imagePlayer;

	PlayerControl(GameManager game)
	{
		main = game;
	}

	public void initPlayer()
	{
		x = 680; y = 348;
		blockNumber = 1; round = 0;
		score = 50;
	}

	public void playerRun(int dice)
	{
		for (int i=0; i <= dice; i++)
		{
			blockNumber++;

			if (blockNumber <= 11) { x -= 68; }
			else if (blockNumber <= 17) { y -= 58; }
			else if (blockNumber <= 27) { x += 68; }
			else if (blockNumber <= 32) { y += 58; }
			else if (blockNumber == 33)
					{
						y += 58; round++; blockNumber = 1;
						if (round == 2) endOfPlayer = true;
					}

			main.drawPlayer(blockNumber,x,y);
			main.delay(100);
		}
		
		if (!endOfPlayer) main.CheckMap(blockNumber); // ===== chk question block =====
		else 
		{
main.client.MessageToServer("***** " +Name +" is End Turn *****&& ");
			main.chkEndGame();
			if (main.flag.compareTo(main.client.clientName) == 0)
			{
				main.client.MessageToServer("NextPlayer&&" +main.client.clientName);
			}
		}
	}

	public void setNumber(int No)
	{
		NumberOfPlayer = No;
	}

	public int getNumber()
	{
		return NumberOfPlayer;
	}

	public void setName(String No)
	{
		Name = No;
	}

	public String getName()
	{
		return Name;
	}

	public void setImagePlayer(Image image)
	{
		imagePlayer = image;
	}

	public Image getImagePlayer()
	{
		return imagePlayer;
	}

	public void setScoreY(int poScoreY)
	{
		scoreY = poScoreY;
	}

	public int getScoreY()
	{
		return scoreY;
	}

	public void setScore(int sc)
	{
		score = sc;
	}

	public int getScore()
	{
		return score;
	}

	public boolean chkEndOfPlayer()
	{
		return endOfPlayer;
	}

	public int getPositionX()
	{
		return x;
	}

	public int getPositionY()
	{
		return y;
	}
}
//***************************************************************************************
//***************************************************************************************
/* this is a simple window that gets a name from the user */
class promtpFrame extends Frame 
{
	GameManager main;

	TextField TF,TF2;
	TextArea  TA;
	Choice	  choiceButton;
	List	  classDB,groupDB;
	int		  questionSelect;
	
	public String gotName = "NoName";
	public boolean isDisconnect = false,exit = true;

	protected Button onLogin,onLogout,onPlay,onSend;

	promtpFrame(GameManager game) 
	{
		main = game;

		choiceButton = new Choice();
		choiceButton.addItem("วิทยาศาสตร์1");
		choiceButton.addItem("วิทยาศาสตร์2");
		choiceButton.addItem("ภาษาอังกฤษ");		// english
		choiceButton.addItem("ศิลปะ & พละ");	// art & pala
		choiceButton.addItem("สังคมศึกษา");		// social
		choiceButton.addItem("จริย & พุทธ");	// ja-ri-ya serk-sa & buddhist

		setLayout( new FlowLayout() );
		add("North" ,      TA = new TextArea(5,48));
		add("Center" ,    TF2 = new TextField("",40));
		add("Center" , onSend = new Button("Send"));
		add("South",            new Label("Name :"));
		add("South",       TF = new TextField("NoName",8));
		add("South" , onLogin = new Button("Login"));
		add("South" ,onLogout = new Button("Logout"));
		add("South" ,  onPlay = new Button("Play>>"));
//		add("South" ,choiceButton);
		add("South" ,classDB  = new List(2,false));
		add("South" ,groupDB  = new List(4,false));

//		questionSelect = choiceButton.getItem(1);
		questionSelect = 0;

		TA.setEditable(false);
		onLogout.disable();
		onPlay.disable();

		setBackground(Color.lightGray);
		TA.setBackground(Color.white);

		classDB.addItem("== ระดับชั้น ==");
		groupDB.addItem("== หมวดคำถาม ==");
	}

	public void addList(String type,String items)
	{
		if (type.compareTo("Class")==0)
		{
			classDB.clear();

			classDB.addItem("== ระดับชั้น ==");
			StringTokenizer st = new StringTokenizer(items,"|");
			while (st.hasMoreTokens())
			{
				classDB.addItem(st.nextToken());
			}
			classDB.select(0);
		}
		else if (type.compareTo("Group")==0)
		{
			groupDB.clear();

			groupDB.addItem("== หมวดคำถาม ==");
			StringTokenizer st = new StringTokenizer(items,"|");
			while (st.hasMoreTokens())
			{
				groupDB.addItem(st.nextToken());
			}
			groupDB.select(0);
		}
	}

	public boolean handleEvent(Event evt) 
	{
		if (evt.id == Event.WINDOW_DESTROY & exit)
		{
			main.onDisconnect();
			removeFrame();
		}

		return super.handleEvent(evt);
	}

	public boolean action(Event evt,Object arg)
	{
		if (evt.target instanceof Button)
		{
			if (evt.arg.equals("Login"))
			{
				gotName = TF.getText();
				if (gotName.compareTo("NoName") != 0 )
				{
					if (gotName.length() > 8) gotName = gotName.substring(0,8); //name must range 1-8
					onLogin.disable();
					onLogout.enable();

					isDisconnect = false;
					main.onConnect();
				}
				else TA.setText("Please, Insert your name before !!");
			}
			if (evt.arg.equals("Logout"))
			{
				onLogin.enable();
				onLogout.disable();
				onPlay.disable();

				isDisconnect = true;

				TA.setText("");
				main.onDisconnect();
			}
			if (evt.arg.equals("Play>>"))
			{
				if ((classDB.getSelectedIndex() > 0) & (groupDB.getSelectedIndex() > 0))
				{
					onPlay.disable();
					onSend.disable();

					main.client.MessageToServer("StartGame&&" +classDB.getSelectedItem() +"|" +groupDB.getSelectedItem());
				}
			}
			if (evt.arg.equals("Send"))
			{
				main.client.MessageToServer("Message&&" +main.client.clientName +"||" +TF2.getText());
				TF2.setText("");
			}
		}
		else if (evt.target.equals(classDB) & classDB.getSelectedIndex() > 0)
		{
			main.client.MessageToServer("GroupDB&&" +classDB.getSelectedItem());
		}
		else return super.action(evt,arg);

		return true;
	}

	public void removeFrame()
	{
		dispose();
		System.exit(0);
	}

}
//---------------------------------------------------------------
class SWSocket extends Object 
{
	public int Number;
	public String name;
	public Socket socket;
	protected DataInputStream i;
	protected DataOutputStream o;

	SWSocket(Socket s) 
	{
		try 
		{
			socket = s;
			i = new DataInputStream(s.getInputStream());
			o = new DataOutputStream(s.getOutputStream());
		}
		catch (IOException ex) 
		{}
	}
  
	public String Get() 
	{
		String st;    
	    try 
		{
			st = i.readUTF();
		}
		catch (IOException ex)
		{
			ex.printStackTrace();
			st = null;
		}

		return st;
	}
  
	public void Send(String msg) 
	{
		try 
		{
			synchronized (o) 
			{
				o.writeUTF(msg);
				o.flush();
			}
		}
		catch (IOException ex)
		{}
	}

	public void setName(String s)
	{
		name = s;
	}

	public String getName()
	{
		return name;
	}
/*
	public void setNumber(int i)
	{
		Number = i;
	}

	public int getNumber()
	{
		return Number;
	}
*/
}
//-----------------------------------------------
class SWClient extends Thread			//Applet implements Runnable{
{		
	protected SWSocket sw;
	protected Socket s;
	protected String message;
	protected GameManager main;
	protected String clientName;
	protected boolean clientReady=false;

	protected String command,information;

	SWClient()
	{}

	SWClient(GameManager game,InetAddress ip,int port)
	{
  		main = game;
		clientName = main.pf.gotName;
System.out.println("Client:Connected to "+ip+" : "+port);

		try
		{
			s  = new Socket(ip,port);	
			sw = new SWSocket(s);
			sw.name = clientName;
		}
		catch(IOException ex)
		{}
	}

	public void run()
	{ 
		message = sw.Get();

		if (message.compareTo("Name?") == 0)
		{
 			sw.Send(clientName);
		}

		message = sw.Get();

		if (message.compareTo("NameIsRecur") == 0)
		{
			main.pf.TA.setText("This name is already. \n= Please Logout! \n= Insert another name.");
			Stop();
		}

		if (message.compareTo("CanNotConnect") == 0)
		{
			main.pf.TA.setText("Game had play \n= Please Logout! \n= Waiting until game has finish. ");
			Stop();
		}

		WaitForStartGame();
	}

//**********************************************************************
	public String listName()
	{
		String temp = "";
		PlayerControl onePlayer = new PlayerControl(main);

		for (int i=0; i<main.arrayOfPlayer.size(); i++)
		{
			onePlayer = (PlayerControl)main.arrayOfPlayer.elementAt(i);
			temp += " ";
			temp += onePlayer.getName();
		}
		return temp;
	}
//**********************************************************************

	public void WaitForStartGame()
	{
		String str;
    
		do 
		{
			str = sw.Get();
//========== receive command & information from Server
			StringTokenizer st = new StringTokenizer(str,"&&");

			command     = st.nextToken();
			information = st.nextToken();

			if (command.compareTo("ClassDB")==0)
			{
				main.pf.addList("Class",information);
			}
			if (command.compareTo("GroupDB")==0)
			{
				main.pf.addList("Group",information);
			}
			if (command.compareTo("LoginStatus")==0)
			{
				showLoginStatus(information);
			}
			if (command.compareTo("RemoveInfo")==0)
			{
				String PlayerRemoved,NextToPlayer;

				StringTokenizer st2 = new StringTokenizer(information,"||");
				PlayerRemoved	= st2.nextToken();
main.removeOnePlayer(PlayerRemoved);
//				main.EndPlayer(PlayerRemoved);
			}
			if (command.compareTo("LogPrompt")==0)
			{
				main.pf.onLogout.disable();
				main.pf.exit = false;
				main.pf.TA.setText(" Loading ...");
			}
			if (command.compareTo("StartGame")==0)
			{
				String setFlag,randomMap;

				StringTokenizer st2 = new StringTokenizer(information,"||");
				setFlag		= st2.nextToken();
				randomMap	= st2.nextToken();

				main.pf.TA.setText(" Load Complete.");
				main.pf.onLogout.enable();
				main.pf.onSend.enable();
				main.pf.exit = true;
				main.initAllPlayer(st2.nextToken());
				main.startG = true;
				main.TheEnd = false;
				main.flag = setFlag;
				main.m.initMap(randomMap);
				main.initGame();
				main.drawTurn();
			}
			if (command.compareTo("Dice") == 0)
			{
				main.d.setDice(String2Int(information));
				main.d.runDice();
				main.delay(500);
				main.p.playerRun(main.d.getDice());
			}
			if (command.compareTo("WhoAreAns") == 0)
			{
				StringTokenizer st2 = new StringTokenizer(information,"@@");
				main.flagKey		= st2.nextToken();
				main.drawP		= false;
				main.drawQuestion(st2.nextToken());

				main.choiceQ	= false;
				main.AnswerKey	= true;
				main.mouseClick	= false;
				main.readKey	= true;
				main.drawTurn();
			}
			if (command.compareTo("Question") == 0)
			{
				main.mouseClick	= false;
				main.readKey	= true;
				main.drawP		= false;
				main.choiceQ	= false;
				main.drawQuestion(information);
			}
			if (command.compareTo("Answer") == 0)
			{
				main.mouseClick	= true;
				main.readKey	= false;
				main.AnswerKey	= false;

//				if (information.compareTo("true") == 0) main.p.chkAnswer(true);
				if (information.compareTo("true") == 0) main.chkAnswer(true);
				else main.chkAnswer(false);
			}
			if (command.compareTo("NextPlayer") == 0)
			{
				main.mouseClick = true;
				main.readKey	= false;
				main.AnswerKey	= false;

				main.NextPlayer(information);
				main.flag = information;

				if (!main.TheEnd && main.p.chkEndOfPlayer())
				{
					if (main.arrayOfPlayer.size() != 1)	MessageToServer("NextPlayer&&" +main.flag);
					else 
					{
						main.TheEnd = true;
						main.EndGame();
					}
				}
				main.drawTurn();
			}
			if (command.compareTo("History")==0)
			{
				main.history = information;
				main.drawHistory();
			}
			if (command.compareTo("Message")==0)
			{
				String nameM,text;
				StringTokenizer st2 = new StringTokenizer(information,"||");

				nameM	= st2.nextToken();
				text	= st2.nextToken();
				main.pf.TA.appendText("\n" +nameM +" > " +text);
			}
//========== receive command & information from Server
		}
		while(!main.pf.isDisconnect);
	 }

	protected int String2Int(String s)
	{
		int integer = 0;

		if (s.compareTo("1") == 0) integer = 1;
		else if (s.compareTo("2") == 0) integer = 2;
		else if (s.compareTo("3") == 0) integer = 3;
		else if (s.compareTo("4") == 0) integer = 4;
		else if (s.compareTo("5") == 0) integer = 5;
		else if (s.compareTo("6") == 0) integer = 6;

		return integer;
	}

	public void showLoginStatus(String str)
	{
		String NumberOne;
		StringTokenizer st = new StringTokenizer(str,"@@");

		main.pf.TA.setText("== Active Players. ==");

		if (st.hasMoreTokens())
		{
			NumberOne = st.nextToken();
			if (NumberOne.compareTo(sw.getName()) == 0) main.pf.onPlay.enable();
				
			main.pf.TA.appendText("\nPlayer 1 : " +NumberOne);
		}
		if (st.hasMoreTokens()) main.pf.TA.appendText("\nPlayer 2 : " +st.nextToken());
		if (st.hasMoreTokens()) main.pf.TA.appendText("\nPlayer 3 : " +st.nextToken());
		if (st.hasMoreTokens()) main.pf.TA.appendText("\nPlayer 4 : " +st.nextToken());
	}

	public void MessageToServer(String msg)
	{
			sw.Send(msg);
	}

	public void Stop() 
	{
		try 
		{
			MessageToServer("Disconnect&& ");
			sw.socket.close();
			this.stop();
		}
		catch ( IOException ex) 
		{}  
	}
}
