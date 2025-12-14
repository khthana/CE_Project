/*
 *  kpprint.c
 *
 *  Source file for Device-Independent Bitmap (DIB) API.  Provides
 *  the following functions:
 *
 *  PrintWindow()       - Prints all or part of a window
 *  PrintDIB()		- Prints the specified DIB
 *
 * Development Team: Mark Bader
 *                   Patrick Schreiber
 *                   Garrett McAuliffe
 *                   Eric Flo
 *                   Tony Claflin
 *
 * Written by Microsoft Product Support Services, Developer Support.
 * Copyright (c) 1991 Microsoft Corporation. All rights reserved.
 */
#include <assert.h>
#include <windows.h>
#include <string.h>
#include "dibapi.h"     // Header for DIB functions
#include "dibutil.h"    // Auxilirary functions
#include "dialogs.h"    // Header for "Now Printing" dialog box
#include "errors.h"     // Contains error numbers

extern HANDLE ghInst;     // Global handle to instance of main window

/***************************************************************
 * Typedefs
 **************************************************************/

/* Structure used for Banding */

typedef struct
{
   BOOL bGraphics;
   BOOL bText;
   RECT GraphicsRect;
} BANDINFOSTRUCT;


/****************************************************************
 * Variables
 ***************************************************************/

HWND hDlgAbort;                    // Handle to Abort Dialog
char szPrintDlg[] = "Printing";	   // Name of Print dialog from .RC
BOOL bAbort = FALSE;               // Abort a print operation?
char gszDevice[50];                // Keeps track out device (e.g. "HP LaserJet")
char gszOutput[50];                // Output device (e.g. "LPT1:")

/***************************************************************
 * Function prototypes for functions local to this module
 **************************************************************/


BOOL FAR PASCAL PrintAbortProc(HDC, short);
int FAR PASCAL PrintAbortDlg(HWND, unsigned, WORD, LONG);
WORD PrintBand(HDC, LPRECT, LPRECT, BOOL, BOOL, LPBITMAPINFOHEADER, LPSTR);
HDC GetPrinterDC(void);
void CalculatePrintRect(HDC, LPRECT, WORD, DWORD, DWORD);


/**********************************************************************
 *
 * PrintWindow()
 *
 *
 * Description:
 *
 * This function prints the specified window on the default
 * printer.
 *
 * Parameters:
 *
 * HWND hWnd       - Specifies the window to print.  The window must
 *                   not be iconic and must be topmost on the display.
 *
 * WORD fPrintArea - Specifies the area of the window to print.  Must be
 *                   one of PW_ALL, PW_CLIENT, PW_CAPTION,  or PW_MENUBAR
 *
 * WORD fPrintOpt  - Print options (one of PW_BESTFIT, PW_STRETCHTOPAGE, or
 *                   PW_SCALE)
 *
 * WORD wXScale, wYScale - X and Y scaling factors if PW_SCALE is specified
 *
 * LPSTR szJobName - Name that you would like to give to this print job (this
 *                   name shows up in the Print Manager as well as the
 *                   "Now Printing..." dialog box).
 * Return Value:
 *      ERR_DIBFUNCTION or any return value from PrintDIB
 *
 **********************************************************************/


WORD PrintWindow(HWND hWnd,         // Window to be printed
                 WORD fPrintArea,   // Area of window to be printed
                 WORD fPrintOpt,    // Print options
                 WORD wXScale,      // X Scaling factor if PW_SCALE is used
                 WORD wYScale,      // Y Scaling factor if PW_SCALE is used
                 LPSTR szJobName)   // Name of print job
{
   HDIB hDib;          // Handle to the DIB
   WORD wReturn;       // our return value

   /*
    * Parameter validation
    */
   if (!hWnd)
      return (ERR_INVALIDHANDLE);  // Invalid Window

   /*
    * Copy the Window to a DIB and print it.
    */
   hDib = CopyWindowToDIB(hWnd, fPrintArea);
   if (!hDib)
      return (ERR_DIBFUNCTION); // CopyWindowToDIB failed!
   wReturn = PrintDIB(hDib, fPrintOpt, wXScale, wYScale, szJobName);

   /*
    * Call DestroyDIB to free the memory the dib takes up.
    */
   DestroyDIB(hDib);
   return wReturn;   // return the value from PrintDIB
}

