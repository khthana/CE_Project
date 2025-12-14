/* KPUTIL.C  - utility functions for external dlls for KnowledgePro */

/* RCS - Some debugging functions can be used in Dispatch */

/*
   Copyright (c) Knowledge Garden Inc. 1990

                 Knowledge Garden Inc.
                 473A Malden Bridge Rd.
                 Nassau, NY 12123

                 Phone (518) 766-3000
                 Fax   (518) 766-3003

   This source code may not be distibuted without permission of
   Knowledge Garden Inc.
*/


/*
   Note some of these functions are defensive in that they try to protect
   KnowledgePro from crashes due to bad structure such as dotted pairs.
   Be careful in building lists, circular lists can crash KnowledgePro.
*/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "kpdefs.h"

/*
   Dispatch is passed a pointer to a USER_REC structure. The first two
   fields define the data and return pointers. UserFuncc is a pointer
   to the function being called in this DLL.   The rest of the fields are
   pointers to call back functions to perform actions in KnowledgePro's
   memory space.
*/

typedef struct
{
   PNODE    DataPtr ;
   PNODE    ReturnPtr ;
   FARPROC  UserFunc ;
   FARPROC  AllocFun ;
   FARPROC  AttachFun ;
   FARPROC  ValueOfFun ;
} USER_REC ;

typedef USER_REC  FAR *USER_REC_PTR ;


/* You are free to distribute the Runtime version of KPWIN toolkits.
   You may not distribute the source or development versions without
   permission. In order to create a runtime version, add the following
   define. You can do this in the command line for kputil in the
   make file.

#define RUNTIME

  The simplest way to create a runtime version of your DLL is to delete
  the file KPUTIL.OBJ and then make kpmathr.mak.    

*/

 
INT FAR PASCAL Dispatch (USER_REC_PTR UserRecPtr) ;

PNODE AllocMemory (USHORT wBytes) ;

PNODE AllocNum (NUMBERTYPE Num) ;
PNODE AllocStr (PSZ Str) ;

USHORT NodeSize (INT NodeType) ;

PNODE Cons (PNODE HeadItem, PNODE TailItem) ;
VOID AttachList (PPNODE List1, PNODE List2) ;
PNODE AppendLists (PNODE List1, PNODE List2) ;
PNODE Head (PNODE List) ;
PNODE Tail (PNODE List) ;
PNODE Element (PNODE List, USHORT Num) ;

PSZ StringVal (PNODE NodePtr) ;
NUMBERTYPE NumberVal (PNODE NodePtr) ;

NUMBERTYPE StrToNum (PSZ Str) ;
VOID NumToStr (PSZ NumStr, NUMBERTYPE Num) ;

BYTE NodeType (PNODE NodePtr) ;

VOID AttachValue (PNODE TopicList, PNODE Params, BOOL RemoveOldValue) ;
PNODE ValueOf (PNODE TopicList, PNODE Params) ;

BOOL CheckSysType (VOID) ;

static FARPROC  AllocFun, AttachFun, ValueOfFun ;

static CHAR     Tmp [81] ;
static CHAR     *endptr ;


/*
   Dispatch (UserRecPtr)

   This function is called by KnowledgePro. It initializes a few local
   pointers and the calls the user function.
*/

INT FAR PASCAL Dispatch (USER_REC_PTR UserRecPtr)
{
   static BOOL  bFirstTime = TRUE ;
   static BOOL  bCallOk = TRUE ;

   if (! bCallOk)
      return (579) ;

   AllocFun = UserRecPtr->AllocFun ;
   AttachFun = UserRecPtr->AttachFun ;
   ValueOfFun = UserRecPtr->ValueOfFun ;

   if (bFirstTime)
      {
      bFirstTime = FALSE ;
      if (! (bCallOk = CheckSysType ()))
         return (579) ;
      }

// These functions should be used for debugging only
//	ValidateFreeSpaces ();
//	GlobalCompact (-1);

   return (*(UserRecPtr->UserFunc)) (UserRecPtr) ;
}

