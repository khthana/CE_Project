#include <owl/owlpch.h>
#include <owl/applicat.h>
#include <owl/framewin.h>
#include <owl/dc.h>
#include <owl/inputdia.h>
#include <classlib/arrays.h>
#include <stdlib.h>
#include "menu3.rc"
#include<iostream.h>
#include<fstream.h>
#include<math.h>
#include<except.h>
typedef TArray<TPoint> TPoints;
typedef TArrayIterator<TPoint> TPointsIterator;

class TDrawWindow : public TWindow {
  public:
	 TDrawWindow(TWindow* parent = 0);
	~TDrawWindow()
	 {
		delete DragDC;
		delete Pen;
		delete Line;
	 }
	 void Coordinate();
	 void Coordinate1();
	 void Coordinate2();
	 void de_allocate(long double **);
	 long double getZc(long double data1);
	 long double getTc(int i,long double alpha);
	 long double getFc(long double alpha,int j, int k);
	 void Curve(long double min,long double max);
	 void Curvef(long double min,long double max);
	 void SetPenSize(int newSize);
	 void line(TPoint point1,TPoint point2);
  protected:
	 int n;
	 int m;
	 long double** data;
	 TDC* DragDC;
	 int PenSize;
	 TPen* Pen;
	 TPoints* Line; // To store points in line.

	 // Override member function of TWindow
	 bool CanClose();

	 // Message response functions
	 void EvLButtonDown(uint, TPoint&);
	 void EvRButtonDown(uint, TPoint&);
	 void EvMouseMove(uint, TPoint&);
	 void EvLButtonUp(uint, TPoint&);
	 void Paint(TDC&, bool, TRect&);
	 void CmZtestRtail();
	 void CmZtestLtail();
	 void CmZtestDtail();
	 void CmTtestRtail();
	 void CmTtestLtail();
	 void CmTtestDtail();
	 void CmFtestRtail();
	 void CmFtestLtail();
	 void CmFtestDtail();
	 void CmAbout();

  DECLARE_RESPONSE_TABLE(TDrawWindow);
};

DEFINE_RESPONSE_TABLE1(TDrawWindow, TWindow)
  EV_WM_LBUTTONDOWN,
  EV_WM_RBUTTONDOWN,
  EV_WM_MOUSEMOVE,
  EV_WM_LBUTTONUP,
  EV_COMMAND(CM_ZTESTRTAIL, CmZtestRtail),
  EV_COMMAND(CM_ZTESTLTAIL, CmZtestLtail),
  EV_COMMAND(CM_ZTESTDTAIL, CmZtestDtail),
  EV_COMMAND(CM_TTESTRTAIL, CmTtestRtail),
  EV_COMMAND(CM_TTESTLTAIL, CmTtestLtail),
  EV_COMMAND(CM_TTESTDTAIL, CmTtestDtail),
  EV_COMMAND(CM_FTESTRTAIL, CmFtestRtail),
  EV_COMMAND(CM_FTESTLTAIL, CmFtestLtail),
  EV_COMMAND(CM_FTESTDTAIL, CmFtestDtail),
  EV_COMMAND(CM_ABOUT, CmAbout),
END_RESPONSE_TABLE;

TDrawWindow::TDrawWindow(TWindow* parent)
{
  Init(parent, 0, 0);
  DragDC  = 0;
  PenSize = 1;
  n=10;
  m=1;
  Pen     = new TPen(TColor::Black, PenSize);
  Line    = new TPoints(10, 0, 10);
  MessageBox("Testting procedure of STATISTICS EXPERT SYSTEM -1996\nDo you want to continue ?",
				  "Welcome !!!",
						  MB_OK | MB_ICONEXCLAMATION) ;
}

bool
TDrawWindow::CanClose()
{
  return MessageBox("Do you want to save?", "Drawing has changed",
						  MB_YESNO | MB_ICONQUESTION) == IDNO;
}

void
TDrawWindow::EvLButtonDown(uint, TPoint& point)
{
  Line->Flush();
  Invalidate();

  if (!DragDC) {
	 SetCapture();
	 DragDC = new TClientDC(*this);
	 DragDC->SelectObject(*Pen);
	 DragDC->MoveTo(point);
	 Line->Add(point);
	 }

}