/**********************************************************************
 *
 * PrintDIB()
 *
 * Description:
 *
 * This routine prints the specified DIB.  The actual printing is done
 * in the PrintBand() routine (see below), this procedure drives the
 * printing operation.  PrintDIB() has the code to handle both banding
 * and non-banding printers.  A banding printer can be distinguished by
 * the GetDeviceCaps() API (see the code below).  On banding devices,
 * must repeatedly call the NEXTBAND escape to get the next banding
 * rectangle to print into.  If the device supports the BANDINFO escape,
 * it should be used to determine whether the band "wants" text or
 * graphics (or both).  On non-banding devices, we can ignore all this
 * and call PrintBand() on the entire page.
 *
 * Parameters:
 *
 * HDIB hDib       - Handle to dib to be printed
 *
 * WORD fPrintOpt  - tells which print option to use (PW_BESTFIT,
 *                   PW_STRETCHTOPAGE, OR PW_SCALE)
 *
 * WORD wXScale, wYScale - X and Y scaling factors (integers) for
 *                   printed output if the PW_SCALE option is used.
 *
 * LPSTR szJobName - Name that you would like to give to this print job (this
 *                   name shows up in the Print Manager as well as the
 *                   "Now Printing..." dialog box).
 *
 * Return Value:  (see errors.h for description)
 *
 * One of: ERR_INVALIDHANDLE
 *         ERR_LOCK
 *         ERR_SETABORTPROC
 *         ERR_STARTDOC
 *         ERR_NEWFRAME
 *         ERR_ENDDOC
 *         ERR_GETDC
 *         ERR_STRETCHDIBITS
 *
 *
 ********************************************************************/