/*
   AllocMemory

   RequestBytes - the number of bytes required.

   returns - a pointer to the first byte allocated. The actual
             amount returned may be slightly more than RequestBytes.
             It returns NIL if no memory was available.

   This function is the basic memory allocation routine. You should
   probably not call this function directly. Call one of the other
   functions described here. They use this function to call KnowledgePro's
   memory allocation routine.
*/

PNODE AllocMemory (USHORT RequestBytes)
{
   PNODE     NewNode ;

   (*AllocFun) (RequestBytes, (LONG FAR *) &NewNode) ;

   return NewNode ;
}


/*  AllocNum

    Num - a number.

    returns - a pointer to a node containing the number.

    Use this function to store numbers in KnowledgePro's memory space.
*/       

PNODE AllocNum (NUMBERTYPE Num)
{
   PNODE  NewNode ;

   NewNode = AllocMemory (NodeSize (NUMBER)) ;
   NewNode->Flags = NUMBER ;
   NewNode->_variant.NumData = Num ;

   return NewNode ;
}


/*  AllocStr

    Str - a FAR Pointer to a NULL terminated string.

    returns - a pointer to a node containing the string.

    Use this function to store strings in KnowledgePro's memory space.
    It makes a copy of the string.

*/

PNODE AllocStr (PSZ Str)
{
  PNODE     NewNode ;

  NewNode = AllocMemory (lstrlen (Str) + NodeSize (CONSTANT) + 1) ;
  NewNode->Flags = CONSTANT ;
  lstrcpy ((PSZ) NewNode + 1, Str) ;

  return NewNode ;
}


/*  NodeSize

    NodeType - an integer code.

    returns - the size in bytes of a node of NodeType. The size returned
              for NUMBER and CONSNODES is correct. The size of
              a CONSTANT node is
              NodeSize (CONSTANT) + lstrlen (StringVal (Ptr)) + 1.
*/

USHORT NodeSize (INT NodeType)
{
   switch (NodeType)
      {
      case CONSNODE:
      case FUNCTION:
         return (2 * sizeof (PNODE) + 1) ;

      case CONSTANT:
         return 1 ;

      case NUMBER:
         return (sizeof (NUMBERTYPE) + 1) ;

      default:
         return 0 ;
      }
}


/*  Cons

    HeadItem - A pointer to Head of the list. It may be a pointer to
               a number or string node or to another cons node. In this case
               the head of the list is a sublist.
    TailItem - A pointer to the rest of the list. This should either be NIL
               or a pointer to a cons node. KnowledgePro does not like
               dotted pairs or circular lists, so be careful that TailItem
               is a proper pointer.

    returns - A pointer to the new cons node.

    You can use Cons to build lists. For example, the list [A, B, C]
    can be constructed by the functions calls:
      Cons (AllocStr ("A"), Cons (AllocStr ("B"), Cons (AllocStr ("C"), NIL)))
    or
      List = Cons (AllocStr ("C"), NIL) ;
      List = Cons (AllocStr ("B"), List) ;
      List = Cons (AllocStr ("A"), List) ;
*/

PNODE Cons (PNODE HeadItem, PNODE TailItem)
{
  PNODE     NewNode ;

  NewNode = AllocMemory (NodeSize (CONSNODE)) ;
  NewNode->Flags = CONSNODE ;
  NewNode->_variant._cons.HeadPtr = HeadItem ;
  if (NodeType (TailItem) == CONSNODE)
     NewNode->_variant._cons.TailPtr = TailItem ;
  else
     NewNode->_variant._cons.TailPtr = NIL ;

  return NewNode ;
}

/*  AttachList

    List1 - a FAR pointer to a PNODE, i.e. a FAR pointer to a FAR pointer
            to a node. This is the address of a list.

    List2 - a pointer to a cons node or NIL.

    This function travels along List1 until it finds the end of the list and
    then performs surgery to attach List2. it thus transforms the list.
    Do not use this function on any list passed to you by KnowledgePro.
    Make a copy of the list first.
*/
  
VOID AttachList (PPNODE List1, PNODE List2)
{
   PNODE     Pnd ;

   if (IsNil (*List1)) 
      *List1 = List2 ;
   else
      {
      Pnd = *List1 ;
      while (! IsNil (Tail (Pnd)))
         Pnd = Tail (Pnd) ;

      if (NodeType (List2) == CONSNODE)
         Pnd->_variant._cons.TailPtr = List2 ;
      else
         Pnd->_variant._cons.TailPtr = NIL ;
      }
}


