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
	 void ReadData();
	 void  de_allocate(long double **);
	 void getdata(long double **);
	 void getvalue(long double ,long double**);
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
  MessageBox("Testing procedure \nDo you want to continue ?",
				  "Welcome to statistic tests !!!",
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

	long double **data;
	long double data1=0.0121;
 //	cout<<"input your value :";  cho nay de dung dialog box
 //	cin>>data1;
		try {                                 // TEST FOR EXCEPTIONS.
		data = new long double*[m];        // STEP 1: SET UP THE ROWS.
		for (int j = 0; j < m; j++)
			 data[j] = new long double[n];  // STEP 2: SET UP THE COLUMNS

		}
	catch (xalloc) {  // ENTER THIS BLOCK ONLY IF xalloc IS THROWN.
		// YOU COULD REQUEST OTHER ACTIONS BEFORE TERMINATING
		cout << "Could not allocate. Bye ...";
		exit(-1);
		}

	getdata(data);
	TClientDC dc(*this);
  char s[40];
  wsprintf(s,"Result is :");
  dc.TextOut(150,250, s, strlen(s));
	getvalue(data1,data);
	de_allocate(data);


}

void
TDrawWindow::CmZtestLtail()
{
Coordinate();
Curve(-200,200);

}

void
TDrawWindow::CmZtestDtail()
{
  Coordinate();
  Curve(-200,200);
}

void
TDrawWindow::CmTtestRtail()
{
  Coordinate1();
 Curve(-200,200);
}
void
TDrawWindow::CmTtestLtail()
{
  Coordinate1();
 Curve(-200,200);
}
void
TDrawWindow::CmTtestDtail()
{
  Coordinate1();
 Curve(-200,200);
}
void
TDrawWindow::CmFtestRtail()
{
Coordinate2();
Curvef(0,200);
}
void
TDrawWindow::CmFtestLtail()
{
Coordinate2();
Curvef(0,200);
}
void
TDrawWindow::CmFtestDtail()
{
Coordinate2();
Curvef(0,200);
}
void
TDrawWindow::CmAbout()
{
  MessageBox("If you have any problem.\nPlease contact with me !!!"
  , "About Statistic test", MB_OK);
}
/******************************************************/
 void
TDrawWindow:: getvalue(long double data1,long double ** data)
 { for (int i = 0; i < m; i++){
		  for (int j = 0; j < n; j++)
				{
				 if( fabs((data1-data[i][j])*10000)<=9){
				 TClientDC dc(*this);
			char s[16];
			wsprintf(s, "Zc=%d", i+j);
			dc.TextOut(250,250,s, strlen(s));


	}
					 }
		 }
		 }



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
long double c,n1,n2;
xo=200;
yo=200;
c=10000;
x=0;
y=0 ;
n1=2;
n2=2;
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
TDrawWindow::ReadData(){

int m =1 ;  // can xem lai cho nay ,co can thiet khong ?.
int n =10 ;
n=10;
m=1;
//long double **data;//xem lai cho nay lien ket giua cac bien
//	cout<<"Size: n= ";cin>>n;
//	cout<<"m =";cin>>m;
	try {                                 // TEST FOR EXCEPTIONS.
		data = new long double*[m];        // STEP 1: SET UP THE ROWS.
		for (int j = 0; j < m; j++)
			 data[j] = new long double[n];  // STEP 2: SET UP THE COLUMNS

		}
	catch (xalloc) {  // ENTER THIS BLOCK ONLY IF xalloc IS THROWN.
		// YOU COULD REQUEST OTHER ACTIONS BEFORE TERMINATING
		cout << "Could not allocate. Bye ...";
		exit(-1);
		}
	getdata(data);


	}


void
TDrawWindow::getdata(long double **data)
{
	char* filename="a:norm.dat";
  //	cout<<"please enter your filename :";cho nay can dung dialog
  //	cin>>filename;
	ifstream input(filename);
	for (int i = 0; i < m; i++){
		  for (int j = 0; j < n; j++)
				{
				 input >> data[i][j] ;
				  }
		 }
	}
void
TDrawWindow::de_allocate(long double **data)
{
	for (int i = 0; i < m;  i++)
		 delete[] data[i];                 // STEP 1: DELETE THE COLUMNS
			delete[] data;                        // STEP 2: DELETE THE ROWS
	}







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