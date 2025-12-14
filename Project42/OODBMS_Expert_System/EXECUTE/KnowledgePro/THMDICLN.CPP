/*  Project thu
    
    Copyright © 1994. All Rights Reserved.

    SUBSYSTEM:    thu.exe Application
    FILE:         thmdicln.cpp
    AUTHOR:       


    OVERVIEW
    ========
    Source file for implementation of thuMDIClient (TMDIClient).      
*/


#include <owl\owlpch.h>
#pragma hdrstop

#include <dir.h>

#include "thuapp.h"
#include "thmdichl.h"
#include "thmdicln.h"
#include "apxprint.h"
#include "apxprev.h"


//{{thuMDIClient Implementation}}


//
// Build a response table for all messages/commands handled
// by thuMDIClient derived from TMDIClient.
//
DEFINE_RESPONSE_TABLE1(thuMDIClient, TMDIClient)
//{{thuMDIClientRSP_TBL_BEGIN}}
    EV_COMMAND(CM_FILEPRINT, CmFilePrint),
    EV_COMMAND(CM_FILEPRINTERSETUP, CmFilePrintSetup),
    EV_COMMAND(CM_FILEPRINTPREVIEW, CmFilePrintPreview),
    EV_COMMAND_ENABLE(CM_FILEPRINT, CmPrintEnable),
    EV_COMMAND_ENABLE(CM_FILEPRINTERSETUP, CmPrintEnable),
    EV_COMMAND_ENABLE(CM_FILEPRINTPREVIEW, CmPrintEnable),
    EV_WM_DROPFILES,
//{{thuMDIClientRSP_TBL_END}}
END_RESPONSE_TABLE;


//////////////////////////////////////////////////////////
// thuMDIClient
// ===========
// Construction/Destruction handling.
thuMDIClient::thuMDIClient (TModule* module)
 : TMDIClient (module)
{
    ChildCount = 0;

    // INSERT>> Your constructor code here.

}


thuMDIClient::~thuMDIClient ()
{
    Destroy();

    // INSERT>> Your destructor code here.

}


//////////////////////////////////////////////////////////
// thuMDIClient
// ===========
// MDIClient site initialization.
void thuMDIClient::SetupWindow ()
{
    // Default SetUpWindow processing.
    TMDIClient::SetupWindow ();

    // Accept files via drag/drop in the client window.
    DragAcceptFiles(true);
}


//////////////////////////////////////////////////////////
// thuMDIClient
// ==========
// Menu File Print command
void thuMDIClient::CmFilePrint ()
{
    //
    // Create Printer object if not already created.
    // 
    thuApp *theApp = TYPESAFE_DOWNCAST(GetApplication(), thuApp);
    if (theApp) {
        if (!theApp->Printer)
            theApp->Printer = new TPrinter(GetApplication());

        //
        // Create Printout window and set characteristics.
        //
        APXPrintOut printout(theApp->Printer, Title, GetActiveMDIChild()->GetClientWindow(), true);

        theApp->Printing++;

        //
        // Bring up the Print dialog and print the document.
        //
        theApp->Printer->Print(GetWindowPtr(GetActiveWindow()), printout, true);

        theApp->Printing--;
    }
}


//////////////////////////////////////////////////////////
// thuMDIClient
// ==========
// Menu File Print Setup command
void thuMDIClient::CmFilePrintSetup ()
{
    thuApp *theApp = TYPESAFE_DOWNCAST(GetApplication(), thuApp);
    if (theApp) {
        if (!theApp->Printer)
            theApp->Printer = new TPrinter(GetApplication());

        //
        // Bring up the Print Setup dialog.
        //
        theApp->Printer->Setup(this);
    }
}


//////////////////////////////////////////////////////////
// thuMDIClient
// ==========
// Menu File Print Preview command
void thuMDIClient::CmFilePrintPreview ()
{
    thuApp *theApp = TYPESAFE_DOWNCAST(GetApplication(), thuApp);
    if (theApp) {
        if (!theApp->Printer)
            theApp->Printer = new TPrinter(GetApplication());

        theApp->Printing++;

        PreviewWindow *prevW = new PreviewWindow(Parent, theApp->Printer, GetActiveMDIChild()->GetClientWindow(), "Print Preview", new TLayoutWindow(0));
        prevW->Create();

        GetApplication()->BeginModal(GetApplication()->GetMainWindow());

        // We must destroy the preview window explicitly.  Otherwise, the window will not be destroyed until
        // it's parent the MainWindow is destroyed.
        prevW->Destroy();
        delete prevW;

        theApp->Printing--;
    }
}


//////////////////////////////////////////////////////////
// thuMDIClient
// ==========
// Menu enabler used by Print, Print Setup and Print Preview.
void thuMDIClient::CmPrintEnable (TCommandEnabler &tce)
{
    if (GetActiveMDIChild()) {
        thuApp *theApp = TYPESAFE_DOWNCAST(GetApplication(), thuApp);
        if (theApp) {
            // If we have a Printer already created just test if all is okay.
            // Otherwise create a Printer object and make sure the printer
            // really exists and then delete the Printer object.
            if (!theApp->Printer) {
                theApp->Printer = new TPrinter(GetApplication());
                
                tce.Enable(theApp->Printer->GetSetup().Error == 0);
            } else
                tce.Enable(theApp->Printer->GetSetup().Error == 0);
        }
    } else
        tce.Enable(false);
}


void thuMDIClient::EvDropFiles (TDropInfo)
{
    Parent->ForwardMessage();
}
