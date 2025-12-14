
#include "stdafx.h"
#include "BrOBJ.h"
#define MAXBUFFER 50
#define YES "yes"
#define NO "no"

//Variable for storing the result from the database server

Buffer ResultSet(MAXBUFFER,8,5);

//Variable for storing old calling message
CString OldCall = "";

Buffer::Buffer(int Row,int Col,int Depth)
{
	TotalRow = Row;
	TotalCol = Col;
	TotalDepth = Depth;
}

void Buffer::AddMember(int Row,int Col,int Depth,CString Result)
{
	Store[Row][Col][Depth] = Result;
	//MessageBox(NULL,Store[Row][Col][Depth],"Adding...",MB_OK);
}

CString Buffer::GetData(int Row,int Col,int Depth)
{
	if ((Row < TotalRow) &&
		(Col < TotalCol) &&
		(Depth < TotalDepth))
		return Store[Row][Col][Depth];
	else
		return "";
}

bool Buffer::ScanBuffer(CString SrchStr[])
{
	for (int i = 0;i < TotalRow;i++)
	{
		int j = 0;
		if (strcmp(Store[i][j][0],SrchStr[j]) == 0)
			while ((j < TotalCol) &&
				   (strcmp(Store[i][j++][0],SrchStr[j]) == 0) ) {
			}
		if (j >= TotalCol){
			return TRUE;
		}
	}

	return FALSE;
}

//Define the static fakeThis object.
BridgeOBJ* BridgeOBJ::fakeThis = NULL;

//Constructor of object BridgeOBJ
BridgeOBJ::BridgeOBJ()
{
	fakeThis = this;

	//Setup DDE
	DdeInitialize(&idInst,DdeCallback,APPCLASS_STANDARD|
		CBF_FAIL_ADVISES|
		CBF_FAIL_EXECUTES|
		CBF_FAIL_POKES|
		CBF_SKIP_REGISTRATIONS|
		CBF_SKIP_UNREGISTRATIONS,0L);

	//Register this program as a DDE server with the service name
	//DBCall.

	HSZ hszService;
	AppName = "DBCall";

	hszService = DdeCreateStringHandle(idInst,AppName,0);
	DdeNameService(idInst,hszService,NULL,DNS_REGISTER);
}

CString BridgeOBJ::MakeArrStr(char *InMessage)
{
	char *seps = "\"()";
	char *TempChar;
	CString ResultArr[8];
	int i;

	for (i = 0;i < 8;i++) {
		ResultArr[i] = "";
	}

	TempChar = strtok(InMessage,seps);
	TempChar = strtok(NULL,seps);

	i = 0;
	while (TempChar != "") {
		ResultArr[i++] = strtok(NULL,seps);
		TempChar = strtok(NULL,seps);
	}
	return ResultArr[0];
}

Buffer BridgeOBJ::MakeFlat(Buffer InBuffer)
{
	Buffer ConvertedBuffer(MAXBUFFER,8,5);
	Buffer TempBuffer = InBuffer;
	int i = 0;
	while (strcmp(TempBuffer.GetData(0,i,0),"") != 0) {
		int CurRow = 0;
		int j = 0;
		while (strcmp(TempBuffer.GetData(j,i,0),"") != 0) {
			int k = 0;
			while (strcmp(TempBuffer.GetData(j,i,k),"") != 0) {
				
				for (int l = 0;l < i;l++) {
					ConvertedBuffer.AddMember(CurRow,l,0,TempBuffer.GetData(j,l,0));
				}

				ConvertedBuffer.AddMember(CurRow,i,0,TempBuffer.GetData(j,i,k));

				int m = i + 1;
				while (strcmp(TempBuffer.GetData(j,m,0),"") != 0) {
					int n = 0;
					while (strcmp(TempBuffer.GetData(j,m,n),"") != 0) {
						ConvertedBuffer.AddMember(CurRow,m,n,TempBuffer.GetData(j,m,n));
						n++;
					}
					m++;
				}

				k++;
				CurRow++;
			}
			j++;
		}
		i++;
		TempBuffer = ConvertedBuffer;
		ConvertedBuffer = InBuffer;
	}
	return TempBuffer;
}