/*  AppendLists

    List1, List2 - pointers to cons nodes or NIL.

    returns - a pointer to a new list consisting of List2 appended to
              List1.

    This is the safe way to concatenate lists. It makes a copy of the cons
    nodes for the first list. You can use this function on the lists
    passed to you by KnowledgePro.

*/

PNODE AppendLists (PNODE List1, PNODE List2) 
{
   if (IsNil (List1))
      return List2 ;
   else
      return Cons (Head (List1), AppendLists (Tail (List1), List2)) ;
}


/*  Head

    List - a pointer to a node.

    returns - The head pointer of a cons node. This is a pointer to the
              first element of the list. It returns NIL for anything
              other than a cons node.

*/

PNODE Head (PNODE List)
{
   if (NodeType (List) == CONSNODE)
      return List->_variant._cons.HeadPtr ;

   return NIL ;
}


/*  Tail

    List - a pointer to a node.

    returns - The tail pointer of a cons node. This is a pointer to the
              rest of the list. It returns NIL for anything
              other than a cons node.

*/

PNODE Tail (PNODE List)
{
   if (NodeType (List) == CONSNODE)
      return List->_variant._cons.TailPtr ;

   return NIL ;
}


/*  Element

    List - a pointer to a list.

    Num - an element number.

    returns - the Numth element from the list. Element (List,1) is equivalent
              to Head (List). Element (List, 2) is equivalent to
              Head (Tail (List)) etc.
*/

PNODE Element (PNODE List, USHORT Num)
{
   USHORT  i ;

   if (Num == 0)
      return NIL ;

   for (i = 1 ; i < Num ; i++)
      List = Tail (List) ;

   if (NodeType (List) == CONSNODE)
      return Head (List) ;
   else
      return List ;
}


/*  StringVal

    NodePtr - a pointer to a node.

    returns - a FAR pointer to a NULL terminated string. If NodePtr points
              to a CONSTANT node, it returns a pointer to the node's data.
              For a number node, it returns a pointer to a string
              representation of the number. For anything else, it returns
              a pointer to a NULL string.
*/

PSZ StringVal (PNODE NodePtr)
{
   CHAR     TempStr [20] ;

   switch (NodeType (NodePtr))
      {
      case CONSTANT:
      case FUNCTION:
         return ((PSZ) NodePtr + 1) ;
         break ;

      case NUMBER:
         NumToStr (TempStr, NodePtr->_variant.NumData) ;
         return StringVal (AllocStr (TempStr)) ;
         break ;

      default:
         return StringVal (AllocStr ("")) ;
         break ;
      }
}


/*  NumberVal

    NodePtr - a pointer to a node.

    returns - a Number If NodePtr points to a CONSTANT node, it returns a
              coverts the string to a number. For a number node, it returns
              the node's data. For anything else, it returns 0.
*/

NUMBERTYPE NumberVal (PNODE NodePtr)
{
     NUMBERTYPE  Num;
     PSZ         StrTemp ;

   switch (NodeType (NodePtr))
      {
      case CONSTANT:
         StrTemp = StringVal (NodePtr) ;
         Num =  StrToNum (StrTemp) ;
         return Num ;
         break ;

      case NUMBER:
         Num = NodePtr->_variant.NumData ;
         return Num ;
         break ;

      default:
         return 0 ;
         break ;
      }
}


/*  StrToNum
 
    Str - FAR pointer to a NULL terminated string.

    returns - the numerical value of the string.

*/

NUMBERTYPE StrToNum (PSZ Str)
{
   INT         Slen ;
   NUMBERTYPE  Num ;

   Slen = lstrlen (Str) ;
   if ((Slen == 0) || (Slen > 40))
      return 0 ;
   else
      {
      lstrcpy (Tmp, Str) ;
      Num = strtod (Tmp, &endptr) ;
      if (*endptr == '\0')
         return Num ;
      else
         return 0 ;
      }
}