WORD PrintDIB(HDIB hDib,        // Handle to the DIB
              WORD fPrintOpt,   // Print Options
              WORD wXScale,     // X Scaling factor
              WORD wYScale,     // Y Scaling factor
              LPSTR szJobName)  // Name of print job
{
   HDC hPrnDC;                  // DC to the printer
   RECT rect;                   // Rect structure used for banding
   BANDINFOSTRUCT biBandInfo;   // Used for banding
   static FARPROC lpAbortProc;  // ProcInstance to the Abort Proc
   static FARPROC lpAbortDlg;   // ProcInstance to the Dialog Box Procedure
   int nTemp;                   // Temp number used to check banding capability
   LPSTR lpBits;                // pointer to the DIB bits
   LPBITMAPINFOHEADER lpDIBHdr; // Pointer to DIB header
   int nBandCount = 0;          // used for print dialog box to count bands
   WORD wErrorCode = 0;         // Error code to return
   RECT rPrintRect;             // Rect which specifies the area on the printer
                                // (in printer coordinates) which we
                                // want the DIB to go to
   char szBuffer[70];           // Buffer to hold message for "Printing" dlg box
   char szJobNameTrunc[35];     // szJobName truncated to 31 characters, since
                                // STARTDOC can't accept a string longer than 31

   /*
    * Paramter validation
    */
   if (!hDib)
      return (ERR_INVALIDHANDLE);

   /*
    * Get pointer to DIB header
    */
   lpDIBHdr = (LPBITMAPINFOHEADER)GlobalLock(hDib);
   if (!lpDIBHdr) // Check that we have a valid pointer
      return (ERR_LOCK);
   lpBits = FindDIBBits((LPSTR)lpDIBHdr); // Find pointer to DIB bits
   if (hPrnDC = GetPrinterDC())
   {
      SetStretchBltMode(hPrnDC, COLORONCOLOR);

      /*
       * Determine rPrintRect (printer area to print to) from the
       * fPrintOpt.  Fill in rPrintRect.left and .top from wXScale and
       * wYScale just in case we use PW_SCALE (see the function
       * CalculatePrintRect).
       */
      rPrintRect.left = wXScale;
      rPrintRect.top = wYScale;
      CalculatePrintRect(hPrnDC, &rPrintRect, fPrintOpt, lpDIBHdr->biWidth,
                         lpDIBHdr->biHeight);

      /*
       * Initialize the abort procedure.
       */
      lpAbortProc = MakeProcInstance(PrintAbortProc, ghInst);
      lpAbortDlg = MakeProcInstance(PrintAbortDlg, ghInst);
      hDlgAbort = CreateDialog(ghInst, szPrintDlg, GetFocus(), lpAbortDlg);

      /*
       * Set the text inside the dialog to the name of our print job
       */
      lstrcpy(szJobNameTrunc, szJobName);
      szJobNameTrunc[31] = '\0';           // Truncate string to 31 chars
      wsprintf(szBuffer, "Printing '%s'", (LPSTR)szJobNameTrunc);
      SetDlgItemText(hDlgAbort, IDC_PRINTTEXT1, (LPSTR)szBuffer);

      /*
       * Set global variable bAbort to FALSE.  This will get set to TRUE
       * in our PrintAbortDlg() proceudre if the user selects the
       * CANCEL button in our dialog box
       */
      bAbort = FALSE;

      /*
       * Call the Escape() which will set up the Abort Procedure
       */
      if (Escape(hPrnDC, SETABORTPROC, NULL, (LPSTR)(FARPROC)lpAbortProc, NULL
                 ) < 0)
         return (ERR_SETABORTPROC);

      /*
       * Call Escape() with STARTDOC -- starts print job
       */
      if (Escape(hPrnDC, STARTDOC, lstrlen((LPSTR)szJobNameTrunc), (LPSTR)
                 szJobNameTrunc, NULL) < 0)
      {

         // Oops, something happened, let's clean up here and return
         DestroyWindow(hDlgAbort);   // Remove abort dialog box
         FreeProcInstance(lpAbortProc);
         FreeProcInstance(lpAbortDlg);
         DeleteDC(hPrnDC);
         GlobalUnlock(hDib);
         return (ERR_STARTDOC);
      }

      /*
       * Fill in initial values for our BandInfo Structure to
       * tell driver we can want to do graphics and text, and
       * also which area we want the graphics to go in.
       */
      biBandInfo.bGraphics = TRUE;
      biBandInfo.bText = TRUE;
      biBandInfo.GraphicsRect = rPrintRect;

      /*
       * Check if need to do banding.  If we do, loop through
       *  each band in the page, calling NEXTBAND and BANDINFO
       *  (if supported) calling PrintBand() on the band.  Else,
       *  call PrintBand() with the entire page as our clipping
       *  rectangle!
       */
      nTemp = NEXTBAND;
      if (Escape(hPrnDC, QUERYESCSUPPORT, sizeof(int), (LPSTR)&nTemp, NULL))
      {
         BOOL bBandInfoDevice;

         /*
          * Check if device supports the BANDINFO escape.
          */

         nTemp = BANDINFO;
         bBandInfoDevice = Escape(hPrnDC, QUERYESCSUPPORT, sizeof(int), (LPSTR
                                  )&nTemp, NULL);

         /*
          * Do each band -- Call Escape() with NEXTBAND, then the
          * rect structure returned is the area where we are to
          * print in.  This loop exits when the rect area is empty.
          */
         while (Escape(hPrnDC, NEXTBAND, NULL, NULL, (LPSTR)&rect) && !
                IsRectEmpty(&rect))
         {
            char szTmpBuf[100];

            /*
             * Do the BANDINFO, if needed.
             */

            if (bBandInfoDevice)
               Escape(hPrnDC, BANDINFO, sizeof(BANDINFOSTRUCT), (LPSTR)&
                      biBandInfo, (LPSTR)&biBandInfo);
            wsprintf(szTmpBuf, "Printing Band Number %d", ++nBandCount);
            SetDlgItemText(hDlgAbort, IDC_PERCENTAGE, (LPSTR)szTmpBuf);

            /*
             * Call PrintBand() to do actual output into band.
             *  Pass in our band-info flags to tell what sort
             *  of data to output into the band.  Note that on
             *  non-banding devices, we pass in the default bandinfo
             *  stuff set above (i.e. bText=TRUE, bGraphics=TRUE).
             */
            wErrorCode = PrintBand(hPrnDC, &rPrintRect, &rect,
                                   biBandInfo.bText, biBandInfo.bGraphics,
                                   lpDIBHdr, lpBits);
         }
      }
      else
      {

         /*
          * Print the whole page -- non-banding device.
          */
         rect = rPrintRect;
         SetDlgItemText(hDlgAbort, IDC_PERCENTAGE, (LPSTR)
                        "Sending bitmap to printer...");
         wErrorCode = PrintBand(hPrnDC, &rPrintRect, &rect, TRUE, TRUE,
                                lpDIBHdr, lpBits);

         /*
          * Non-banding devices need a NEWFRAME
          */
         if (Escape(hPrnDC, NEWFRAME, NULL, NULL, NULL) < 0)
            return (ERR_NEWFRAME);
      }

      /*
       * End the print operation.  Only send the ENDDOC if
       *   we didn't abort or error.
       */
      if (!bAbort)
      {
         if (Escape(hPrnDC, ENDDOC, NULL, NULL, NULL) < 0)
         {
            /*
             * We errored out on ENDDOC, but don't return here - we still
             * need to close the dialog box, free proc instances, etc.
             */
            wErrorCode = ERR_ENDDOC;
         }
         DestroyWindow(hDlgAbort);
      }


      /*
       * All done, clean up.
       */
      FreeProcInstance(lpAbortProc);
      FreeProcInstance(lpAbortDlg);
      DeleteDC(hPrnDC);
   }
   else
      wErrorCode = ERR_GETDC;   // Couldn't get Printer DC!
   GlobalUnlock(hDib);
   return (wErrorCode);
}




// *******************************************************************
// Auxilirary Functions
//     -- Local to this module only
// *******************************************************************


/*********************************************************************
 *
 * CalculatePrintRect()
 *
 * Given fPrintOpt and a size of the DIB, return the area on the
 * printer where the image should go (in printer coordinates).  If
 * fPrintOpt is PW_SCALE, then lpPrintRect.left and .top should
 * contain WORDs which specify the scaling factor for the X and
 * Y directions, respecively.
 *
 ********************************************************************/