//process for access the database
Buffer BridgeOBJ::DBAccess(char *Request)
{
	//Variables for Return value
	Buffer ResultBuffer(MAXBUFFER,8,5);


	//Variables neccessary for open the connection session
	odbSessH   sh;
	odbStatus  odbrc;

	//Variables for scan and store result from the database server
	odbScanId	scanId;
	odbData		IntData,ResultMember;
	long		MajorQty,MinorQty;

	//Building Statement for execution at DB server
	CString ExeStmnt = "";
	CString MemberStr;
	ExeStmnt += "SStrSet = ";
	ExeStmnt += Request;
	ExeStmnt += ";";
	char *TempStr = ExeStmnt.GetBuffer(0);

	//Open the database connection session
	odbrc = odbSesStart(&sh, "jasmine/jasmine","","","");
	odbrc = odbExecODQL(sh, "defaultCF projectCF;", 0, 0);
	odbrc = odbExecODQL(sh, "Transaction.start();", 0, 0);

	//Execute the database request
	odbrc = odbExecODQL(sh,"List <StringSet> SStrSet;",0,0);
	odbrc = odbExecODQL(sh,TempStr,0,0);

	//Collecting data from the server to buffer
	odbrc = odbExecODQL(sh,"Integer Amount;",0,0);
	odbrc = odbExecODQL(sh,"Amount = SStrSet.count();",0,0);
	odbrc = odbExecODQL(sh,"Iterator <StringSet> ISStr;",0,0);
	odbrc = odbExecODQL(sh,"ISStr = SStrSet.createIterator();",0,0);
	odbrc = odbExecODQL(sh,"ISStr.advance();",0,0);
	IntData = odbAllocData();
	odbrc = odbGetVar(sh, "Amount", IntData);
	MajorQty = odbGetInt(IntData);
	odbrc = odbExecODQL(sh,"Set <String> SStr;",0,0);

	for (int i = 1;i <= MajorQty;i++)
	{
		//Beginning the scan
		odbrc = odbExecODQL(sh,"SStr = ISStr.get().Retrieve();",0,0);
		odbrc = odbExecODQL(sh,"Amount = SStr.count();",0,0);
		odbrc = odbScanOpen(sh,"SStr",&scanId,0);
		IntData = odbAllocData();
		ResultMember = odbAllocData();
		odbrc = odbGetVar(sh, "Amount", IntData);
		MinorQty = odbGetInt(IntData);
		for (int j = 0; j < MinorQty; j++)
		{
			odbrc = odbScanNext(sh, scanId, ResultMember);
			MemberStr = "";
			MemberStr += odbGetStr(ResultMember);
			ResultBuffer.AddMember(0,i-1,j,MemberStr);	
		}
		odbrc = odbScanClose(sh,scanId);

		//Fetch Next Elements in Result
		odbrc = odbExecODQL(sh,"ISStr.advance();",0,0);
	}

	odbrc = odbFreeData(IntData);
	odbrc = odbFreeData(ResultMember);

	//Close the database connection
	odbrc = odbExecODQL(sh, "StringSet.Clear();", 0, 0);
	odbrc = odbExecODQL(sh, "Transaction.end();", 0, 0);
	odbSesEnd(sh);
	return ResultBuffer;
}

//Operation for get multimedia file from database
CString BridgeOBJ::DBGetObj(char *CallStmt)
{
	//Variables neccessary for open the connection session
	odbSessH   sh;
	odbStatus  odbrc;

	odbData ObjFile,ObjName;
	char *FileName;

	//Open the database connection session
	odbrc = odbSesStart(&sh, "jasmine/jasmine","","","");
	odbrc = odbExecODQL(sh, "defaultCF projectCF;", 0, 0);
	odbrc = odbExecODQL(sh, "Transaction.start();", 0, 0);

	odbrc = odbExecODQL(sh, "MMResult ObjData;",0,0);
	ObjFile = odbAllocData();
	ObjName = odbAllocData();
	odbrc = odbExecODQL(sh, CallStmt,0,0);
	odbrc = odbExecODQL(sh, "mediaCF::PaintBrush File;",0,0);
	odbrc = odbExecODQL(sh, "File = ObjData.GetMMDat();",0,0);
	odbrc = odbExecODQL(sh, "String Name;",0,0);
	odbrc = odbExecODQL(sh, "Name = ObjData.GetName();",0,0);

	odbrc = odbGetVar(sh, "File" ,ObjFile);
	odbrc = odbGetVar(sh, "Name" ,ObjName);
	FileName = odbGetStr(ObjName);

	odbrc = odbGetMMDataToFile(sh, ObjFile , FileName);
	
	odbrc = odbFreeData(ObjFile);
	odbrc = odbFreeData(ObjName);
	//Close the connection
	odbrc = odbExecODQL(sh, "Transaction.end();", 0, 0);
	odbSesEnd(sh);
	return FileName;

}


