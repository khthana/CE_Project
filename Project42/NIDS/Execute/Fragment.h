#include "rmonit.h"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/ip.h>
#include <linux/if_ether.h>
#define TUPCOUNT 20 
#define LogFileName "DoS.log"

/* structure of IP datafile */
struct IPdata // _ipdata      // Struct of DATA
{
  int sec;
  int min;
  struct iphdr ip;
};

struct range                  // Range of fragmentation
{
  int lfragoff;
  int rfragoff;
};

struct Chbuffer               // Structure of Buffer..
{
  u_long ip;                 // Keep IP of Frame
  int count;                 // Counting the Same-ID Frame   
  int id;                    // keep ID of Frame
  int flag;                  // flag bit 0 set if offset = 0 and MF
                             //      bit 1 set if offset > 0 and Non-MF frame

  struct range tupple[TUPCOUNT];   // Use for regist frame and manage the
                                   // reassemble process
  int lmerge;               // for keep left tupple of frame
  int rmerge;               // for keep right tupple of frame
                            // if lmerge and rmerge not eq to 0
                            // so frame can merge and reduce tupple...
  int tupplecount;          // Count the used Tupple
  int merge;	            // Count tupple which new frame can Merge
                            // IF Merge = 0 , add new Tupple
                            // IF Merge = 1 , reassemble to Tupple
                            // IF Merge = 2 , reassemble to double Tupple
                            // and it can reduce tupple...

};

struct OverlapData {
  u_long ip;
  u_long count;
  int id;
  int start_min;
  int start_sec; 
  int end_min;
  int end_sec;
  struct ethhdr eth; 
};

/*
struct GapFrame {
  u_long ip;
  int id;
  u_long count;
  int start_min;
  int start_sec;
  int end_min;
  int end_sec;
  struct ethhdr eth;
};
*/

int overflow;              // overflow flag 0 = overflow else 1; 
struct Chbuffer buffer[STD_BUF];           
struct iphdr *ip;
struct IPdata data;
struct OverlapData overlap[STD_BUF];
struct OverlapData gap[STD_BUF];

int startindex;
int addindex;
int endindex;

int fragstartindex;
int fragendindex;
int fragcount;
int abnormalsign;

int gapstartindex;
int gapendindex;
int gapcount;

/* Procedure && Function ***************/
void CheckFragment(char *);        // Fragmentation Error Detection; 
void Initialize();                 // Initialize Buffer for Use;
void NotFoundInBuffer();           // Do all job if new-id Frame recieved;
void FoundInBuffer();              // Do all job if same-id Frame recieved;
void FixAndReduce();               // Reassemble and Reduce the tupple; 
void AddNewTupple();               // Add new tupple to Buffer;
void showbuffer();
void NormalCheck();                // Checking normal reassemble 
void AbnormalCheck();              // Checking Abnormal reassemble and 
void AddOverlapID(int);            // AddID for OverlapFrame in Buffer
void ShowResult();		   // Show fragment Result
void GapDetect();                  // Logging gap in Reassemble method
void RealTimeFragChk();            // For Checking Fragment in Realtime
//void KeepMac();                    // Keep Mac Address of Frame while attack
