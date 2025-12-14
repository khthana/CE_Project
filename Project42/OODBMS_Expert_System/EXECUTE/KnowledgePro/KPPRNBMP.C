/* KPPRNBMP.C  - Bitmap printing dll for KnowledgePro */

/*
   Copyright (c) Knowledge Garden Inc. 1992

                 Knowledge Garden Inc.

   This source code may not be distibuted without permission of
   Knowledge Garden Inc.
*/

#include "kpdefs.h"
#include "kputil.h"
#include "dibapi.h"

INT FAR PASCAL print_bitmap (USER_REC_PTR UserRecPtr) ;

/* print_bitmap - prints a bitmap.

   It is called from KnowledgePro as:
      x = user (lib_handle, print_bitmap, List).

   where List containing the handle to the bitmap and
   the a printing option.

*/

WORD PrintDIB(HDIB hDib,
	      WORD fPrintOpt,
	      WORD wXScale,
	      WORD wYScale,
	      LPSTR szJobName);

WORD PrintWindow(HWND hWnd,
		 WORD fPrintArea,
		 WORD fPrintOpt,
		 WORD wXScale,
		 WORD wYScale,
		 LPSTR szJobName);

INT FAR PASCAL print_bitmap (USER_REC_PTR UserRecPtr)
{
   PNODE       pnParmList, pnHandle, pnOption ;
   HDIB        hBitmap ;
   LPSTR       lpOption ;
   WORD        wReturn, wOption ;

   pnParmList = UserRecPtr->DataPtr ;
   while (NodeType (Head (pnParmList)) == CONSNODE)
	pnParmList = Head (pnParmList);

   pnHandle = Head (pnParmList);
   while (NodeType (pnHandle) == CONSNODE)
	pnHandle = Head (pnHandle);
   hBitmap = (HDIB) NumberVal (pnHandle);

   pnParmList = Tail (pnParmList);

   pnOption = Head (pnParmList);
   while (NodeType (pnOption) == CONSNODE)
	pnOption = Head (pnOption);
   lpOption = StringVal (pnOption);

   if (!lstrcmpi (lpOption, "BESTFIT"))
      wOption = PW_BESTFIT;
   else
      wOption = PW_STRETCHTOPAGE;

   wReturn = PrintDIB (hBitmap, wOption,
                       (WORD) 0, (WORD) 0,
		       (LPSTR) "KnowledgePro bitmap");

   UserRecPtr->ReturnPtr = AllocNum (wReturn) ;
   return (0) ;
}

INT FAR PASCAL print_window (USER_REC_PTR UserRecPtr)
{
   PNODE       pnParmList, pnHandle, pnOption, pnArea ;
   HDIB        hWindow ;
   LPSTR       lpOption, lpArea ;
   WORD        wReturn, wOption, wArea ;

   pnParmList = UserRecPtr->DataPtr ;
   while (NodeType (Head (pnParmList)) == CONSNODE)
	pnParmList = Head (pnParmList);

   pnHandle = Head (pnParmList);
   while (NodeType (pnHandle) == CONSNODE)
	pnHandle = Head (pnHandle);
   hWindow = (HDIB) NumberVal (pnHandle);

   pnParmList = Tail (pnParmList);

   pnArea = Head (pnParmList);
   while (NodeType (pnArea) == CONSNODE)
	pnOption = Head (pnArea);
   lpArea = StringVal (pnArea);

   if (!lstrcmpi (lpArea, "ALL"))
      wArea = PW_WINDOW;
   else
      wArea = PW_CLIENT;

   pnParmList = Tail (pnParmList);

   pnOption = Head (pnParmList);
   while (NodeType (pnOption) == CONSNODE)
	pnOption = Head (pnOption);
   lpOption = StringVal (pnOption);

   if (!lstrcmpi (lpOption, "BESTFIT"))
      wOption = PW_BESTFIT;
   else
      wOption = PW_STRETCHTOPAGE;

   wReturn = PrintWindow(hWindow, wArea, wOption,
		       (WORD) 0, (WORD) 0,
		       (LPSTR) "KnowledgePro bitmap");

   UserRecPtr->ReturnPtr = AllocNum (wReturn) ;
   return (0) ;
}