void CalculatePrintRect(HDC hDC,             // HDC to printer DC
                        LPRECT lpPrintRect,  // Returned PrintRect
                        WORD fPrintOpt,      // Options
                        DWORD cxDIB,         // Size of DIB - x
                        DWORD cyDIB)         // Size of DIB - y
{
   int cxPage, cyPage, cxInch, cyInch;

   if (!hDC)
      return;

   /*
    * Get some info from printer driver
    */
   cxPage = GetDeviceCaps(hDC, HORZRES);     // Width of printr page - pixels
   cyPage = GetDeviceCaps(hDC, VERTRES);     // Height of printr page - pixels
   cxInch = GetDeviceCaps(hDC, LOGPIXELSX);  // Printer pixels per inch - X
   cyInch = GetDeviceCaps(hDC, LOGPIXELSY);  // Printer pixels per inch - Y
   switch (fPrintOpt)
      {

   /*
    * Best Fit case -- create a rectangle which preserves
    * the DIB's aspect ratio, and fills the page horizontally.
    *
    * The formula in the "->bottom" field below calculates the Y
    * position of the printed bitmap, based on the size of the
    * bitmap, the width of the page, and the relative size of
    * a printed pixel (cyInch / cxInch).
    */
   case PW_BESTFIT:
      lpPrintRect->top = 0;
      lpPrintRect->left = 0;
      lpPrintRect->bottom = (int)(((double)cyDIB * cxPage * cyInch) / ((double
                            )cxDIB * cxInch));
      lpPrintRect->right = cxPage;
      break;

   /*
    * Scaling option -- lpPrintRect's top/left contain
    * multipliers to multiply the DIB's height/width by.
    */

   case PW_SCALE:
   {
      int cxMult, cyMult;

      cxMult = lpPrintRect->left;
      cyMult = lpPrintRect->top;
      lpPrintRect->top = 0;
      lpPrintRect->left = 0;
      lpPrintRect->bottom = (int)(cyDIB * cyMult);
      lpPrintRect->right = (int)(cxDIB * cxMult);
   }
      break;

   /*
    * Stretch To Page case -- create a rectangle
    * which covers the entire printing page (note that this
    * is also the default).
    */
   case PW_STRETCHTOPAGE:
   default:
      lpPrintRect->top = 0;
      lpPrintRect->left = 0;
      lpPrintRect->bottom = cyPage;
      lpPrintRect->right = cxPage;
      break;
      }
}



/*********************************************************************
 *
 * PrintBand()
 *
 * This routine does ALL output to the printer.  It is called from
 * the PrintDIB() routine.  It is called for both banding and non-
 * banding printing devices.  lpRectClip contains the rectangular
 * area we should do our output into (i.e. we should clip our output
 * to this area).  The flags fDoText and fDoGraphics should be set
 * appropriately (if we want any text output to the rectangle, set
 * fDoText to true).  Normally these flags are returned on banding
 * devices which support the BANDINFO escape.
 *
 ********************************************************************/


WORD PrintBand(HDC hDC,           // Handle to the Printer DC
               LPRECT lpRectOut,  // Rect where entire DIB is to go
               LPRECT lpRectClip, // Clippping rect where this portion goes
               BOOL fDoText,      // TRUE if this band is for text
               BOOL fDoGraphics,  // TRUE if this band is for graphics
               LPBITMAPINFOHEADER lpDIBHdr,   // Pointer to DIB header
               LPSTR lpDIBBits)   // Pointer to DIB bits
{
   RECT rect;                   // Temporary rectangle
   double dblXScaling,          // X and Y scaling factors
          dblYScaling;
   WORD wReturn = 0;            // Return code

   if (fDoGraphics)
   {
      dblXScaling = ((double)lpRectOut->right - lpRectOut->left) / (double)
                    lpDIBHdr->biWidth;
      dblYScaling = ((double)lpRectOut->bottom - lpRectOut->top) / (double)
                    lpDIBHdr->biHeight;
      /*
       * Now we set up a temporary rectangle -- this rectangle
       *  holds the coordinates on the paper where our bitmap
       *  WILL be output.  We can intersect this rectangle with
       *  the lpClipRect to see what we NEED to output to this
       *  band.  Then, we determine the coordinates in the DIB
       *  to which this rectangle corresponds (using dbl?Scaling).
       */
      IntersectRect(&rect, lpRectOut, lpRectClip);
      if (!IsRectEmpty(&rect))
      {
         RECT rectIn;

         rectIn.left = (int)((rect.left - lpRectOut->left) / dblXScaling + 0.5
                       );
         rectIn.top = (int)((rect.top - lpRectOut->top) / dblYScaling + 0.5);
         rectIn.right = (int)(rectIn.left + (rect.right - rect.left) /
                        dblXScaling + 0.5);
         rectIn.bottom = (int)(rectIn.top + (rect.bottom - rect.top) /
                         dblYScaling + 0.5);
         if (!StretchDIBits(hDC,                              // DestDC
                            rect.left,                        // DestX
                            rect.top,                         // DestY
                            rect.right - rect.left,           // DestWidth
                            rect.bottom - rect.top,           // DestHeight
                            rectIn.left,                      // SrcX
                            (int)(lpDIBHdr->biHeight) -       // SrcY
                            rectIn.top - (rectIn.bottom - rectIn.top),
                            rectIn.right - rectIn.left,       // SrcWidth
                            rectIn.bottom - rectIn.top,       // SrcHeight
                            lpDIBBits,                        // lpBits
                            (LPBITMAPINFO)lpDIBHdr,           // lpBitInfo
                            DIB_RGB_COLORS,                   // wUsage
                            SRCCOPY))                         // dwROP
            wReturn = ERR_STRETCHDIBITS; // StretchDIBits() failed!
      }
   }
   return wReturn;
}