/*  NumToStr

    NumStr - FAR pointer to a string. The string representation of
             the number will be stored here. It should be large
             enough to hold the converted number.
    Num - the number to be converted.

    This function tries to return the most compact representation of
    the number.
*/

VOID NumToStr (PSZ NumStr, NUMBERTYPE Num)
{
   PSZ  TmpPtr ;
	int	precision = 40;
	int	decimal, sign;

	/*	Replaced sprintf with ecvt. sprintf not in the DLL library for
		Windows, but ecvt is - so use it!!

		sprintf (Tmp, "%40.15lf", Num) ;
	*/

	TmpPtr = ecvt (Num, precision, &decimal, &sign);
	if (sign)
		strcpy (Tmp, "-");
	else
		strcpy (Tmp, "");
	strncat (Tmp, TmpPtr, decimal);
	strcat (Tmp, ".");
	strncat (Tmp, TmpPtr + decimal, 15);

   TmpPtr = Tmp + lstrlen (Tmp) - 1 ;
   while (((*TmpPtr == '0') || isspace (*TmpPtr)) && (TmpPtr > Tmp))
      {
      *TmpPtr = '\0' ;
      TmpPtr-- ;
      }

   if ((*TmpPtr == '.') && (TmpPtr > Tmp))
      *TmpPtr = '\0' ;

   TmpPtr = Tmp ;
   while (isspace (*TmpPtr) && lstrlen (TmpPtr)) 
      TmpPtr++ ;
    
   if (! lstrlen (TmpPtr))
      lstrcpy (NumStr, "0") ;
   else
      lstrcpy (NumStr, TmpPtr) ;
}


/*  NodeType

    NodePtr - a pointer to a node.

    returns - the flag byte of the node.
*/

BYTE NodeType (PNODE NodePtr)
{
   BYTE      Type ;

   if (IsNil (NodePtr))
      return NILNODE ;
   else
      {
      Type = NodePtr->Flags & 0x7F ;
      return Type ;
      }
}

/*  AttachValue

    TopicList - a pointer to a node containing a topic name or
                a pointer to a list of names. If the topic does not exists
                it will be created. The search for topics begins at !main,
                so if you want to create subtopics, use the full anme
                of the topic.

    Params - a pointer to a node or list . This is the value to be assigned
             to the topic.

    RemoveOldValue - If non-zero, any value for the topic will be removed
                     before the new value is assigned to the topic. This
                     is equivalent to the make command.
                     If zero, Params is appneded to the topic's value list.
                     This is equivalent to the gets command.
*/

VOID AttachValue (PNODE TopicList, PNODE Params, BOOL RemoveOldValue)
{
   (*AttachFun) (TopicList, Params, RemoveOldValue) ;
}


/*  ValueOf

    TopicList - a pointer to a node containing a topic name or
                a pointer to a list of names. If the topic does not exists
                KnowledgePro will generate an I_TOPIC_NOT_FOUND error
                The search for topics begins at !main,
                so if you want to access subtopics, use the full name
                of the topic.

    Params - a pointer to a node or list . This is the optional parameters list to be
             passed to the topic.

    returns - the topic's value.

    This function is equivalent to the value_of command.

    Note: You can use this function to call KnowledgePro commands also.
          For example: if topiclist points to "Text" and Params points to
                       the list ["Hi", "There"]. "Hi There" will be
                       displayed in the current display window.
*/

PNODE ValueOf (PNODE TopicList, PNODE Params)
{
   PNODE Result ;

   (*ValueOfFun) (TopicList, Params, (PPNODE) &Result) ;

   return Result ;
}


/* Check the System Type. The Runtime system can only run with the
   Runtime version of KPWIN. The Development version can only run with
   the development version of KPWIN */

BOOL CheckSysType (VOID)
{
   LPSTR  lpSysType ;

   lpSysType = StringVal (Element (ValueOf (AllocStr ("SYSTEM_INFO"), NIL), 7)) ;

#if defined(RUNTIME)
   if (lstrcmpi (lpSysType, "RUNTIME") == 0)
      return TRUE ;
#else
   if (lstrcmpi (lpSysType, "DEVELOPMENT") == 0) 
      return TRUE ;
#endif

   return FALSE ;
}
