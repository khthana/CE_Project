#if !defined(__thmdicln_h)              // Sentry, use file only if it's not already included.
#define __thmdicln_h

/*  Project thu
    
    Copyright © 1994. All Rights Reserved.

    SUBSYSTEM:    thu.exe Application
    FILE:         thmdicln.h
    AUTHOR:       


    OVERVIEW
    ========
    Class definition for thuMDIClient (TMDIClient).      
*/


#include <owl\owlpch.h>
#pragma hdrstop

#include "thuapp.rh"            // Definition of all resources.


//{{TMDIClient = thuMDIClient}}
class thuMDIClient : public TMDIClient {
public:
    int                     ChildCount;                 // Number of child window created. 

    thuMDIClient(TModule* module = 0);
    virtual ~thuMDIClient ();

    void OpenFile (const char *fileName = 0);

private:
    void LoadTextFile ();

//{{thuMDIClientVIRTUAL_BEGIN}}
protected:
    virtual void SetupWindow ();
//{{thuMDIClientVIRTUAL_END}}

//{{thuMDIClientRSP_TBL_BEGIN}}
protected:
    void CmFilePrint ();
    void CmFilePrintSetup ();
    void CmFilePrintPreview ();
    void CmPrintEnable (TCommandEnabler &tce);
    void EvDropFiles (TDropInfo);
//{{thuMDIClientRSP_TBL_END}}
DECLARE_RESPONSE_TABLE(thuMDIClient);
};    //{{thuMDIClient}}


#endif                                      // __thmdicln_h sentry.
