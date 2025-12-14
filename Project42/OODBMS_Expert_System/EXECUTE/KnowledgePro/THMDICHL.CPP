/*  Project thu
    
    Copyright © 1994. All Rights Reserved.

    SUBSYSTEM:    thu.exe Application
    FILE:         thmdichl.cpp
    AUTHOR:       


    OVERVIEW
    ========
    Source file for implementation of thuMDIChild (TMDIChild).      
*/


#include <owl\owlpch.h>
#pragma hdrstop

#include "thuapp.h"
#include "thmdichl.h"


//{{thuMDIChild Implementation}}


//////////////////////////////////////////////////////////
// thuMDIChild
// ==========
// Construction/Destruction handling.
thuMDIChild::thuMDIChild (TMDIClient &parent, const char far *title, TWindow *clientWnd, bool shrinkToClient, TModule *module)
    : TMDIChild (parent, title, clientWnd, shrinkToClient, module)
{
    // INSERT>> Your constructor code here.

}


thuMDIChild::~thuMDIChild ()
{
    Destroy();

    // INSERT>> Your destructor code here.

}
