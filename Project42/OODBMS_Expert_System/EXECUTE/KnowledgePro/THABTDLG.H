#if !defined(__thabtdlg_h)              // Sentry, use file only if it's not already included.
#define __thabtdlg_h

/*  Project thu
    
    Copyright © 1994. All Rights Reserved.

    SUBSYSTEM:    thu.exe Application
    FILE:         thabtdlg.h
    AUTHOR:       


    OVERVIEW
    ========
    Class definition for thuAboutDlg (TDialog).      
*/


#include <owl\owlpch.h>
#pragma hdrstop

#include "thuapp.rh"                  // Definition of all resources.


//{{TDialog = thuAboutDlg}}
class thuAboutDlg : public TDialog {
public:
    thuAboutDlg (TWindow *parent, TResId resId = IDD_ABOUT, TModule *module = 0);
    virtual ~thuAboutDlg ();

//{{thuAboutDlgVIRTUAL_BEGIN}}
public:
    void SetupWindow ();
//{{thuAboutDlgVIRTUAL_END}}
};    //{{thuAboutDlg}}


// Reading the VERSIONINFO resource.
class ProjectRCVersion {
public:
    ProjectRCVersion (TModule *module);
    virtual ~ProjectRCVersion ();

    bool GetProductName (LPSTR &prodName);
    bool GetProductVersion (LPSTR &prodVersion);
    bool GetCopyright (LPSTR &copyright);
    bool GetDebug (LPSTR &debug);

protected:
    LPBYTE      TransBlock;
    void FAR    *FVData;

private:
    // Don't allow this object to be copied.
    ProjectRCVersion (const ProjectRCVersion &);
    ProjectRCVersion & operator =(const ProjectRCVersion &);
};


#endif                                      // __thabtdlg_h sentry.