/***********************************************************************
 *
 * GetPrinterDC()
 *
 * Return a DC to the currently selected printer.
 * Returns NULL on error.
 *
 ***********************************************************************/


HDC GetPrinterDC(void)
{
   static char szPrinter[64];
   char *szDevice, *szDriver, *szOutput;

   GetProfileString("windows", "device", "", szPrinter, 64);
   if ((szDevice = strtok(szPrinter, ",")) && (szDriver = strtok(NULL, ", "))
       && (szOutput = strtok(NULL, ", ")))
   {
      lstrcpy((LPSTR)gszDevice, (LPSTR)szDevice);    // Copy to global variables
      lstrcpy((LPSTR)gszOutput, (LPSTR)szOutput);
      return CreateDC(szDriver, szDevice, szOutput, NULL);
   }
   return NULL;
}


/**********************************************************************
 * PrintAbortProc()
 *
 * Abort procedure - contains the message loop while printing is
 * in progress.  By using a PeekMessage() loop, multitasking
 * can occur during printing.
 *
 **********************************************************************/


BOOL FAR PASCAL PrintAbortProc(HDC hDC, short code)
{
   MSG msg;

   while (!bAbort && PeekMessage(&msg, 0, 0, 0, PM_REMOVE))
      if (!IsDialogMessage(hDlgAbort, &msg))
      {
         TranslateMessage(&msg);
         DispatchMessage(&msg);
      }
   return (!bAbort);
}

/***********************************************************************
 *
 * PrintAbortDlg()
 *
 *
 * This is the Dialog Procedure which will handle the "Now Printing"
 * dialog box.  When the user presses the "Cancel" button, the
 * global variable bAbort is set to TRUE, which causes the
 * PrintAbortProc to exit, which in turn causes the printing
 * operation to terminate.
 *
 ***********************************************************************/


int FAR PASCAL PrintAbortDlg(HWND hWnd,   /* Handle to dialog box */ unsigned
                             msg, /* Message */ WORD wParam, LONG lParam)
{
   switch (msg)
      {
   case WM_INITDIALOG:
   {
      char szBuffer[100];

      /*
       * Fill in the text which specifies where this bitmap
       * is going ("on HP LaserJet on LPT1", for example)
       */

      wsprintf(szBuffer, "on %s on %s", (LPSTR)gszDevice, (LPSTR)gszOutput);
      SetDlgItemText(hWnd, IDC_PRINTTEXT2, (LPSTR)szBuffer);
      SetFocus(GetDlgItem(hWnd, IDCANCEL));
   }
      return TRUE;     // Return TRUE because we called SetFocus()

   case WM_COMMAND:
      bAbort = TRUE;
      DestroyWindow(hWnd);
      return TRUE;
      break;
      }
   return FALSE;
}

/*************************************************************************
 *
 * FindDIBBits()
 *
 * Parameter:
 *
 * LPSTR lpbi       - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * LPSTR            - pointer to the DIB bits
 *
 * Description:
 *
 * This function calculates the address of the DIB's bits and returns a
 * pointer to the DIB bits.
 *
 ************************************************************************/


LPSTR FindDIBBits(LPSTR lpbi)
{
   return (lpbi + *(LPDWORD)lpbi + PaletteSize(lpbi));
}


/*************************************************************************
 *
 * DestroyDIB ()
 *
 * Purpose:  Frees memory associated with a DIB
 *
 * Returns:  Nothing
 *
 *************************************************************************/


WORD DestroyDIB(HDIB hDib)
{
   GlobalFree(hDib);
   return 0;
}

/*************************************************************************
 *
 * CopyWindowToDIB()
 *
 * Parameters:
 *
 * HWND hWnd        - specifies the window
 *
 * WORD fPrintArea  - specifies the window area to copy into the device-
 *                    independent bitmap
 *
 * Return Value:
 *
 * HDIB             - identifies the device-independent bitmap
 *
 * Description:
 *
 * This function copies the specified part(s) of the window to a device-
 * independent bitmap.
 *
 ************************************************************************/