//Static callback member function.
HDDEDATA CALLBACK EXPORT BridgeOBJ::DdeCallback(UINT iType,UINT iFmt,
			HCONV hConv,HSZ hsz1,HSZ hsz2,HDDEDATA hData,
			DWORD dwData1,DWORD dwData2)
{
	//Topic = hsz1;
	//Item = hsz2;

	char szBuffer[64];
	char* RequestedClass = "";
	char* RequestedMethod = "";
	char* CompOp = "";					//operator for comparison
	char* CompVal = "";					//value for comparison
	char* seps = "-\t";					//characters for the separation
	CString MessageCall = "";

	switch(iType) {
		//Handle the 'connect' transaction.
		case XTYP_CONNECT:
			//Get the application name.
			DdeQueryString(fakeThis -> idInst,hsz2,
				szBuffer,sizeof(szBuffer),0);

			//If the application name is not supported by this server
			//return FALSE.
			if (fakeThis -> AppName != szBuffer)
				return FALSE;

			//Get the topic name.
			DdeQueryString(fakeThis -> idInst,hsz1,
				szBuffer, sizeof(szBuffer),0);

			//If the topic is not either 'EXIST' or 'GET',
			//return with an error.
			if (strcmp(szBuffer,"GETS"))
					return FALSE;

			//Return TRUE to indicate a successful connection.
			return (HDDEDATA) TRUE;
			break;

		//Process the 'request' transaction type.
		case XTYP_REQUEST:
			//Get the topic name.
			DdeQueryString(fakeThis -> idInst,hsz1,
				szBuffer,sizeof(szBuffer),0);
			
			//Is the topic "GETS"?
			if (strcmp(szBuffer,"GETS") == 0)
			{
				//Get the item name.
				DdeQueryString(fakeThis -> idInst,hsz2,
					szBuffer, sizeof(szBuffer),0);

				CString Instr = szBuffer;

				//Separate Requested item into tokens
				RequestedClass = strtok(szBuffer,seps);
				RequestedMethod = strtok(NULL,seps);

				//Building Calling Message
				MessageCall += RequestedClass;
				MessageCall += ".";
				MessageCall += RequestedMethod;

				CString QueryStream[8];
				char *sep = "\"(),";
				char *TempChar;
				CString ResultArr[8];
				int k;

				for (k = 0;k < 8;k++) {
					ResultArr[k] = "";
				}

				char *InMessage = Instr.GetBuffer(0);

				CString DBRQ = strtok(InMessage,sep);
				TempChar = strtok(NULL,sep);

				k = 0;
				while (k < 8) {
					ResultArr[k++] = TempChar;
					TempChar = strtok(NULL,sep);
				}


				CString Result = "";
				char *Request = "";
				//Compare current calling message with the old one
				if (strcmp(OldCall,(LPCTSTR) DBRQ) == 0)
				{
					bool Found = ResultSet.ScanBuffer(ResultArr);
					if (Found) 
						Result += "yes";
					else {
						Request = MessageCall.GetBuffer(0);
						ResultSet = DBAccess(Request);

						Buffer TempBuff(MAXBUFFER,8,5);
						TempBuff = MakeFlat(ResultSet);
						ResultSet = TempBuff;

						Found = ResultSet.ScanBuffer(ResultArr);
						if (Found)
							Result += "yes";
						else
							Result += "no";
					}
					//Retreive old data from the buffer
					//Result += (LPCSTR) ResultSet.GetData();
				}
				else	//Send the message to the database server
				{
					//copy current message to old message
					OldCall = "";
					OldCall += DBRQ;

					//Access the database operation
					Request = MessageCall.GetBuffer(0);
					ResultSet = DBAccess(Request);

					Buffer TempBuff(MAXBUFFER,8,5);
					TempBuff = MakeFlat(ResultSet);
					ResultSet = TempBuff;
					
					bool Found = ResultSet.ScanBuffer(ResultArr);
					if (Found)
						Result += "yes";
					else
						Result += "no";
				}
				
				//convert type of calling message to common string
				const char* ReturnedMessage = Result;

				//Return result to the application.
				return DdeCreateDataHandle(fakeThis -> idInst,
					(LPBYTE) ReturnedMessage,
					strlen(ReturnedMessage)+1,
					0,hsz2,CF_TEXT,0);
			}


			break;
	} //end switch
	return NULL;
}