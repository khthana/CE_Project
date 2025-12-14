
#include <ddeml.h>
#define MAXBUFFER 50

//the Declaration of Buffer class

class Buffer
{
public:
	Buffer(int Row,int Col,int Depth);
	void AddMember(int Row,int Col,int Depth,CString Result);
	bool ScanBuffer(CString SrchStr[]);
	void MakeFlat(int col);
	CString GetData(int Row,int Col,int Depth);

private:
	int LastPos;
	int CurrentPos;
	int TotalRow;
	int TotalCol;
	int TotalDepth;
	CString Store[MAXBUFFER][8][5];
};

//the Declaration of BridgeOBJ class

class BridgeOBJ
{
public:
	//Static callback member function.
	static HDDEDATA CALLBACK EXPORT DdeCallback(UINT iType,UINT iFmt,
			HCONV hCconv,
			HSZ hsz1,HSZ hsz2,
			HDDEDATA hData,
			DWORD dwData1,
			DWORD dwData2);

	//Extra copy of the first object's 'this' pointer for use
	//by the Ddecallback static member function.
	static BridgeOBJ* fakeThis;

	//Constructor sets up fakeThis pointer,
	//Establishes DDE connection.
	BridgeOBJ();

private:
	//DDE instance ID
	DWORD idInst;

	//Service Name
	CString AppName;

	//Operation for making array of data querying
	static CString MakeArrStr(char *InMessage);

	//Operation for making flat table
	static Buffer MakeFlat(Buffer InBuffer);

	//Database access operation
	static Buffer DBAccess(char *Request);

	//Database access for Multimedia file data type
	static CString DBGetObj(char *CallStmt);

};