HDIB CopyWindowToDIB(HWND hWnd, WORD fPrintArea)
{
   HDIB hDIB = NULL;  // handle to DIB

   /* check for a valid window handle */

   if (!hWnd)
      return NULL;
   switch (fPrintArea)
      {
   case PW_WINDOW: // copy entire window
   {
      RECT rectWnd;

      /* get the window rectangle */

      GetWindowRect(hWnd, &rectWnd);

      /*  get the DIB of the window by calling
       *  CopyScreenToDIB and passing it the window rect
       */
      hDIB = CopyScreenToDIB(&rectWnd);
   }
      break;

   case PW_CLIENT: // copy client area
   {
      RECT rectClient;
      POINT pt1, pt2;

      /* get the client area dimensions */

      GetClientRect(hWnd, &rectClient);

      /* convert client coords to screen coords */
      pt1.x = rectClient.left;
      pt1.y = rectClient.top;
      pt2.x = rectClient.right;
      pt2.y = rectClient.bottom;
      ClientToScreen(hWnd, &pt1);
      ClientToScreen(hWnd, &pt2);
      rectClient.left = pt1.x;
      rectClient.top = pt1.y;
      rectClient.right = pt2.x;
      rectClient.bottom = pt2.y;

      /*  get the DIB of the client area by calling
       *  CopyScreenToDIB and passing it the client rect
       */
      hDIB = CopyScreenToDIB(&rectClient);
   }
      break;

   default:    // invalid print area
      return NULL;
      }

   /* return the handle to the DIB */
   return hDIB;
}


/*************************************************************************
 *
 * CopyScreenToDIB()
 *
 * Parameter:
 *
 * LPRECT lpRect    - specifies the window
 *
 * Return Value:
 *
 * HDIB             - identifies the device-independent bitmap
 *
 * Description:
 *
 * This function copies the specified part of the screen to a device-
 * independent bitmap.
 *
 ************************************************************************/


HDIB CopyScreenToDIB(LPRECT lpRect)
{
   HBITMAP hBitmap;    // handle to device-dependent bitmap
   HPALETTE hPalette;  // handle to palette
   HDIB hDIB = NULL;   // handle to DIB

   /*  get the device-dependent bitmap in lpRect by calling
    *  CopyScreenToBitmap and passing it the rectangle to grab
    */

   hBitmap = CopyScreenToBitmap(lpRect);

   /* check for a valid bitmap handle */
   if (!hBitmap)
      return NULL;

   /* get the current palette */
   hPalette = GetSystemPalette();

   /* convert the bitmap to a DIB */
   hDIB = BitmapToDIB(hBitmap, hPalette);

   /* clean up */
   DeleteObject(hBitmap);

   /* return handle to the packed-DIB */
   return hDIB;
}

/*************************************************************************
 *
 * CopyScreenToBitmap()
 *
 * Parameter:
 *
 * LPRECT lpRect    - specifies the window
 *
 * Return Value:
 *
 * HDIB             - identifies the device-dependent bitmap
 *
 * Description:
 *
 * This function copies the specified part of the screen to a device-
 * dependent bitmap.
 *
 ************************************************************************/


HBITMAP CopyScreenToBitmap(LPRECT lpRect)
{
   HDC hScrDC, hMemDC;           // screen DC and memory DC
   HBITMAP hBitmap, hOldBitmap;  // handles to deice-dependent bitmaps
   int nX, nY, nX2, nY2;         // coordinates of rectangle to grab
   int nWidth, nHeight;          // DIB width and height
   int xScrn, yScrn;             // screen resolution

   /* check for an empty rectangle */

   if (IsRectEmpty(lpRect))
      return NULL;

   /*  create a DC for the screen and create
    *  a memory DC compatible to screen DC
    */
   hScrDC = CreateDC("DISPLAY", NULL, NULL, NULL);
   hMemDC = CreateCompatibleDC(hScrDC);

   /* get points of rectangle to grab */
   nX = lpRect->left;
   nY = lpRect->top;
   nX2 = lpRect->right;
   nY2 = lpRect->bottom;

   /* get screen resolution */
   xScrn = GetDeviceCaps(hScrDC, HORZRES);
   yScrn = GetDeviceCaps(hScrDC, VERTRES);

   /* make sure bitmap rectangle is visible */
   if (nX < 0)
      nX = 0;
   if (nY < 0)
      nY = 0;
   if (nX2 > xScrn)
      nX2 = xScrn;
   if (nY2 > yScrn)
      nY2 = yScrn;
   nWidth = nX2 - nX;
   nHeight = nY2 - nY;

   /* create a bitmap compatible with the screen DC */
   hBitmap = CreateCompatibleBitmap(hScrDC, nWidth, nHeight);

   /* select new bitmap into memory DC */
   hOldBitmap = SelectObject(hMemDC, hBitmap);

   /* bitblt screen DC to memory DC */
   BitBlt(hMemDC, 0, 0, nWidth, nHeight, hScrDC, nX, nY, SRCCOPY);

   /*  select old bitmap back into memory DC and get handle to
    *  bitmap of the screen
    */
   hBitmap = SelectObject(hMemDC, hOldBitmap);

   /* clean up */
   DeleteDC(hScrDC);
   DeleteDC(hMemDC);

   /* return handle to the bitmap */
   return hBitmap;
}

