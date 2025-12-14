//midetect.cpp
#include<fstream.h>
#include<string.h>
#include<iomanip.h>
#include<stdio.h>
#include<stdlib.h>
#include<pwd.h>
#include<sys/types.h>

//======= Filename Configuration =======
const char SYSLOG[] = "/var/adm/syslog/syslog";
const char SULOG[] = "/var/adm/sulog";
const char IDSLOG[] = "idslog";
const char USER_INFO[] = "userinfo";
const char BLACK_USER[] = "blackuser";
const char BLACK_ROOT[] = "blackroot";
const char BLACK_HOST[] = "blackhost";
//====== Max Value Configuration =======
const int MAX_BAD_USER = 5;
const int MAX_BAD_PASSWD = 5;
const int MAX_BAD_ROOT_PASSWD = 3;
const int MAX_BAD_SU = 3;
const int MAX_DATE = 1;
const int MAX_MONTH = 0;
const int MAX_HOUR = 0;
const int MAX_MINUTE = 0;
const int MAX_CDATE = 1;
const int MAX_CMONTH = 0;
const int MAX_CHOUR = 0;
const int MAX_CMINUTE = 0;
//========= Status Indicator ===========
const int U = 0;
const int H = 0;
const int B = 1;
const int BH = 1;
const int BR = 2;
const int S = 4;
const int SR = 5;
const int SBR = 6;
const int I = 99;
const int NV = 0;
const int V = 1;
//============ Parameter ===============
const int ADDRESS_TYPE = 2;			//struct hostent
const int ADDRESS_LEN = 4;			//struct hostent
//============ Constant ================
const int MAX_LEN_ALINE = 200;
const int MAX_LEN_NAME = 20;
const int MAX_LEN_HNAME = 30;

struct log
  {
  int Month;
  int Date;
  int Hour;
  int Minute;
  char Sender[20];
  char Terminal[7];
  char Name[8];
  int Succeed;
  int Probe;
  char RemoteHost[30];
  char Filename[30];
  };
struct usrinfo
  {
  char Name[10];
  uid_t UID;
  gid_t GID;
  char Home[20];
  char Shell[20];
  int State;
  int Status;
  int Counter2;
  int DateSt2;
  int MonthSt2;
  int HourSt2;
  int MinuteSt2;
  int Counter3;
  int DateSt3;
  int MonthSt3;
  int HourSt3;
  int MinuteSt3;
  int Counter4;
  int DateSt4;
  int MonthSt4;
  int HourSt4;
  int MinuteSt4;
  int LoginCount;
  int IsB;
  struct usrinfo *Ptr;
  };
struct hostinfo
  {
  char Name[30];
  char IP[20];
  int State;
  int Status;
  int Counter1;
  int DateSt;
  int MonthSt;
  int HourSt;
  int MinuteSt;
  int IsBH;
  struct hostinfo *Ptr;
  };
struct sysinfo
  {
  int State;
  int Status;
  };

/*============ Filter ================*/
void DetectSulog();
void GetSuMonth(int&,char[MAX_LEN_ALINE],log&);
void GetSuDate(int&,char[MAX_LEN_ALINE],log&);
void GetSuHour(int&,char[MAX_LEN_ALINE],log&);
void GetSuMinute(int&,char[MAX_LEN_ALINE],log&);
void GetSuccess(int&,char[MAX_LEN_ALINE],log&);
void GetSuTerminal(int&,char[MAX_LEN_ALINE],log&);
void GetSuName(int&,char[MAX_LEN_ALINE],log&);
void CheckWithSyslog(int&,char[MAX_LEN_ALINE],log&);
void WriteSuLog(log);
void DispCountRec(int);
void GetSysMonth(int&,char[MAX_LEN_ALINE],log&);
void GetSysDate(int&,char[MAX_LEN_ALINE],log&);
void GetSysHour(int&,char[MAX_LEN_ALINE],log&);
void GetSysMinute(int&,char[MAX_LEN_ALINE],log&);
void GetSysSender(int&,char[MAX_LEN_ALINE],log&);
void CmpEvent(char Event[MAX_LEN_ALINE],log& Log);
void GetSysEvent(int&,char[MAX_LEN_ALINE],log&);
void DetectEvent1(char[MAX_LEN_ALINE],log&);
void DetectEvent2(char[MAX_LEN_ALINE],log&);
void DetectEvent3(char[MAX_LEN_ALINE],log&);
void DetectEvent4(char[MAX_LEN_ALINE],log&);
void DetectEvent7(char[MAX_LEN_ALINE],log&);
//void DetectEvent5(char[MAX_LEN_ALINE],log&);
void DetectEvent10(char[MAX_LEN_ALINE],log&);
void DetectEvent11(char[MAX_LEN_ALINE],log&);
void DetectEvent12(char[MAX_LEN_ALINE],log&);
void DetectEvent13(char[MAX_LEN_ALINE],log&);
void DetectEvent14(char[MAX_LEN_ALINE],log&);
void DetectEvent15(char[MAX_LEN_ALINE],log&);
void DetectEvent16(char[MAX_LEN_ALINE],log&);
void DetectEvent17(char[MAX_LEN_ALINE],log&);
void DetectEvent18(char[MAX_LEN_ALINE],log&);
void DetectEvent19(char[MAX_LEN_ALINE],log&);
void DetectEvent20(char[MAX_LEN_ALINE],log&);
void DetectEvent21(char[MAX_LEN_ALINE],log&);
void FindLogoutTime();
void WriteLog(log);
void DetectSyslog();
void ClearData(log&);
void ReOrder();
void ReadLog();
/*============ Analyze ===============*/
void Analyze();
void ReadUserInfo(usrinfo *);
void ReadInfo(usrinfo *User);
void CheckTimeStamp(usrinfo *,log);
void CheckHostTimeStamp(hostinfo *,log);
void FindAndChangeStateUser(char*,usrinfo *User,int& CanFind,int Probe);
void FindAndChangeStateHost(char*,hostinfo *Host,int& CanFind,int Probe);
void ChangeUserState(int,usrinfo *Usr);
void ChangeHostState(int,hostinfo *Host);
void ChangeSystemState(int,sysinfo);
void UserState0(int,usrinfo*);
void UserState1(int,usrinfo*);
void UserState2(int,usrinfo*);
void UserState3(int,usrinfo*);
void UserState4(int,usrinfo*);
void UserState5(int,usrinfo*);
void UserState6(int,usrinfo*);
void UserState7(int,usrinfo*);
void UserState8(int,usrinfo*);
void UserState9(int,usrinfo*);
void UserState10(int,usrinfo*);
void UserState11(int,usrinfo*);
void UserState12(int,usrinfo*);
void HostState0(int,hostinfo*);
void HostState1(int,hostinfo*);
void HostState2(int,hostinfo*);
void SysState0(int,sysinfo);
void SysState1(int,sysinfo);
void SysState2(int,sysinfo);
void AddAndChangeStateHost(char *Name,hostinfo **Host_ptr,int);
void AddUserToList();
void AddUserToBL(char*,int&);
void AddRootToBL(char*,int&);
void AddHostToBL(char*,int&);

void main()
  {
  DetectSulog();
  DetectSyslog();
  FindLogoutTime();
  cout << "Reordering..." << endl;
  ReOrder();
//  ReadLog();
  cout << "Analyzing..." << endl;
  Analyze();
  };




/*=============== Sulog ==============*/
void DetectSulog()
  {
  char ALine[MAX_LEN_ALINE];
  log Log;
  int Pointer1;
  int Pointer2 = 0;
  int CountRec = 0;
  cout << "Filtering sulog " << setw(10) << CountRec << " records.";
  ifstream ReadTextFile(SULOG);
  while(ReadTextFile)
    {
    CountRec++;
    ReadTextFile.getline(ALine,MAX_LEN_ALINE);
    Pointer1 = 0;
    if(ALine[0] != '\0')
      {
      ClearData(Log);
      GetSuMonth(Pointer1,ALine,Log);
      GetSuDate(Pointer1,ALine,Log);
      GetSuHour(Pointer1,ALine,Log);
      GetSuMinute(Pointer1,ALine,Log);
      GetSuccess(Pointer1,ALine,Log);
      GetSuTerminal(Pointer1,ALine,Log);
      GetSuName(Pointer1,ALine,Log);
      CheckWithSyslog(Pointer1,ALine,Log);
      WriteSuLog(Log);
      DispCountRec(CountRec);
      }
    }
  cout << endl;
  }

