
#define IPHDR_SIZE 20
#define TM_SIZE 8 
#define STD_BUF 256

#define DEFAULT_LOG_DIR "/var/log/isagnid"
#define DEFAULT_ALERT_DIR "/var/log/isagnid"

/* Struct to get flag **********/ 

struct Chkflag
{
    int host;
    int count;
    int framemin;
    int framehost;
    int sniff;
    int log_dir;
    int land;
    int verbose;
    int log;
    int MF;
    int Realtime;
};


/*  initial Global Variable **********/ 
//Chkflag flag;
int fd_ip;

char datafile[25];
char logdir[STD_BUF];
char alertdir[STD_BUF];
char hour[3];
char date[12];

char dat[50];
char logfile[STD_BUF];
int fd,logfd;

struct iphdr *ip;
struct Chkflag flag; 

/*  Procedure && Function **********/
void PrintHowto(char *);                  // Print How to use program..
void InitFlag();                          // Initial flag
void CheckFlag();                         // Check all flag  
void KeepData();                          // Grep Data to Data File