/*************************************************************************
 *
 * PaletteSize()
 *
 * Parameter:
 *
 * LPSTR lpbi       - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * WORD             - size of the color palette of the DIB
 *
 * Description:
 *
 * This function gets the size required to store the DIB's palette by
 * multiplying the number of colors by the size of an RGBQUAD (for a
 * Windows 3.0-style DIB) or by the size of an RGBTRIPLE (for an OS/2-
 * style DIB).
 *
 ************************************************************************/


WORD PaletteSize(LPSTR lpbi)
{
   /* calculate the size required by the palette */
   if (IS_WIN30_DIB (lpbi))
      return (DIBNumColors(lpbi) * sizeof(RGBQUAD));
   else
      return (DIBNumColors(lpbi) * sizeof(RGBTRIPLE));
}

/*************************************************************************
 *
 * BitmapToDIB()
 *
 * Parameters:
 *
 * HBITMAP hBitmap  - specifies the bitmap to convert
 *
 * HPALETTE hPal    - specifies the palette to use with the bitmap
 *
 * Return Value:
 *
 * HDIB             - identifies the device-dependent bitmap
 *
 * Description:
 *
 * This function creates a DIB from a bitmap using the specified palette.
 *
 ************************************************************************/


HDIB BitmapToDIB(HBITMAP hBitmap, HPALETTE hPal)
{
   BITMAP bm;                   // bitmap structure
   BITMAPINFOHEADER bi;         // bitmap header
   BITMAPINFOHEADER FAR *lpbi;  // pointer to BITMAPINFOHEADER
   DWORD dwLen;                 // size of memory block
   HANDLE hDIB, h;              // handle to DIB, temp handle
   HDC hDC;                     // handle to DC
   WORD biBits;                 // bits per pixel

   /* check if bitmap handle is valid */

   if (!hBitmap)
      return NULL;

   /* if no palette is specified, use default palette */
   if (hPal == NULL)
      hPal = GetStockObject(DEFAULT_PALETTE);

   /* fill in BITMAP structure */
   GetObject(hBitmap, sizeof(bm), (LPSTR)&bm);

   /* calculate bits per pixel */
   biBits = bm.bmPlanes * bm.bmBitsPixel;

   /* initialize BITMAPINFOHEADER */
   bi.biSize = sizeof(BITMAPINFOHEADER);
   bi.biWidth = bm.bmWidth;
   bi.biHeight = bm.bmHeight;
   bi.biPlanes = 1;
   bi.biBitCount = biBits;
   bi.biCompression = DIB_RGB_COLORS;
   bi.biSizeImage = 0;
   bi.biXPelsPerMeter = 0;
   bi.biYPelsPerMeter = 0;
   bi.biClrUsed = 0;
   bi.biClrImportant = 0;

   /* calculate size of memory block required to store BITMAPINFO */
   dwLen = bi.biSize + PaletteSize((LPSTR)&bi);

   /* get a DC */
   hDC = GetDC(NULL);

   /* select and realize our palette */
   hPal = SelectPalette(hDC, hPal, FALSE);
   RealizePalette(hDC);

   /* alloc memory block to store our bitmap */
   hDIB = GlobalAlloc(GHND, dwLen);

   /* if we couldn't get memory block */
   if (!hDIB)
   {
      /* clean up and return NULL */
      SelectPalette(hDC, hPal, TRUE);
      RealizePalette(hDC);
      ReleaseDC(NULL, hDC);
      return NULL;
   }

   /* lock memory and get pointer to it */
   lpbi = (VOID FAR *)GlobalLock(hDIB);

   /* use our bitmap info. to fill BITMAPINFOHEADER */
   *lpbi = bi;

   /*  call GetDIBits with a NULL lpBits param, so it will calculate the
    *  biSizeImage field for us
    */
   GetDIBits(hDC, hBitmap, 0, (WORD)bi.biHeight, NULL, (LPBITMAPINFO)lpbi,
             DIB_RGB_COLORS);

   /* get the info. returned by GetDIBits and unlock memory block */
   bi = *lpbi;
   GlobalUnlock(hDIB);

   /* if the driver did not fill in the biSizeImage field, make one up */
   if (bi.biSizeImage == 0)
      bi.biSizeImage = WIDTHBYTES((DWORD)bm.bmWidth * biBits) * bm.bmHeight;

   /* realloc the buffer big enough to hold all the bits */
   dwLen = bi.biSize + PaletteSize((LPSTR)&bi) + bi.biSizeImage;
   if (h = GlobalReAlloc(hDIB, dwLen, 0))
      hDIB = h;
   else
   {
      /* clean up and return NULL */
      GlobalFree(hDIB);
      hDIB = NULL;
      SelectPalette(hDC, hPal, TRUE);
      RealizePalette(hDC);
      ReleaseDC(NULL, hDC);
      return NULL;
   }

   /* lock memory block and get pointer to it */
   lpbi = (VOID FAR *)GlobalLock(hDIB);

   /*  call GetDIBits with a NON-NULL lpBits param, and actualy get the
    *  bits this time
    */
   if (GetDIBits(hDC, hBitmap, 0, (WORD)bi.biHeight, (LPSTR)lpbi + (WORD)lpbi
                 ->biSize + PaletteSize((LPSTR)lpbi), (LPBITMAPINFO)lpbi,
                 DIB_RGB_COLORS) == 0)
   {
      /* clean up and return NULL */
      GlobalUnlock(hDIB);
      hDIB = NULL;
      SelectPalette(hDC, hPal, TRUE);
      RealizePalette(hDC);
      ReleaseDC(NULL, hDC);
      return NULL;
   }
   bi = *lpbi;

   /* clean up */
   GlobalUnlock(hDIB);
   SelectPalette(hDC, hPal, TRUE);
   RealizePalette(hDC);
   ReleaseDC(NULL, hDC);

   /* return handle to the DIB */
   return hDIB;
}

