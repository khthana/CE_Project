/**** GENERATED C++ from browse.kb by KPWin++ V1.00 ****/

char KPKBAppName[] = "BROWSE";

#include <stdio.h>
#include "kpengine.h"
#include "kpkbmain.cpp"
#include "BROWSEop.h"
#include "BROWSEnh.h"

extern char* (*PList[]);

TheList Tree[] = 
{
  {"!main",B_Main,0,MTTListAr,PList[0]},
  {"PromptLoadLib",B_PromptLoadLib,1,MTTListAr,PList[1]},
  {"readLibrary",B_ReadLibrary,1,MTTListAr,PList[2]},
  {"ReadLibraryParms",B_ReadLibraryParms,2,MTTListAr,PList[3]},
  {"CopySyntax",B_CopySyntax,1,MTTListAr,PList[4]},
  {"CopyTopic",B_CopyTopic,1,MTTListAr,PList[5]},
  {"toTopics",B_ToTopics,1,MTTListAr,PList[6]},
  {"Help",B_Help,1,MTTListAr,PList[7]},
  {"Quit",B_Quit,1,MTTListAr,PList[8]},
  {"mark",B_Mark,1,MTTListAr,PList[9]},
  {"checkEnd",B_CheckEnd,2,MTTListAr,PList[10]},
  {"setup",B_Setup,1,MTTListAr,PList[11]},
  {NULL,NULL,0,NULL,NULL}
};

int PASCAL WinMain( HANDLE hInst, HANDLE hPrevInst, LPSTR lpCmdLine, int nCmdShow )
{
  HWND      hMainWnd;
  int       iReturn;
  CATCHBUF  cbStopRun = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  Topic*    Main;
  MSG       msg;

  if ( !hPrevInst && !RegisterKPKBMainWin( hInst ))
    return FALSE;
  if ( !( hMainWnd = InitInstance( hInst, nCmdShow )))
    return FALSE;
  if ( !( iReturn = Catch((int FAR*) cbStopRun )))
  {
    if ( !( Main = KPEngineInit( hInst, hMainWnd, KPKBAppName, Tree, STP, &cbStopRun )))
      return FALSE;
    Main->DB( NULL );
    while ( GetMessage( &msg, NULL, NULL, NULL ))
    {
      TranslateMessage( &msg );
      DispatchMessage( &msg );
    }
    KPEngineTerm( hInst );
    return (int)msg.wParam;
  }
  else
  {
    KPEngineTerm( hInst );
    return (iReturn==0x8000)?0:iReturn;
  }
}

/**** End Of Generated Source from browse.kb ****/
