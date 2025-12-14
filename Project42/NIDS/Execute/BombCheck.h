#include <fcntl.h>
#include <linux/if_ether.h>
#include <linux/ip.h>

#define BUFSIZE 512 
#define PacketLimit 5000 
#define LogFileName "DoS.log"
//  time in sec mod this value = Period 
//  this value can be 2,3,4,5,6,10... upto network traffic.. 
#define Check 3                   

/*** structure ***/

struct BombStruct {
  u_long ip;
  u_long count;
  
};


int Bcount = 0;
int Bendcount = 0;
struct BombStruct BombBuff[BUFSIZE];

/** procedure & function **/
void BombChecking();
void ShowBombResult(int ,int);
void SwapBuff();        // Bombbuff -> Bomblog while bufferoverflow or 
                        // it is checking time <2,3,4,5,6 or 10 sec per check > 