void GetSuMonth(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChMonth[3];
  Pointer1 = 0;
  while(ALine[Pointer1] != ' ') Pointer1++;
  int Pointer2 = 0;
  Pointer1++;
  while(ALine[Pointer1] != '/')
    {
    ChMonth[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  ChMonth[Pointer2] = '\0';
  Log.Month = atoi(ChMonth);
  Pointer1++;

  }

void GetSuDate(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChDate[3];
  int Pointer2 = 0;
  while(ALine[Pointer1] != ' ')
    {
    ChDate[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  ChDate[Pointer2] = '\0';
  Pointer1++;
  Log.Date = atoi(ChDate);
  }

void GetSuHour(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChHour[3];
  int Pointer2 = 0;
  while(ALine[Pointer1] != ':')
    {
    ChHour[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  ChHour[Pointer2] = '\0';
  Pointer1++;
  Log.Hour = atoi(ChHour);
  }

void GetSuMinute(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChMinute[3];
  int Pointer2 = 0;
  while(ALine[Pointer1] != ' ')
    {
    ChMinute[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  ChMinute[Pointer2] = '\0';
  Pointer1++;
  Log.Minute = atoi(ChMinute);
  }

void GetSuccess(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  if(ALine[Pointer1] == '+')
    {
    Log.Succeed = 0;
    }
    else
    {
    Log.Succeed = 1;
    }
  Pointer1++;
  Pointer1++;
  }

void GetSuTerminal(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  int Pointer2 = 0;
  while(ALine[Pointer1] != ' ')
    {
    Log.Terminal[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  Log.Terminal[Pointer2]='\0';
  Pointer1++;
  }

void GetSuName(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  int Pointer2 = 0;
  char Name2[10];
  struct passwd *pw_ptr;
  struct passwd *pw_ptr1;
  struct passwd *pw_ptr2;
  pw_ptr1 = malloc(sizeof(struct passwd));
  pw_ptr2 = malloc(sizeof(struct passwd));
  while(ALine[Pointer1] != '-')
    {
    Log.Name[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer2] = '\0';
  Pointer1++;
  Pointer2 = 0;
  while(ALine[Pointer1] != '\0')
    {
    Name2[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  Name2[Pointer2] = '\0';
  pw_ptr = getpwnam(Log.Name);
  if (pw_ptr) memcpy(pw_ptr1,pw_ptr,sizeof(struct passwd));
  pw_ptr = getpwnam(Name2);
  if (pw_ptr) memcpy(pw_ptr2,pw_ptr,sizeof(struct passwd));
//  if((pw_ptr2->pw_gid==0) && (pw_ptr1->pw_gid!=0)) Log.Probe = 24;	// User setuid(0)
/*  free(pw_ptr);
  free(pw_ptr1);
  free(pw_ptr2);*/
  }

void CheckWithSyslog(int& Pointer,char SuEvent[80],log& Log)
  {
  log ChkLog;
  int Pointer1;
  int Pointer2;
  int CanFind = 1;
  char Event1[] = "Authentication failed for";
  char Event2[] = "setuid: su";
  char ChkEvent[MAX_LEN_ALINE];
  char ALine[MAX_LEN_ALINE];
  char Name[10];
  char ChkName[10];
  char uid_ch[6];
  uid_t uid;
  struct passwd *pw_ptr;
  Pointer1 = 0;
  while(SuEvent[Pointer]!='-') Pointer--;
  Pointer++;
  while(SuEvent[Pointer]!='\0')
    {
    Name[Pointer1] = SuEvent[Pointer];
    Pointer++;
    Pointer1++;
    }
  Name[Pointer1] = '\0';
  if(strcmp(Name,"root")==0)
  {
  ifstream ReadTextFile(SYSLOG);
  while(ReadTextFile && (CanFind != 0))
    {
    ReadTextFile.getline(ALine,MAX_LEN_ALINE);
    if(ALine[0]!='\0')
      {
      Pointer1 = 0;
      CanFind = 1;
      ClearData(ChkLog);
      GetSysMonth(Pointer1,ALine,ChkLog);
      GetSysDate(Pointer1,ALine,ChkLog);
      GetSysHour(Pointer1,ALine,ChkLog);
      GetSysMinute(Pointer1,ALine,ChkLog);
      if((ChkLog.Date==Log.Date) && (ChkLog.Month==Log.Month) && (ChkLog.Hour==Log.Hour) && (ChkLog.Minute==Log.Minute))
        {
        GetSysSender(Pointer1,ALine,ChkLog);
        Pointer2 = 0;
        while(ALine[Pointer1] != '\0')
          {
          ChkEvent[Pointer2] = ALine[Pointer1];
          if (ALine[Pointer1]!='\0') Pointer1++;
          Pointer2++;
          }
        ChkEvent[Pointer2] = '\0';
        Pointer2 = 0;
        if(Log.Succeed == 1)
          {
           if(strncmp(ChkEvent,Event1,strlen(Event1))==0)
            {
            Pointer1 = 0;
            while(ChkEvent[Pointer1]!=' ') Pointer1++;
            Pointer1++;
            while(ChkEvent[Pointer1]!=' ') Pointer1++;
            Pointer1++;
            while(ChkEvent[Pointer1]!=' ') Pointer1++;
            Pointer1++;
            while(ChkEvent[Pointer1]!=' ')
              {
              ChkLog.Name[Pointer2] = ChkEvent[Pointer1];
              Pointer1++;
              Pointer2++;
              }
            ChkLog.Name[Pointer2] = '\0';
            if(strcmp(Name,ChkLog.Name)==0) CanFind = 0;
            }
          } else
          {
          if(strncmp(ChkEvent,Event2,strlen(Event2))==0)
            {
            Pointer1 = 0;
            while(ChkEvent[Pointer1]!='(') Pointer1++;
            Pointer1++;
            while(ChkEvent[Pointer1]!='/')
              {
              uid_ch[Pointer2] = ChkEvent[Pointer1];
              Pointer1++;
              Pointer2++;
              }
            uid_ch[Pointer2] = '\0';
            Pointer1++;
            Pointer2 = 0;
            uid = atoi(uid_ch);
            pw_ptr = getpwuid(uid);
            strcpy(ChkLog.Name,pw_ptr->pw_name);
            while(ChkEvent[Pointer1]!=')')
              {
              uid_ch[Pointer2] = ChkEvent[Pointer1];
              Pointer1++;
              Pointer2++;
              }
            uid_ch[Pointer2] = '\0';
            uid = atoi(uid_ch);
            pw_ptr = getpwuid(uid);
            strcpy(ChkName,pw_ptr->pw_name);
            if(strcmp(ChkLog.Name,Log.Name)==0 && strcmp(ChkName,Name)==0) CanFind = 0;
            }
          }
        }
      }
    } 
  } else CanFind = 0;
    if(CanFind != 0 && (strcmp("root",Log.Name) != 0)) 
      {
//cout << Log.Hour << ' '<< ChkLog.Name << ' ' << Log.Name << ' ' << ChkName << ' ' << Name << endl;
      Log.Probe = 19;		// Find the evidence may be cleared or modified log.
      }
  }

void WriteSuLog(log Log)
  {
  if(Log.Probe!=(-1))
    {
    fstream File;
    File.open(IDSLOG,ios::app|ios::out|ios::in);
    File.write((char*)&Log,sizeof(Log));
    File.close();
    }
  }

void DispCountRec(int CountRec)
  {
  cout << "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";
  cout << setw(10) << CountRec << " records.";
  }

/*============== Syslog ==============*/
void DetectSyslog()
  {
  char ALine[MAX_LEN_ALINE];
  log Log;
  int Pointer1;
  int CountRec = 0;
  cout << "Filtering syslog" << setw(10) << CountRec << " records.";
  ifstream ReadTextFile(SYSLOG);
  while(ReadTextFile)
    {
    ReadTextFile.getline(ALine,MAX_LEN_ALINE);
    Pointer1 = 0;
    if(ALine[0] != '\0')
      {
      CountRec++;
      ClearData(Log);
      GetSysMonth(Pointer1,ALine,Log);
      GetSysDate(Pointer1,ALine,Log);
      GetSysHour(Pointer1,ALine,Log);
      GetSysMinute(Pointer1,ALine,Log);
      GetSysSender(Pointer1,ALine,Log);
      GetSysEvent(Pointer1,ALine,Log);
      WriteLog(Log);
      DispCountRec(CountRec);
      }
    }
//  system("rm tempsulog");
  cout << endl;
  }

void GetSysMonth(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  int Pointer2 = 0;
  char ChMonth[4];
  while(ALine[Pointer1] != ' ')
    {
    ChMonth[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    };
  ChMonth[Pointer2] = '\0';
  Pointer1++;
  if (strcmp(ChMonth,"Jan")==0) Log.Month = 1;
  if (strcmp(ChMonth,"Feb")==0) Log.Month = 2;
  if (strcmp(ChMonth,"Mar")==0) Log.Month = 3;
  if (strcmp(ChMonth,"Apr")==0) Log.Month = 4;
  if (strcmp(ChMonth,"May")==0) Log.Month = 5;
  if (strcmp(ChMonth,"Jun")==0) Log.Month = 6;
  if (strcmp(ChMonth,"Jul")==0) Log.Month = 7;
  if (strcmp(ChMonth,"Aug")==0) Log.Month = 8;
  if (strcmp(ChMonth,"Sep")==0) Log.Month = 9;
  if (strcmp(ChMonth,"Oct")==0) Log.Month = 10;
  if (strcmp(ChMonth,"Nov")==0) Log.Month = 11;
  if (strcmp(ChMonth,"Dec")==0) Log.Month = 12;
  }

void GetSysDate(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChDate[3];
  char tmp1;
  char tmp2;
  int Pointer2 = 0;
  while(ALine[Pointer1] == ' ') Pointer1++;
  tmp1 = ALine[Pointer1];
  Pointer1++;
  tmp2 = ALine[Pointer1];
  if(tmp2 == ' ')
    {
    ChDate[0] = '0';
    ChDate[1] = tmp1;
    Pointer1++;
    }
    else
    {
    ChDate[0] = tmp1;
    ChDate[1] = tmp2;
    Pointer1++;
    Pointer1++;
    }
  ChDate[2] = '\0';
  Log.Date = atoi(ChDate);
  }

void GetSysHour(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChHour[3];
  int Pointer2 = 0;
  while(ALine[Pointer1] != ':')
    {
    ChHour[Pointer2] = ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  ChHour[Pointer2] = '\0';
  Log.Hour = atoi(ChHour);
  Pointer1++;
  }

void GetSysMinute(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char ChMinute[3];
  int Pointer2 = 0;
  while(ALine[Pointer1] != ':')
    {
    ChMinute[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  ChMinute[Pointer2] = '\0';
  Log.Minute = atoi(ChMinute);
  while(ALine[Pointer1] != ' ')
    {
    Pointer1++;
    }
  Pointer1++;
  while(ALine[Pointer1] != ' ')
    {
    Pointer1++;
    }
  Pointer1++;
  }

void GetSysSender(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  int Pointer2 = 0;
  while(ALine[Pointer1] != ':' && ALine[Pointer1]!=' ')
    {
    Log.Sender[Pointer2]=ALine[Pointer1];
    Pointer1++;
    Pointer2++;
    }
  Log.Sender[Pointer2] = '\0';
  if(strncmp(Log.Sender,"syslogd",strlen("syslogd"))==0)
    {
    while(ALine[Pointer1] != ':')
      {
      Log.Sender[Pointer2]=ALine[Pointer1];
      Pointer1++;
      Pointer2++;
      }
    Log.Sender[Pointer2] = '\0';
    }
  if(strncmp(Log.Sender,"exiting",strlen("exiting"))==0)
    {
    Pointer1--;
    while(ALine[Pointer1] != ' ')
      {
      Pointer1--;
      }
    strcpy(Log.Sender,"");
    }
  while(ALine[Pointer1] != ' ')
    {
    Pointer1++;
    }
  while(ALine[Pointer1] == ' ')
    {
    Pointer1++;
    }
  }

void GetSysEvent(int& Pointer1,char ALine[MAX_LEN_ALINE],log& Log)
  {
  char Event[MAX_LEN_ALINE];
  int Pointer2 = 0;
  while(ALine[Pointer1] != '\0')
    {
    Event[Pointer2] = ALine[Pointer1];
    if (ALine[Pointer1]!='\0') Pointer1++;
    Pointer2++;
    }
  Event[Pointer2] = '\0';
  CmpEvent(Event,Log);
  }

void CmpEvent(char Event[MAX_LEN_ALINE],log& Log)
  {
  const char Event1[] = "ROOT LOGIN on";
  const char Event2[] = "invalid password for";
  const char Event3[] = "Authentication failed for";
  const char Event4[] = "password for";
  const char Event5[] = "exiting on signal 15";
  const char Event6[] = "restart";
  const char Event7[] = "`";
  const char Event8[] = "UMSDOS dentry-pre 0.84";
  const char Event9[] = "Adding Swap";
  const char Event10[] = "new group:";
  const char Event11[] = "remove group";
  const char Event12[] = "new user:";
  const char Event13[] = "delete user";
  const char Event14[] = "change user `";
  const char Event15[] = "connect from";
  const char Event16[] = "setuid";
  const char Event17[] = "Keyfile have been changed.";
  const char Event18[] = "SUID file have been changed.";
  const char Event19[] = "Log file have been changed.";
  const char Event20[] = "log: Password authentication for";
  const char Event21[] = "debug: Password authentication for";

  if(strncmp(Event,Event1,strlen(Event1))==0) DetectEvent1(Event,Log);
  if(strncmp(Event,Event2,strlen(Event2))==0) DetectEvent2(Event,Log);
  if(strncmp(Event,Event3,strlen(Event3))==0) DetectEvent3(Event,Log);
  if(strncmp(Event,Event4,strlen(Event4))==0) DetectEvent4(Event,Log);
  if(strncmp(Event,Event5,strlen(Event5))==0) Log.Probe = 18;	// System shutdown.
  if(strncmp(Event,Event6,strlen(Event6))==0) Log.Probe = 17;	// System restart.
  if(strncmp(Event,Event7,strlen(Event7))==0) DetectEvent7(Event,Log);
  if(strncmp(Event,Event8,strlen(Event8))==0) Log.Probe = 7;	// Call to privileged services.
  if(strncmp(Event,Event9,strlen(Event9))==0) Log.Probe = 7;	//Call to privileged services.
  if(strncmp(Event,Event10,strlen(Event10))==0) DetectEvent10(Event,Log);
  if(strncmp(Event,Event11,strlen(Event11))==0) DetectEvent11(Event,Log);
  if(strncmp(Event,Event12,strlen(Event12))==0) DetectEvent12(Event,Log);
  if(strncmp(Event,Event13,strlen(Event13))==0) DetectEvent13(Event,Log);
  if(strncmp(Event,Event14,strlen(Event14))==0) DetectEvent14(Event,Log);
  if(strncmp(Event,Event15,strlen(Event15))==0) DetectEvent15(Event,Log);
  if(strncmp(Event,Event16,strlen(Event16))==0) DetectEvent16(Event,Log);
  if(strncmp(Event,Event17,strlen(Event17))==0) DetectEvent17(Event,Log);
  if(strncmp(Event,Event18,strlen(Event18))==0) DetectEvent18(Event,Log);
  if(strncmp(Event,Event19,strlen(Event19))==0) DetectEvent19(Event,Log);
  if(strncmp(Event,Event20,strlen(Event20))==0) DetectEvent20(Event,Log);
  if(strncmp(Event,Event21,strlen(Event21))==0) DetectEvent21(Event,Log);
  }

void DetectEvent1(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Terminal[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Terminal[Pointer2] = '\0';
  Log.Probe = 5;		// Root login.
  strcpy(Log.Name,"root");
  }

void DetectEvent2(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  struct passwd *passwd_ptr;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  if(strncmp(Log.Name,"root",strlen("root"))==0)
    {
    Log.Probe = 3;	// Failed root login.
    }
  Pointer1 = 0;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Terminal[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Terminal[Pointer1] = '\0';
  Pointer1 = 0;    
  while(Event[Pointer2] != '`' && Event[Pointer2] != '\0')
    {
    Pointer2++;
    }
  if(Event[Pointer2]=='`')
    {
    Pointer2++;
    while(Event[Pointer2] != '\'')
      {
      Log.RemoteHost[Pointer1] = Event[Pointer2];
      Pointer1++;
      Pointer2++;
      }
    Log.RemoteHost[Pointer1] = '\0';
    } else strcpy(Log.RemoteHost,"Local host");
  passwd_ptr = getpwnam(Log.Name);
  if(passwd_ptr)
    {
    if(passwd_ptr->pw_gid == 0) Log.Probe = 3;		// Fail root login.
      else Log.Probe = 2;				// Bad password.
    }
    else Log.Probe = 1;					// Bad username.
  }

void DetectEvent3(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  char Name[10];
  char ALine[MAX_LEN_ALINE];
  char ChDate[3];
  char ChMonth[3];
  char ChHour[3];
  char ChMinute[3];
  char SuerName[10];
  char SuName[10];
  int CanFind = 1;
  log TempLog;
  struct passwd *pw_ptr;
  while(Event[Pointer2]!=' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2]!=' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2]!=' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2]!=' ')
    {
    Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Name[Pointer1] = '\0';
  pw_ptr = getpwnam(Name);
  if(pw_ptr)
    {
    if(pw_ptr->pw_gid == 0)
      {
      Log.Probe = 4;				// Fail su root.
      ifstream ReadTextFile(SULOG);
      while(ReadTextFile && (CanFind != 0))
        {
        ReadTextFile.getline(ALine,MAX_LEN_ALINE);
        Pointer1 = 0;
        Pointer2 = 0;
        if(ALine[0] != '\0')
          {
          ClearData(TempLog);
          GetSuMonth(Pointer1,ALine,TempLog);
          GetSuDate(Pointer1,ALine,TempLog);
          GetSuHour(Pointer1,ALine,TempLog);
          GetSuMinute(Pointer1,ALine,TempLog);
          GetSuccess(Pointer1,ALine,TempLog);
          GetSuTerminal(Pointer1,ALine,TempLog);
          while(ALine[Pointer1]!='-')
            {
            SuerName[Pointer2] = ALine[Pointer1];
            Pointer1++;
            Pointer2++;
            }
          SuerName[Pointer2] = '\0';
          Pointer1++;
          Pointer2 = 0;
          while(ALine[Pointer1]!='\0')
            {
            SuName[Pointer2] = ALine[Pointer1];
            Pointer1++;
            Pointer2++;
            }
          SuName[Pointer2] = '\0';
          if((Log.Date==TempLog.Date)
              && (Log.Month==TempLog.Month)
              && (Log.Hour==TempLog.Hour)
              && (Log.Minute==TempLog.Minute)
              && (TempLog.Succeed==1)
              && (strcmp(Name,SuName)==0))
            CanFind = 0;
          }
        }        
      } else CanFind = 0;
    if(CanFind!=0)
      {
      Log.Probe = 19;			// Find the evidence may be log editing.
      }
    }
  if(CanFind==0)
    {
    strncpy(Log.Name,SuerName,strlen(SuerName));
    }
    else cout << "Find the evidence may be log editing." << endl;

  }

void DetectEvent4(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer2] = '\0';
  Log.Probe = 22;					// Password changed.
  }

void DetectEvent7(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
//cout << Log.Name << endl;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  Pointer1 = 0;
  while(Event[Pointer2] != '\'')
    {
    Log.Terminal[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Terminal[Pointer1] = '\0';
  Pointer1 = 0;    
  while(Event[Pointer2] != '`' && Event[Pointer2] != '\0')
    {
    Pointer2++;
    }
  if(Event[Pointer2]=='`')
    {
    Pointer2++;
    while(Event[Pointer2] != '\'')
      {
      Log.RemoteHost[Pointer1] = Event[Pointer2];
      Pointer1++;
      Pointer2++;
      }
    Log.RemoteHost[Pointer1] = '\0';
    } else strcpy(Log.RemoteHost,"Local host");
  Log.Probe = 16;		// User login.
  }

void DetectEvent10(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '=')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != ',')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  Pointer1 = 0;
  Log.Probe = 9;		// Group created.
  }

void DetectEvent11(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  Pointer1 = 0;
  Log.Probe = 10;		// Group deleted.
  }

void DetectEvent12(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  char Gid[5] = "";
  while(Event[Pointer2] != '=')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != ',')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  Pointer1 = 0;
  Pointer2++;
  while(Event[Pointer2] != ',')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '=')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != ',')
    {
    Gid[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Gid[Pointer1] = '\0';
  if(strcmp(Gid,"0") != 0)
    {
    Log.Probe = 20;		// User account created.
    } else Log.Probe = 11;	// New root user created.
  }

void DetectEvent13(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  Pointer1 = 0;
  Log.Probe = 21;		// User account deleted.
  }

void DetectEvent14(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  char Gid[5] = "";
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  Pointer1 = 0;
  Pointer2++;
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  while(Event[Pointer2] != '\'')
    {
    Pointer2++;
    }
  while(Event[Pointer2] != '`')
    {
    Pointer2++;
    }
  Pointer2++;
  while(Event[Pointer2] != '\'')
    {
    Gid[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  if(strcmp(Gid,"0")==0)
    {
    Log.Probe = 12;		// User privileges granted.
    } else
    {
    Log.Probe = 8;		// User's group changed.
    }
  }

void DetectEvent15(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != '\0')
    {
    Log.RemoteHost[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.RemoteHost[Pointer1] = '\0';
  Log.Probe = 23;		// Connection start.
  }

void DetectEvent16(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  char uid_ch[6];
  uid_t uid;
  struct passwd *pw_ptr;
  while(Event[Pointer2] != '[') Pointer2++;
  while(Event[Pointer2] != ']') Pointer2++;
  while(Event[Pointer2] != '[') Pointer2++;
  while(Event[Pointer2] != ']') Pointer2++;
  while(Event[Pointer2] != '(') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != '/')
    {
    uid_ch[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  uid_ch[Pointer1] = '\0';
  uid = atoi(uid_ch);
  pw_ptr = getpwuid(uid);
  strcpy(Log.Name,pw_ptr->pw_name);
  Log.Probe = 24;		// User success su command.
  }

void DetectEvent17(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '-') Pointer2++;
  Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != '\0')
    {
    Log.Filename[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Filename[Pointer1] = '\0';
  if(strncmp(Log.Filename,"/etc/syslogd.conf",strlen("/etc/syslogd.conf"))==0)
    {
    Log.Probe = 6;		// Audit policy changed.
    } else
    {
    Log.Probe = 14;		// Key file changed.
    }
  }

void DetectEvent18(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '-') Pointer2++;
  Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != '\0')
    {
    Log.Filename[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Filename[Pointer1] = '\0';
  Log.Probe = 15;		// SUID file changed.
  }

void DetectEvent19(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  while(Event[Pointer2] != '-') Pointer2++;
  Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != '\0')
    {
    Log.Filename[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Filename[Pointer1] = '\0';
  Log.Probe = 13;		// Audit log changed.
  }

void DetectEvent20(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  passwd *passwd_ptr;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  passwd_ptr = getpwnam(Log.Name);
  if(passwd_ptr->pw_gid == 0) Log.Probe = 5;		// Root login.
    else Log.Probe = 16;				// User login.
  }

void DetectEvent21(char Event[MAX_LEN_ALINE],log& Log)
  {
  int Pointer1 = 0;
  int Pointer2 = 0;
  struct passwd *passwd_ptr;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ') Pointer2++;
  Pointer2++;
  while(Event[Pointer2] != ' ')
    {
    Log.Name[Pointer1] = Event[Pointer2];
    Pointer1++;
    Pointer2++;
    }
  Log.Name[Pointer1] = '\0';
  passwd_ptr = getpwnam(Log.Name);
  if(passwd_ptr->pw_gid == 0) Log.Probe = 3;		// Failed root login.
    else Log.Probe = 2;					// Bad password.
  }

void FindLogoutTime()
  {
  char ALine[MAX_LEN_ALINE];
  char MonthCh[4];
  char DateCh[3];
  char HourCh[3];
  char MinuteCh[3];
  int LoginHour;
  int LoginMinute;
  int NewDay;
  char tmp1,tmp2;
  log Log;
  int Crash;
  int Pointer1;
  int Pointer2 = 0;
  system("last > templast");
  ifstream ReadTextFile("templast");
  while(ReadTextFile)
    {
    ReadTextFile.getline(ALine,MAX_LEN_ALINE);
    if((ALine[0]!='\0') && (ALine[10]=='t'))
      {
      Crash = 1;
      NewDay = 1;
      ClearData(Log);
      Pointer1 = 0;
      Pointer2 = 0;
      while(ALine[Pointer1]!=' ')
        {
        Log.Name[Pointer2] = ALine[Pointer1];
        Pointer1++;
        Pointer2++;
        }
      Log.Name[Pointer2] = '\0';
      Pointer1 = 10;
      Pointer2 = 0;
      while(ALine[Pointer1]!=' ')
        {
        Log.Terminal[Pointer2] = ALine[Pointer1];
        Pointer1++;
        Pointer2++;
        }
      Log.Terminal[Pointer2] = '\0';
      if(ALine[Pointer1]!=' ')
        {
        Pointer1 = 19;
        Pointer2 = 0;
        while(ALine[Pointer1]!=' ')
          {
          Log.RemoteHost[Pointer2] = ALine[Pointer1];
          Pointer1++;
          Pointer2++;
          }
        }
      Log.RemoteHost[Pointer2] = '\0';
      Pointer1 = 40;
      Pointer2 = 0;
      while(ALine[Pointer1]!=' ')
        {
        MonthCh[Pointer2] = ALine[Pointer1];
        Pointer1++;
        Pointer2++;
        }
      MonthCh[Pointer2] = '\0';
      if (strcmp(MonthCh,"Jan")==0) Log.Month = 1;
      if (strcmp(MonthCh,"Feb")==0) Log.Month = 2;
      if (strcmp(MonthCh,"Mar")==0) Log.Month = 3;
      if (strcmp(MonthCh,"Apr")==0) Log.Month = 4;
      if (strcmp(MonthCh,"May")==0) Log.Month = 5;
      if (strcmp(MonthCh,"Jun")==0) Log.Month = 6;
      if (strcmp(MonthCh,"Jul")==0) Log.Month = 7;
      if (strcmp(MonthCh,"Aug")==0) Log.Month = 8;
      if (strcmp(MonthCh,"Sep")==0) Log.Month = 9;
      if (strcmp(MonthCh,"Oct")==0) Log.Month = 10;
      if (strcmp(MonthCh,"Nov")==0) Log.Month = 11;
      if (strcmp(MonthCh,"Dec")==0) Log.Month = 12;
      Pointer1 = 44;
      tmp1 = ALine[Pointer1];
      Pointer1++;
      tmp2 = ALine[Pointer1];
      if(tmp1 == ' ')
        {
        DateCh[0] = '0';
        DateCh[1] = tmp2;
        }
        else
        {
        DateCh[0] = tmp1;
        DateCh[1] = tmp2;
        }
      DateCh[2] = '\0';
      Log.Date = atoi(DateCh);
      if(ALine[57] == ':')
        {
        Pointer1 = 47;
        Pointer2 = 0;
        while(ALine[Pointer1]!=':')
          {
          HourCh[Pointer2] = ALine[Pointer1];
          Pointer1++;
          Pointer2++;
          }
        HourCh[Pointer2] = '\0';
        LoginHour = atoi(HourCh);
        Pointer1 = 50;
        Pointer2 = 0;
        while(ALine[Pointer1]!=' ')
          {
          MinuteCh[Pointer2] = ALine[Pointer1];
          Pointer1++;
          Pointer2++;
          }
        MinuteCh[Pointer2] = '\0';
        LoginMinute = atoi(MinuteCh);
        Pointer1 = 55;
        Pointer2 = 0;
        while(ALine[Pointer1]!=':')
          {
          HourCh[Pointer2] = ALine[Pointer1];
          Pointer1++;
          Pointer2++;
          }
        HourCh[Pointer2] = '\0';
        Log.Hour = atoi(HourCh);
        Pointer1 = 58;
        Pointer2 = 0;
        while(ALine[Pointer1]!=' ')
          {
          MinuteCh[Pointer2] = ALine[Pointer1];
          Pointer1++;
          Pointer2++;
          }
        MinuteCh[Pointer2] = '\0';
        Log.Minute = atoi(MinuteCh);
        if(LoginHour>Log.Hour) NewDay = 0;          
          else if((LoginHour==Log.Hour)&&(LoginMinute>Log.Minute)) NewDay = 0;
        if(NewDay == 0)
          {
          switch(Log.Month)
            {
            case 1:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 2:
              if(Log.Date==28)			//February 28 days.
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 3:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 4:
              if(Log.Date==30)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 5:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 6:
              if(Log.Date==30)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 7:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 8:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 9:
              if(Log.Date==30)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 10:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 11:
              if(Log.Date==30)
                {
                Log.Date = 1;
                Log.Month++;
                } else (Log.Date)++;
              break;
            case 12:
              if(Log.Date==31)
                {
                Log.Date = 1;
                Log.Month = 1;
                } else (Log.Date)++;
              break;
            }
          }
        Log.Probe = 25;			//User logout.
        } else Crash = 0;
      if(Crash!=0) WriteLog(Log);
      }
    }
//  system("rm templast");
  }

void ClearData(log& Log)
  {
  strcpy(Log.Name,"");
  Log.Month = -1;
  Log.Date = -1;
  Log.Hour = -1;
  Log.Minute = -1;
  strcpy(Log.Sender,"");
  strcpy(Log.Terminal,"");
  Log.Probe = (-1);
  strcpy(Log.RemoteHost,"");
  strcpy(Log.Filename,"");
  }

void WriteLog(log Log)
  {
  if(Log.Probe!=(-1))
    {
    fstream File;
//cout << Log.Date << ' ' << Log.Month << ' ' << Log.Hour << ' ' << Log.Minute << ' ' << Log.Sender << ' ' << Log.Terminal << ' ' << Log.Name << ' ' << Log.Probe << ' ' << Log.RemoteHost << endl;
    File.open("idslog",ios::app|ios::out|ios::in);
    File.write((char*)&Log,sizeof(Log));
    File.close();
    }
  }

void ReOrder()
  {
  log Log1,Log2;
  int rec,i,j;
  fstream File;
  File.open(IDSLOG,ios::nocreate|ios::in|ios::out);
  File.seekg(0,ios::end);
  rec = File.tellg()/(sizeof(struct log));
  File.seekp(0,ios::beg);
  for(i=1;i<=rec-1;++i)
    {
    File.read((char*)&Log1,sizeof Log1);
    for(j=1;j<=rec-1;++j)
      {
      File.read((char*)&Log2,sizeof Log2);
      if(Log1.Month > Log2.Month)
        {
        File.seekp(File.tellp()-2*sizeof Log1);
        File.write((char*)&Log2,sizeof Log2);
        File.write((char*)&Log1,sizeof Log1);
        File.seekp(File.tellp(),ios::beg);
        } else 
        {
        if(Log1.Month == Log2.Month)
          {
          if(Log1.Date > Log2.Date)
            {
            File.seekp(File.tellp()-2*sizeof Log1);
            File.write((char*)&Log2,sizeof Log2);
            File.write((char*)&Log1,sizeof Log1);
            File.seekp(File.tellp(),ios::beg);
            } else 
            {
            if(Log1.Date == Log2.Date)
              {
              if(Log1.Hour > Log2.Hour)
                {
                File.seekp(File.tellp()-2*sizeof Log1);
                File.write((char*)&Log2,sizeof Log2);
                File.write((char*)&Log1,sizeof Log1);
                File.seekp(File.tellp(),ios::beg);
                } else 
                {
                if(Log1.Hour == Log2.Hour)
                  {
                  if(Log1.Minute > Log2.Minute)
                    {
                    File.seekp(File.tellp()-2*sizeof Log1);
                    File.write((char*)&Log2,sizeof Log2);
                    File.write((char*)&Log1,sizeof Log1);
                    File.seekp(File.tellp(),ios::beg);
                    } else Log1 = Log2;
                  } else Log1 = Log2;
                }
              } else Log1 = Log2;
            }
          } else Log1 = Log2;
        }
      } 
    File.seekp(0,ios::beg);
    }
  }

void ReadLog()
  {
  log Log;
  ifstream ReadFile(IDSLOG);
  while(ReadFile) 
    {
    ReadFile.read((char*)&Log,sizeof(Log));
cout << Log.Date << ':' << Log.Month << ' ' << Log.Hour << ':' << Log.Minute << ' ' << Log.Sender << ' ' << Log.Terminal << ' ' << Log.Name << ' ' << Log.Probe << ' ' << Log.RemoteHost << ' ' << Log.Filename << endl;
    }
  }

//============= Analyze ================
void Analyze()
  {
  usrinfo **User_ptr;
  hostinfo *Host;
  hostinfo *FirstHost;FirstHost = new hostinfo;
  hostinfo *LastHost;LastHost = FirstHost;FirstHost->Ptr = NULL;
  hostinfo **LastHost_ptr;LastHost_ptr = &LastHost;
  usrinfo *User;
  usrinfo *FirstUser;FirstUser = new usrinfo;
  sysinfo System;System.State = 0;System.Status = NV;
  log Log;
  int CanFind;
  ReadUserInfo(FirstUser);
//  delete User_ptr;
  ifstream ReadFile(IDSLOG);
  while(ReadFile)
    {
    ClearData(Log);
    ReadFile.read((char*)&Log,sizeof(Log));
//cout << Log.Hour << ':' << Log.Minute << ' ' << Log.Date << '/' << Log.Month <<setw(10)<< Log.Name << ' ' <<setw(3)<< Log.Probe <<setw(30)<< Log.RemoteHost << endl;
    if(Log.Name[0]!='\0')
      {
      User = FirstUser;
      CheckTimeStamp(User,Log);
      User = FirstUser;
      FindAndChangeStateUser(Log.Name,User,CanFind,Log.Probe);
      } 
    if(Log.RemoteHost[0]!='\0')
      {
      Host = FirstHost;
      FindAndChangeStateHost(Log.RemoteHost,Host,CanFind,Log.Probe);
      if(CanFind != 0) AddAndChangeStateHost(Log.RemoteHost,LastHost_ptr,Log.Probe);
      Host = FirstHost;
      CheckHostTimeStamp(Host,Log);
      }
    ChangeSystemState(Log.Probe,System);
    if(Log.Probe == 18)
      {
      User = FirstUser;
      while(User->Ptr != NULL)
        {
        User->LoginCount = 0;
        switch (User->State)
          {
          case 3:
            User->State = 2;
            User->Status = B;
            break;
          case 7:
            User->State = 6;
            User->Status = BR;
            break;
          case 8:
            User->State = 0;
            break;
          case 9:
            User->State = 12;
            break;
          case 11:
            User->State = 6;
            User->Status = BR;
            break;
          }
        User = User->Ptr;
        }
      User->LoginCount = 0;
      switch (User->State)
        {
        case 3:
          User->State = 2;
          User->Status = B;
          break;
        case 7:
          User->State = 6;
          User->Status = BR;
          break;
        case 8:
          User->State = 0;
          break;
        case 9:
          User->State = 12;
          break;
        case 11:
          User->State = 6;
          User->Status = BR;
          break;
        }
      }
    }
  User = FirstUser;
  while(User->Ptr!=NULL)
    {
    if(User->State==I) cout << "Detect " << User->Name << " be intruder." << endl;
    User = User->Ptr;
    }
  if(User->State==I) cout << "Detect " << User->Name << " be intruder." << endl;
  }

void ReadUserInfo(usrinfo *User0)
  {
  usrinfo User;
  usrinfo *User1;
  usrinfo *User2;
  User1 = User0;
  ifstream ReadFile(USER_INFO);
  while(ReadFile.read((char*)&User,sizeof(User)) && ReadFile)
    {
    User2 = new usrinfo;
    strcpy(User2->Name,User.Name);
    User2->UID = User.UID;
    User2->GID = User.GID;
    strcpy(User2->Home,User.Home);
    strcpy(User2->Shell,User.Shell);
    User2->State = User.State;
    User2->Status = User.Status;
    User2->Counter2 = User.Counter2;
    User2->Counter3 = User.Counter3;
    User2->Counter4 = User.Counter4;
    User2->IsB = User.IsB;
    User2->Ptr = NULL;
    User1->Ptr = User2;
    User1 = User2;
    }
//ReadInfo(User0);
//  delete User1;
//  delete User2;
  }

void ReadInfo(usrinfo *User)
  {
  if(User->Ptr!=NULL) User = User->Ptr;
  while(User->Ptr!=NULL)
    {
    cout << User->Name << ' ' << User->UID << ' ' << User->GID << ' ' << User->Home << ' ' << User->Shell << ' ' << User->State << endl;
    User = User->Ptr;
    }
  cout << User->Name << ' ' << User->UID << ' ' << User->GID << ' ' << User->Home << ' ' << User->Shell << ' ' << User->State << endl;
  }

void CheckTimeStamp(usrinfo *User,log Log)
  {
  if(User->Ptr !=NULL) User = User->Ptr;
  while(User->Ptr!=NULL)
    {
    if(((Log.Date - User->DateSt2)>=MAX_DATE)
       &&((Log.Month - User->MonthSt2)>=MAX_MONTH)
       &&((Log.Hour - User->HourSt2)>=MAX_HOUR)
       &&((Log.Minute - User->MinuteSt2)>=MAX_MINUTE)
       &&((User->Counter2)>0))
      {
      (User->Counter2)--;
      User->DateSt2 = Log.Date;
      User->MonthSt2 = Log.Month;
      User->HourSt2 = Log.Hour;
      User->MinuteSt2 = Log.Minute;
      }
    if(((Log.Date - User->DateSt3)>=MAX_DATE)
       &&((Log.Month - User->MonthSt3)>=MAX_MONTH)
       &&((Log.Hour - User->HourSt3)>=MAX_HOUR)
       &&((Log.Minute - User->MinuteSt3)>=MAX_MINUTE)
       &&((User->Counter3)>0))
      {
      (User->Counter3)--;
      User->DateSt3 = Log.Date;
      User->MonthSt3 = Log.Month;
      User->HourSt3 = Log.Hour;
      User->MinuteSt3 = Log.Minute;
      }
    if(((Log.Date - User->DateSt4)>=MAX_DATE)
       &&((Log.Month - User->MonthSt4)>=MAX_MONTH)
       &&((Log.Hour - User->HourSt4)>=MAX_HOUR)
       &&((Log.Minute - User->MinuteSt4)>=MAX_MINUTE)
       &&((User->Counter4)>0))
      {
      (User->Counter4)--;
      User->DateSt4 = Log.Date;
      User->MonthSt4 = Log.Month;
      User->HourSt4 = Log.Hour;
      User->MinuteSt4 = Log.Minute;
      }
    User = User->Ptr;
    }
  if(((Log.Date - User->DateSt2)>=MAX_DATE)
     &&((Log.Month - User->MonthSt2)>=MAX_MONTH)
     &&((Log.Hour - User->HourSt2)>=MAX_HOUR)
     &&((Log.Minute - User->MinuteSt2)>=MAX_MINUTE)
     &&((User->Counter2)>0))
    {
    (User->Counter2)--;
    User->DateSt2 = Log.Date;
    User->MonthSt2 = Log.Month;
    User->HourSt2 = Log.Hour;
    User->MinuteSt2 = Log.Minute;
    }
  if(((Log.Date - User->DateSt3)>=MAX_DATE)
     &&((Log.Month - User->MonthSt3)>=MAX_MONTH)
     &&((Log.Hour - User->HourSt3)>=MAX_HOUR)
     &&((Log.Minute - User->MinuteSt3)>=MAX_MINUTE)
     &&((User->Counter3)>0))
    {
    (User->Counter3)--;
    User->DateSt3 = Log.Date;
    User->MonthSt3 = Log.Month;
    User->HourSt3 = Log.Hour;
    User->MinuteSt3 = Log.Minute;
    }
  if(((Log.Date - User->DateSt4)>=MAX_DATE)
     &&((Log.Month - User->MonthSt4)>=MAX_MONTH)
     &&((Log.Hour - User->HourSt4)>=MAX_HOUR)
     &&((Log.Minute - User->MinuteSt4)>=MAX_MINUTE)
     &&((User->Counter4)>0))
    {
    (User->Counter4)--;
    User->DateSt4 = Log.Date;
    User->MonthSt4 = Log.Month;
    User->HourSt4 = Log.Hour;
    User->MinuteSt4 = Log.Minute;
    }
  }

void CheckHostTimeStamp(hostinfo *Host,log Log)
  {
  if(Host->Ptr !=NULL) Host = Host->Ptr;
  while(Host->Ptr!=NULL)
    {
    if(((Log.Date - Host->DateSt)>=MAX_CDATE)
       &&((Log.Month - Host->MonthSt)>=MAX_CMONTH)
       &&((Log.Hour - Host->HourSt)>=MAX_CHOUR)
       &&((Log.Minute - Host->MinuteSt)>=MAX_CMINUTE)
       &&((Host->Counter1)>0))
      {
      (Host->Counter1)--;
      Host->DateSt = Log.Date;
      Host->MonthSt = Log.Month;
      Host->HourSt = Log.Hour;
      Host->MinuteSt = Log.Minute;
      }
    Host = Host->Ptr;
    }
  if(((Log.Date - Host->DateSt)>=MAX_CDATE)
     &&((Log.Month - Host->MonthSt)>=MAX_CMONTH)
     &&((Log.Hour - Host->HourSt)>=MAX_CHOUR)
     &&((Log.Minute - Host->MinuteSt)>=MAX_CMINUTE)
     &&((Host->Counter1)>0))
    {
    (Host->Counter1)--;
    Host->DateSt = Log.Date;
    Host->MonthSt = Log.Month;
    Host->HourSt = Log.Hour;
    Host->MinuteSt = Log.Minute;
    }
  }

void FindAndChangeStateUser(char *ChkUser,usrinfo *User,int& CanFind,int Probe)
  {
  CanFind = 1;
  if(User->Ptr !=NULL) User = User->Ptr;
  while(User->Ptr!=NULL && CanFind!=0)
    {
    if(strcmp(User->Name,ChkUser)==0) CanFind = 0;
      else {User = User->Ptr;}
    }
  if((CanFind != 0)&&(strcmp(User->Name,ChkUser)==0)) CanFind = 0;
  if(CanFind == 0)
    {
  ChangeUserState(Probe,User);
//  if(User->Status == I) cout << User->Name << endl;
    }
  }

void FindAndChangeStateHost(char *ChkHost,hostinfo *Host,int& CanFind,int Probe)
  {
  CanFind = 1;
  if(Host->Ptr !=NULL) Host = Host->Ptr;
  while(Host->Ptr!=NULL && CanFind!=0)
    {
    if(strcmp(Host->Name,ChkHost)==0) CanFind = 0;
      else {Host = Host->Ptr;}
    }
  if((CanFind != 0)&&(strcmp(Host->Name,ChkHost)==0)) CanFind = 0;
  ChangeHostState(Probe,Host);
  }

void ChangeUserState(int Probe,usrinfo *User)
  {
//if(strcmp(User->Name,"test1")==0)
//cout << setw(10) << User->Name << ' ' << setw(10) << "Counter2:" << User->Counter2 << setw(10) << "Counter3:" << User->Counter3 << setw(10) << "Counter4:" << User->Counter4 << ' ' << setw(7) << "Login:" << User->LoginCount << ' ' << setw(5) << Probe <<  ' ' << User->State << "->" ;
  switch(User->State)
    {
    case 0:UserState0(Probe,User);break;
    case 1:UserState1(Probe,User);break;
    case 2:UserState2(Probe,User);break;
    case 3:UserState3(Probe,User);break;
    case 4:UserState4(Probe,User);break;
    case 5:UserState5(Probe,User);break;
    case 6:UserState6(Probe,User);break;
    case 7:UserState7(Probe,User);break;
    case 8:UserState8(Probe,User);break;
    case 9:UserState9(Probe,User);break;
    case 10:UserState10(Probe,User);break;
    case 11:UserState11(Probe,User);break;
    case 12:UserState12(Probe,User);break;
    }
//if(strcmp(User->Name,"test1")==0)
//cout << User->State << endl;
  }

void ChangeHostState(int Probe,hostinfo *Host)
  {
//cout << " St:" << Host->State << ' ' << "Counter:" << Host->Counter1 << endl;
  switch(Host->State)
    {
    case 0:HostState0(Probe,Host);break;
    case 1:HostState1(Probe,Host);break;
//    case 2:HostState2(Probe,Host);break;
    }
  }

void ChangeSystemState(int Probe,sysinfo System)
  {
  switch(System.State)
    {
    case 0:SysState0(Probe,System);break;
    case 1:SysState1(Probe,System);break;
    case 2:SysState2(Probe,System);break;
    }
  }

void UserState0(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 2:
      User->State = 1;
      User->Counter2++;
      break;
    case 3:
      User->State = 5;
      User->Counter3++;
      break;
    case 16:
      User->State = 8;
      User->LoginCount++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      AddUserToBL(User->Name,User->IsB);
      break;
    }
  }

void UserState1(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 2:
      (User->Counter2)++;
      if(User->Counter2 >= MAX_BAD_PASSWD)
        {
        User->Status = B;
        User->State = 2;
        AddUserToBL(User->Name,User->IsB);
        }
      break;
    case 16:
      User->State = 8;
      User->LoginCount++;
// if BH
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      AddUserToBL(User->Name,User->IsB);
      break;
    }
  }

void UserState2(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 12:
      User->State = 4;
      User->Status = BR;
      AddRootToBL(User->Name,User->IsB);
      break;
    case 16:
      User->State = 3;
      User->LoginCount++;
      User->Status = S;
// check BH
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      break;
    }
  }

void UserState3(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 4:
      break;
    case 12:
      User->State = 11;
      User->Status = SBR;
      AddRootToBL(User->Name,User->IsB);
      break;
    case 16:
      (User->LoginCount)++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      break;
    case 22:
      break;
    case 24:
      User->State = 7;
      User->Status = SR;
      AddRootToBL(User->Name,User->IsB);
      break;
    case 25:
      User->LoginCount--;
      if(User->LoginCount == 0) User->State = 2;
      User->Status = B;
      break;
    }
  }

void UserState4(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 5:
      User->LoginCount++;
      User->State = 99;
      User->Status = I;
      break;
    case 16:
      (User->LoginCount)++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      break;
    }
  }

void UserState5(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 3:
      (User->Counter3)++;
      if(User->Counter3 >= MAX_BAD_ROOT_PASSWD)
        {
        User->State = 6;
        User->Status = BR;
        AddRootToBL(User->Name,User->IsB);
        }
      break;
    case 16:
      (User->LoginCount)++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      AddUserToBL(User->Name,User->IsB);
      break;
    }
  }

void UserState6(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 5:
// check BH
      User->LoginCount++;
      User->State = 7;
      User->Status = SR;
      break;
    case 16:
      (User->LoginCount)++;
      User->State = 3;
      User->Status = S;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      break;
    }
  }

void UserState7(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 6:
      User->State = 99;
      User->Status = I;
      break;
    case 7:
      User->State = 99;
      User->Status = I;
      break;
    case 8:
      User->State = 99;
      User->Status = I;
      break;
    case 9:
      User->State = 99;
      User->Status = I;
      break;
    case 10:
      User->State = 99;
      User->Status = I;
      break;
/*    case 11:
      User->State = 99;
      User->Status = I;
//add new root to BL;
      break;*/
    case 16:
      (User->LoginCount)++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      break;
    case 20:
      User->State = 99;
      User->Status = I;
//add new user to BL;
      break;
    case 22:
      User->State = 99;
      User->Status = I;
      break;
    case 25:
      User->LoginCount--;
      if(User->LoginCount == 0) User->State = 6;
      User->Status = BR;
      break;
    }
  }

void UserState8(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 4:
      User->State = 9;
      User->Counter4++;
      break;
    case 16:
      (User->LoginCount)++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      AddUserToBL(User->Name,User->IsB);
      break;
    case 25:
      User->LoginCount--;
      if(User->LoginCount == 0) User->State = 0;
      break;
    }
  }

void UserState9(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 4:
      (User->Counter4)++;
      if(User->Counter4 >= MAX_BAD_SU)
        {
        User->State = 3;
        User->Status = S;
        }
      break;
    case 16:
      (User->LoginCount)++;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      AddUserToBL(User->Name,User->IsB);
      break;
    case 25:
      (User->LoginCount)--;
      if(User->LoginCount == 0) User->State = 12;
      break;
    }
  }

void UserState10(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 16:
      User->LoginCount++;
      User->State = 99;
      User->Status = I;
      break;
    case 19:
      User->State = 99;
      User->Status = I;
      break;
    }
  }

void UserState11(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 5:
      User->LoginCount++;
      User->State = 99;
      User->Status = SBR;
      AddRootToBL(User->Name,User->IsB);
      break;
    case 16:
      (User->LoginCount)++;
      break;
    case 25:
      User->LoginCount--;
      if(User->LoginCount == 0) User->State = 5;
      User->Status = BR;
      break;
    }
  }

void UserState12(int Probe,usrinfo *User)
  {
  switch (Probe)
    {
    case 16:
      User->State = 9;
      User->LoginCount++;
      break;
    }
  }

void HostState0(int Probe,hostinfo *Host)
  {
  switch (Probe)
    {
    case 1:
      Host->State = 1;
      (Host->Counter1)++;
      break;
    }
  }

void HostState1(int Probe,hostinfo *Host)
  {
  switch (Probe)
    {
    case 1:
      (Host->Counter1)++;
      if((Host->Counter1) >= MAX_BAD_USER)
        {
        Host->State = 2;
        Host->Status = BH;
        AddHostToBL(Host->Name,Host->IsBH);
        }
      break;
    }
  }

void HostState2(int Probe,hostinfo *Host)
  {
  }

void SysState0(int Probe,sysinfo System)
  {
  switch (Probe)
    {
    case 6:
      System.Status = V;
      break;
    case 13:
      System.Status = V;
      break;
    case 14:
      System.Status = V;
      break;
    case 15:
      System.Status = V;
      break;
    case 17:
      System.State = 1;				// System restart.
      break;
    case 19:
      System.Status = V;
      break;
    }
  }

void SysState1(int Probe,sysinfo System)
  {
  switch (Probe)
    {
    case 6:
      System.Status = V;
      break;
    case 13:
      System.Status = V;
      break;
    case 14:
      System.Status = V;
      break;
    case 15:
      System.Status = V;
      break;
    case 18:
      System.State = 0;				// System shutdown.
      break;
    case 19:
      System.Status = V;
      break;
    }
  }

void SysState2(int Probe,sysinfo System)
  {
  }

void AddAndChangeStateHost(char *Name,hostinfo **Host_ptr,int Probe)
  {
  hostinfo *Temp;
  Temp = new hostinfo;
  strcpy(Temp->Name,Name);
  Temp->State = 0;
  Temp->Status = H;
  Temp->Counter1 = 0;
  Temp->DateSt = 0;
  Temp->MonthSt = 0;
  Temp->HourSt = 0;
  Temp->MinuteSt = 0;
  Temp->Ptr = NULL;
  (*Host_ptr)->Ptr = Temp;
  *Host_ptr = Temp;
  ChangeHostState(Probe,(*Host_ptr));
  }

void AddUserToBL(char *Name,int& IsBlackUser)
  {
  int CanFind = 1;
  char ALine[MAX_LEN_NAME];
  ifstream ReadFile(BLACK_USER);
  while(ReadFile && CanFind!=0)
    {
    ReadFile.getline(ALine,MAX_LEN_NAME);
    if(strcmp(ALine,Name)==0) CanFind = 0;
    }
  fstream WriteFile;
  WriteFile.open(BLACK_USER,ios::app|ios::out|ios::in);
  if(CanFind==1)
    {
    WriteFile.write((char*) Name,strlen(Name));
    WriteFile.write((char*)"\n",1);
    cout << "Add user `" << Name <<"' to `blackuser\'."<< endl;
    }
  IsBlackUser = 0;
  }

void AddRootToBL(char *Name,int& IsBlackRoot)
  {
  int CanFind = 1;
  char ALine[MAX_LEN_NAME];
  ifstream ReadFile(BLACK_ROOT);
  while(ReadFile && CanFind!=0)
    {
    ReadFile.getline(ALine,MAX_LEN_NAME);
    if(strcmp(ALine,Name)==0) CanFind = 0;
    }
  fstream WriteFile;
  WriteFile.open(BLACK_ROOT,ios::app|ios::out|ios::in);
  if(CanFind==1)
    {
    WriteFile.write((char*) Name,strlen(Name));
    WriteFile.write((char*)"\n",1);
    cout << "Add user `" << Name <<"' to `blackroot\'."<< endl;
    }
  IsBlackRoot = 0;
  }

void AddHostToBL(char *Name,int& IsBlackHost)
  {
  int CanFind = 1;
  char ALine[MAX_LEN_HNAME];
  ifstream ReadFile(BLACK_HOST);
  while(ReadFile && CanFind!=0)
    {
    ReadFile.getline(ALine,MAX_LEN_HNAME);
    if(strcmp(ALine,Name)==0) CanFind = 0;
    }
  fstream WriteFile;
  WriteFile.open(BLACK_HOST,ios::app|ios::out|ios::in);
  if(CanFind==1)
    {
    WriteFile.write((char*) Name,strlen(Name));
    WriteFile.write((char*)"\n",1);
    cout << "Add host `" << Name <<"' to `blackhost\'."<< endl;
    }
  IsBlackHost = 0;
  }

