//init.cpp : Initial status of every user in system.Starting status is 0.
# include <sys/types.h>
# include <pwd.h>
# include <fstream.h>

char USERINFO[]="userinfo";
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

void WriteInfo(usrinfo *User);

void main()
  {
  usrinfo *User;
  usrinfo *User1 = new usrinfo;
  usrinfo *User2;
  User = User1;
  struct passwd *pw_ptr;
  pw_ptr = getpwent();
  while(pw_ptr)
    {
    strcpy(User1->Name,pw_ptr->pw_name);
    User1->UID = pw_ptr->pw_uid;
    User1->GID = pw_ptr->pw_gid;
    strcpy(User1->Home,pw_ptr->pw_dir);
    strcpy(User1->Shell,pw_ptr->pw_shell);
    User1->State = 0;
    User1->Status = 0;
    User1->Counter2 = 0;
    User1->DateSt2 = 0;
    User1->MonthSt2 = 0;
    User1->HourSt2 = 0;
    User1->MinuteSt2 = 0;
    User1->Counter3 = 0;
    User1->DateSt3 = 0;
    User1->MonthSt3 = 0;
    User1->HourSt3 = 0;
    User1->MinuteSt3 = 0;
    User1->Counter4 = 0;
    User1->DateSt4 = 0;
    User1->MonthSt4 = 0;
    User1->HourSt4 = 0;
    User1->MinuteSt4 = 0;
    User1->LoginCount = 0;
    WriteInfo(User1);
    User2 = new usrinfo;
    User1->Ptr = User2;
    User1 = User2;
    pw_ptr = getpwent();
    }
  cout << "Users' information initiation completed." << endl;
  }

void WriteInfo(usrinfo *User)
  {
  fstream File;
  File.open(USERINFO,ios::app|ios::out|ios::in);
  File.write((char*)User,sizeof(usrinfo));
  File.close();
  }
