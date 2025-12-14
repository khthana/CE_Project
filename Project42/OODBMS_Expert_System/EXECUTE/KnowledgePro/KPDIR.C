/* KPDIR.C  - sample external dll for KnowledgePro */

/*
   Copyright (c) Knowledge Garden Inc. 1990

   This source code may not be distibuted without permission of
   Knowledge Garden Inc.
*/

#include <stdlib.h>
#include "kpdefs.h"
#include "kputil.h"

INT FAR PASCAL create_directory (USER_REC_PTR UserRecPtr) ;
INT FAR PASCAL delete_directory (USER_REC_PTR UserRecPtr) ;
char        lpDirectoryName[_MAX_PATH];

INT FAR PASCAL create_directory (USER_REC_PTR UserRecPtr)
{
   PNODE       pnDirectoryName ;

   pnDirectoryName = UserRecPtr->DataPtr ;
   while (NodeType (pnDirectoryName) == CONSNODE)
	pnDirectoryName = Head (pnDirectoryName);

   lstrcpy (lpDirectoryName, StringVal (pnDirectoryName));
   if (_mkdir (lpDirectoryName) == 0)
      UserRecPtr->ReturnPtr = AllocStr ("True") ;
   else
      UserRecPtr->ReturnPtr = AllocStr ("False") ;

   return (0) ;
}

INT FAR PASCAL delete_directory (USER_REC_PTR UserRecPtr)
{
   PNODE       pnDirectoryName ;

   pnDirectoryName = UserRecPtr->DataPtr ;
   while (NodeType (pnDirectoryName) == CONSNODE)
	pnDirectoryName = Head (pnDirectoryName);

   lstrcpy (lpDirectoryName, StringVal (pnDirectoryName));
   if (_rmdir (lpDirectoryName) == 0)
      UserRecPtr->ReturnPtr = AllocStr ("True") ;
   else
      UserRecPtr->ReturnPtr = AllocStr ("False") ;

   return (0) ;
}
