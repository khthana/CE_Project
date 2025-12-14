/****------- DECLARATION OF TOPICS-PARMS --------****/


#include <stdio.h>
#include "kpengine.h"
#include "BROWSEST.H"
char* PL2[] = // readLibrary
{
 "file",
  NULL
};
char* PL3[] = // ReadLibraryParms
{
 "item",
  NULL
};
char* PL5[] = // CopyTopic
{
 "item",
  NULL
};
char* PL9[] = // mark
{
 "item",
  NULL
};
char* PL10[] = // checkEnd
{
 "item",
  NULL
};
char* (*PList[]) =
{
  NULL,
  NULL,
  PL2,
  PL3,
  NULL,
  PL5,
  NULL,
  NULL,
  NULL,
  PL9,
  PL10,
  NULL,
  NULL
};

/****------------- END OF PARMLIST -----------****/