HPALETTE GetSystemPalette(void)
{
   HDC hDC;                // handle to a DC
   HPALETTE hPal = NULL;   // handle to a palette
   HANDLE hLogPal;         // handle to a logical palette
   LPLOGPALETTE lpLogPal;  // pointer to a logical palette
   int i, nColors;         // loop index, number of colors

   /* Find out how many palette entries we want. */

   hDC = GetDC(NULL);
   if (!hDC)
      return NULL;
   nColors = PalEntriesOnDevice(hDC);
   ReleaseDC(NULL, hDC);

   /* Allocate room for the palette and lock it. */
   hLogPal = GlobalAlloc(GHND, sizeof(LOGPALETTE) + nColors * sizeof(
                         PALETTEENTRY));

   /* if we didn't get a logical palette, return NULL */
   if (!hLogPal)
      return NULL;

   /* get a pointer to the logical palette */
   lpLogPal = (LPLOGPALETTE)GlobalLock(hLogPal);

   /* set some important fields */
   lpLogPal->palVersion = PALVERSION;
   lpLogPal->palNumEntries = nColors;
   for (i = 0; i < nColors; i++)
   {
      lpLogPal->palPalEntry[i].peBlue = 0;
      *((LPWORD)(&lpLogPal->palPalEntry[i].peRed)) = i;
      lpLogPal->palPalEntry[i].peFlags = PC_EXPLICIT;
   }

   /*  Go ahead and create the palette.  Once it's created,
    *  we no longer need the LOGPALETTE, so free it.
    */
   hPal = CreatePalette(lpLogPal);

   /* clean up */
   GlobalUnlock(hLogPal);
   GlobalFree(hLogPal);
   return hPal;
}

/*************************************************************************
 *
 * DIBNumColors()
 *
 * Parameter:
 *
 * LPSTR lpbi       - pointer to packed-DIB memory block
 *
 * Return Value:
 *
 * WORD             - number of colors in the color table
 *
 * Description:
 *
 * This function calculates the number of colors in the DIB's color table
 * by finding the bits per pixel for the DIB (whether Win3.0 or OS/2-style
 * DIB). If bits per pixel is 1: colors=2, if 4: colors=16, if 8: colors=256,
 * if 24, no colors in color table.
 *
 ************************************************************************/


WORD DIBNumColors(LPSTR lpbi)
{
   WORD wBitCount;  // DIB bit count

   /*  If this is a Windows-style DIB, the number of colors in the
    *  color table can be less than the number of bits per pixel
    *  allows for (i.e. lpbi->biClrUsed can be set to some value).
    *  If this is the case, return the appropriate value.
    */

   if (IS_WIN30_DIB(lpbi))
   {
      DWORD dwClrUsed;

      dwClrUsed = ((LPBITMAPINFOHEADER)lpbi)->biClrUsed;
      if (dwClrUsed)
         return (WORD)dwClrUsed;
   }

   /*  Calculate the number of colors in the color table based on
    *  the number of bits per pixel for the DIB.
    */
   if (IS_WIN30_DIB(lpbi))
      wBitCount = ((LPBITMAPINFOHEADER)lpbi)->biBitCount;
   else
      wBitCount = ((LPBITMAPCOREHEADER)lpbi)->bcBitCount;

   /* return number of colors based on bits per pixel */
   switch (wBitCount)
      {
   case 1:
      return 2;

   case 4:
      return 16;

   case 8:
      return 256;

   default:
      return 0;
      }
}

/*************************************************************************
 *
 * PalEntriesOnDevice()
 *
 * Parameter:
 *
 * HDC hDC          - device context
 *
 * Return Value:
 *
 * int              - number of palette entries on device
 *
 * Description:
 *
 * This function gets the number of palette entries on the specified device
 *
 ************************************************************************/


int PalEntriesOnDevice(HDC hDC)
{
   int nColors;  // number of colors

   /*  Find out the number of palette entries on this
    *  device.
    */

   nColors = GetDeviceCaps(hDC, SIZEPALETTE);

   /*  For non-palette devices, we'll use the # of system
    *  colors for our palette size.
    */
   if (!nColors)
      nColors = GetDeviceCaps(hDC, NUMCOLORS);
   assert(nColors);
   return nColors;
}
