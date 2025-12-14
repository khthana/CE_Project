#if !defined(__thmdichl_h)              // Sentry, use file only if it's not already included.
#define __thmdichl_h

/*  Project thu
    
    Copyright © 1994. All Rights Reserved.

    SUBSYSTEM:    thu.exe Application
    FILE:         thmdichl.h
    AUTHOR:       


    OVERVIEW
    ========
    Class definition for thuMDIChild (TMDIChild).      
*/


#include <owl\owlpch.h>
#pragma hdrstop

#include "thuapp.rh"            // Definition of all resources.


//{{TMDIChild = thuMDIChild}}
class thuMDIChild : public TMDIChild {
public:
    thuMDIChild (TMDIClient &parent, const char far *title, TWindow *clientWnd, bool shrinkToClient = false, TModule* module = 0);
    virtual ~thuMDIChild ();
};    //{{thuMDIChild}}


#endif                                      // __thmdichl_h sentry.