void
TDrawWindow::EvRButtonDown(uint, TPoint&)
{
  char inputText[6];

  wsprintf(inputText, "%d", PenSize);
  if ((TInputDialog(this, "pensize",
								"Input a new thickness:",
								inputText,
								sizeof(inputText))).Execute() == IDOK)
								 {
	 int newPenSize = atoi(inputText);

	 if (newPenSize < 0)
		newPenSize = 1;

	 SetPenSize(newPenSize);
  }
}

void
TDrawWindow::EvMouseMove(uint, TPoint& point)
{
  if (DragDC) {
	 DragDC->LineTo(point);
	 Line->Add(point);
  }
}

void
TDrawWindow::EvLButtonUp(uint, TPoint&)
{
  if (DragDC) {
	 ReleaseCapture();
	 delete DragDC;
	 DragDC = 0;
  }
}

void
TDrawWindow::SetPenSize(int newSize)
{
  delete Pen;
  PenSize = newSize;
  Pen     = new TPen(TColor::Black, PenSize);
}



void
TDrawWindow::Paint(TDC& dc, bool, TRect&)
{
  bool first = true;
  TPointsIterator i(*Line);

  dc.SelectObject(*Pen);

  while (i) {
	 TPoint p = i++;

	 if (!first)
		dc.LineTo(p);
	 else {
		dc.MoveTo(p);
		first = false;
	 }
  }
}

void
TDrawWindow::CmZtestRtail()
{
 Coordinate();
 Curve(-200,200);
  //****************************
long double alpha=0.4881;
long double Zt=1.256;
long double Zc;
Zc=getZc(0.5-alpha);
 TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Zc=%d", Zc );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Zt<Zc)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}
void
TDrawWindow::CmZtestLtail()
{
Coordinate();
Curve(-200,200);
long double alpha=0.4881;
long double Zt=1.2456;
long double Zc;
Zc=-getZc(0.5-alpha) ;
	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Zc=%d", Zc );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Zt<Zc)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}

void
TDrawWindow::CmZtestDtail()
{
  Coordinate();
  Curve(-200,200);
  long double alpha=0.9762;
long double Zt=1.2456;
long double Zc1,Zc2;
Zc1 = getZc(0.5-alpha/2);
Zc2 = -getZc(0.5-alpha/2);
	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Zc=%d%d", Zc1,Zc2 );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Zc2<Zt&&Zt<Zc1)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}

void
TDrawWindow::CmTtestRtail()
{
  Coordinate1();
 Curve(-200,200);
 long double alpha=0.0121;
long double Tt=1.3446;
long double Tc;
int df=2;
Tc = getTc(df,alpha);

	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Zc=%d", Tc );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Tt<Tc)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}
void
TDrawWindow::CmTtestLtail()
{
  Coordinate1();
 Curve(-200,200);
  long double alpha=0.0121;
long double Tt=1.3446;
long double Tc;
int df=2;
Tc = -getTc(df,alpha);

	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Zc=%d", Tc );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Tc<Tt)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}
void
TDrawWindow::CmTtestDtail()
{
  Coordinate1();
 Curve(-200,200);
  long double alpha=0.1;
long double Tt=1.3446;
long double Tc1,Tc2;
int df=1;
Tc1 =getTc(df,alpha);
Tc2=-getTc(df,alpha);

	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Tc=%d,%d", Tc1,Tc2 );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Tc2<Tt&&Tt<Tc1)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}
void
TDrawWindow::CmFtestRtail()
{
Coordinate2();
Curvef(0,200);
 long double alpha=0.1;
long double Ft=1.3446;
long double Fc;
int df1=2;
int df2=2;
Fc = getFc(alpha,df1,df2);

	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,230, s, strlen(s));

	TClientDC dc1(*this);
			char s1[16];
			wsprintf(s1, "Fc=%d", Fc );
			dc1.TextOut(250,230,s1, strlen(s1));
	 if(Ft<Fc)
	 {
	TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Accept!!!" );
			dc2.TextOut(250,250,s2, strlen(s2)); }
	  else

	{TClientDC dc2(*this);
			char s2[16];
			wsprintf(s2, "Reject !!!" );
			dc2.TextOut(250,250,s2, strlen(s2));}

}
void
TDrawWindow::CmFtestLtail()
{
Coordinate2();
Curvef(0,200);
 MessageBox("Feature not implemented", "statistic tests", MB_OK);
}
void
TDrawWindow::CmFtestDtail()
{
Coordinate2();
Curvef(0,200);
 MessageBox("Feature not implemented", "statistic tests", MB_OK);
}
void
TDrawWindow::CmAbout()
{
  MessageBox("If you have any problem.\nPlease contact with me !!!"
  , "About Statistic test", MB_OK);
}
/******************************************************/
 long double
TDrawWindow:: getZc(long double data1)
{
long double Zc;
long double **data;
int m =1 ;
int n =10 ;
int i,j;
	try {                                 // TEST FOR EXCEPTIONS.
		data = new long double*[m];        // STEP 1: SET UP THE ROWS.
		for ( j = 0; j < m; j++)
			 data[j] = new long double[n];  // STEP 2: SET UP THE COLUMNS

		}
	catch (xalloc) {  // ENTER THIS BLOCK ONLY IF xalloc IS THROWN.
		// YOU COULD REQUEST OTHER ACTIONS BEFORE TERMINATING
		cout << "Could not allocate. Bye ...";
		exit(-1);
		}
	char* filename="a:norm.dat";
	ifstream input(filename);
	for ( i = 0; i < m; i++){
		  for ( j = 0; j < n; j++)
			 input >> data[i][j] ;}
//ReadData();
	for ( i = 0; i < m; i++){
		  for ( j = 0; j < n; j++)
				 if( fabs((data1-data[i][j])*10000)<=9)
				 Zc=i/10+j/100;}
		 return(Zc);}

/*************************************************************/
/****************************************************************************/
void
TDrawWindow::line(TPoint point1,TPoint point2 )
{ TPointsIterator i(*Line);
	TClientDC dc(*this);
	dc.MoveTo(point1);
	Line->Add(point1);
  if(dc.GetCurrentPosition(point1)==true)
	dc.LineTo(point2);
	else
	 {i.Current()==point1;
	 dc.LineTo(point2);}

}

void
TDrawWindow::Curve(long double min,long double max)
{
TPoint point1,point2;
long double x,y,x1,y1,xo,yo;
xo=200;
yo=200;
x=-200;
y=200/sqrt(2*3.14)*exp(-2) ;
x1=x+xo;
y1=-y+yo;
while(min<=x&&x<=max)
	{point1.x=x1;
	 point1.y=y1;
	 x=x+1;
	 y=200*(1/sqrt(2*3.14))*exp(-(x*x)/20000);
	 x1=x+xo;
	 y1=-y+yo;
	 point2.x=x1;
	 point2.y=y1;
	 line(point1,point2);}




}
void
TDrawWindow::Curvef(long double min,long double max)
{
TPoint point1,point2;
long double x,y,x1,y1,xo,yo;
long double c;
xo=200;
yo=200;
c=10000;
x=0;
y=0 ;

x1=x+xo;
y1=-y+yo;
while(min<=x&&x<=max)
	{point1.x=x1;
	 point1.y=y1;
	 x=x+1;
	 y=c*x/((2*x+40)*(2*x+40));
	// y=(c*pow(x,((n1/2)-1)))/pow((n1*x+n2*50),(n1+n2)/2);
	 x1=x+xo;
	 y1=-y+yo;
	 point2.x=x1;
	 point2.y=y1;
	 line(point1,point2);}

}
void TDrawWindow::Coordinate()
{
 TPoint point1,point3;
  TPoint point2,point4;
  point1.x=20;point3.x=200;
  point1.y=200;point3.y=200;
  point2.x=420;point4.x=200;
  point2.y=200;point4.y=10;
  line(point1,point2);
  line(point3,point4);
  TClientDC dc1(*this);
  char s1[40];
  wsprintf(s1," Y");
  dc1.TextOut(200,10, s1, strlen(s1));
  TClientDC dc2(*this);
  char s2[40];
  wsprintf(s2,"Z");
  dc2.TextOut(420,200, s2, strlen(s2));
}
void TDrawWindow::Coordinate1()
{
 TPoint point1,point3;
  TPoint point2,point4;
  point1.x=20;point3.x=200;
  point1.y=200;point3.y=200;
  point2.x=420;point4.x=200;
  point2.y=200;point4.y=10;
  line(point1,point2);
  line(point3,point4);
  TClientDC dc1(*this);
  char s1[40];
  wsprintf(s1," Y");
  dc1.TextOut(200,10, s1, strlen(s1));
  TClientDC dc2(*this);
  char s2[40];
  wsprintf(s2,"t");
  dc2.TextOut(420,200, s2, strlen(s2));
}
void TDrawWindow::Coordinate2()
{
 TPoint point1,point3;
  TPoint point2,point4;
  point1.x=20;point3.x=200;
  point1.y=200;point3.y=200;
  point2.x=420;point4.x=200;
  point2.y=200;point4.y=10;
  line(point1,point2);
  line(point3,point4);
  TClientDC dc1(*this);
  char s1[40];
  wsprintf(s1," Y");
  dc1.TextOut(200,10, s1, strlen(s1));
  TClientDC dc2(*this);
  char s2[40];
  wsprintf(s2,"F");
  dc2.TextOut(420,200, s2, strlen(s2));
}
void
TDrawWindow::de_allocate(long double **data)
{
	for (int i = 0; i < m;  i++)
		 delete[] data[i];                 // STEP 1: DELETE THE COLUMNS
			delete[] data;                        // STEP 2: DELETE THE ROWS
	}
long double
TDrawWindow::getTc(int i,long double alpha)
{int j,choice;
 long double Tc=0.00;
 long double **data;
int n=4 ;
int m=5 ;
	try {                                 // TEST FOR EXCEPTIONS.
		data = new long double*[m];        // STEP 1: SET UP THE ROWS.
		for ( j = 0; j < m; j++)
			 data[j] = new long double[n];  // STEP 2: SET UP THE COLUMNS

		}
	catch (xalloc) {  // ENTER THIS BLOCK ONLY IF xalloc IS THROWN.
		// YOU COULD REQUEST OTHER ACTIONS BEFORE TERMINATING
		cout << "Could not allocate. Bye ...";
		exit(-1);
		}
	char* filename="a:student.dat";
	ifstream input(filename);
	for ( i = 0; i < m; i++){
		  for ( j = 0; j < n; j++)
			 input >> data[i][j] ;}
 choice=alpha*1000;
 switch(choice){
	  case 100:
					j=0;
					Tc=data[i][j];
					break;
	  case 50 :
					j=1;
					Tc=data[i][j];
					break;
		case 25:
					j=2;
					Tc=data[i][j];
					break;
	  case 10 :
					j=3;
					Tc=data[i][j];
					break;
		case 5:
					j=4;
					Tc=data[i][j];
					break;}
return(Tc);}
 long double
TDrawWindow::getFc(long double alpha,int j,int k)
{
 int i,choice;
 long double Fc=0;
const int n=4;
const int m=9;
const int l=2;
long double data2[n][m][l];

char* filename="a:fish.dat";

	ifstream input(filename);
	for ( i = 0; i < n; i++)
		  for (int j = 0; j < m; j++)
				for (int k = 0; k < l; k++)
			 input >> data2[i][j][k] ;

 choice=alpha*1000;
 switch(choice){
	  case 100:
					i=0;
					Fc=data2[i][j][k];
					break;
	  case 50 :
					i=1;
					Fc=data2[i][j][k];
					break;
		case 25:
					i=2;
					Fc=data2[i][j][k];
					break;
	  case 10 :
					i=3;
					Fc=data2[i][j][k];
					break; }

return(Fc);}

/*************************************************/
class TDrawApp : public TApplication {
  public:
	 TDrawApp() : TApplication() {}

	 void InitMainWindow()
	 {
		SetMainWindow(new TFrameWindow(0, "Statistic Tests", new TDrawWindow));
		GetMainWindow()->AssignMenu("COMMANDS");
	 }
};

int
OwlMain(int /*argc*/, char* /*argv*/ [])
{
  return TDrawApp().Run();
}