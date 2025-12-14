/* KPUSER.C  - sample external dll for KnowledgePro */

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
   This file contains the source for a very simple external routine which
   calculates the average of a list of numbers. The structures and routines
   it uses are contained in the two include files.
      
   Callable external routines must be declared as FAR PASCAL so that
   KnowledgePro can find them in the DLL. The routine name must be
   "exported", i.e. it must be declared in the EXPORTS section of the
   .DEF file. See the file KPUSER.DEF to see how this is done. If
   the routine is not exported, KnowledgePro will not know that it
   exists in the DLL and you will get an I_INVALID_FUNCTION error when
   you attempt to call it.

   KnowledgePro does not call the function directly, it calls a routine
   called Dispatch, located in KPUTIL.C, which does some initialization
   and calls the user function.

   Your routine will be passed a FAR pointer to a USER_REC structure.
   USER_REC is declared in KPUTIL.C. USER_REC contains two fields that
   you need to worry about, DataPtr and ReturnPtr which are pointers to
   a structure called a NODE. NODE is declared in KPDEFS.H and is the
   the basic structural unit of KnowledgePro. These pointers point into
   KnowledgePro's memory space. When your routine is called, the data
   pointed to by DataPtr is locked, so these FAR pointers will remain
   valid. They may not remain valid between function calls, so it is
   not safe to copy a pointer to a static or global variable and
   expect it to be valid the next time the function is called. The data
   may move between calls to your function. If you need data between
   function calls, either copy the data, not the pointer, to a static
   structure or have the knowledge base pass it to your function with each
   call.
      
   Your routines should not access nodes directly. Instead, it sould use
   the routines in KPUTIL.C. It is particularly importtant that you do
   not change any data in any node. KnowledgePro often shares data among
   many different structures and you may inadvertantly alter the values
   of several topics by changing the contents of one node. Treat the data
   passed to the function and data allocated using the routines in
   KPUTIL.C as read only.

   KnowledgePro uses a variety of different types of NODEs, but you need
   to be concerned about only 3 types: string nodes, number nodes and
   cons nodes. String and Number Nodes contain string or numerical data.
   Cons nodes contain pointers to other nodes. Cons nodes are the glue
   which holds KnowledgePro data structures together.

   Your routine will be passed a linked list of cons nodes that point to the
   data for the routine. For example, if the the list , [2, [a, b], 6]
   were passed to a user function,  UserRecPtr->DataPtr would be a FAR
   pointer to a linked list with the structure:

    UserRec->DataPtr
        |
        |          -------         --------          --------
        |--------> | .| . |----->  |  .| . |------> |  .| . |---> NIL
                   --|-----        ---|-----         --|-----
                     |                |                |
                     |                |                |
                     2                |                6
                                      |
                                      |
                                   --------          --------
                                   |  .| . |------> |  .| . |---> NIL
                                   ---|-----         --|-----
                                      |                |
                                      |                |
                                      a                b
    
   The boxes are cons nodes, the data is contained in number or string nodes.
   Cons nodes build quite a bit of overhead into a program, but they allow
   extereme flexibility in building complicated data structures. NIL
   is a special value which indicates the pointer 0:0. It is used
   specify an empty list.

   Cons nodes consist of two pointers, one to the head (first item),
   the other to the rest of the list.

   Your function should return a pointer to any data you want to pass back
   in UserRecPtr->ReturnPtr. The function should return 0 as its result if
   it completes successfully and a numerical error code otherwise.

   You can declare as many helper functions as you need and they may return
   any type of data you desire. You may allocate global variables or you
   can allocate storage using the Windows GlobalAlloc function. Do not
   allocate large amounts of data as local variables in your functions ot
   using Windows LocalAlloc functions. Since your function will be compiled
   into a DLL, it uses KnowledgePro's stack, so keep your stack usage to
   a minimum.

   You can also allocate temporary data in KnowledgePro's memory area.
   If you expect it to exists between calls to your functions, use
   AttachValue to store it as the value of a topic. You can then use ValueOf
   to retreive it on entry to the next function call. As stated above,
   saving pointers to KnowledgePro's data will not work between calls to
   user functions.  The data may move or be eaten by the garbage
   collector between calls.

*/


#include "kpdefs.h"
#include "kputil.h"


INT FAR PASCAL Average (USER_REC_PTR UserRecPtr) ;


/* Average - computes the average of a list of numbers.

   It is called from KnowledgePro as:
      x = user (lib_handle, Average, List).

   where List is a list of numbers.

   On Entry, UserRecPtr->DataPtr points to the first cons node of the
   list. To calculate the average, we travel along the list using an
   auxiliary pointer, Ptr. The while loop first checks to see if the list
   is empty, IsNil returns TRUE if Ptr == NIL.

   If Ptr is not NIL, we retreive the first data element from the list,
   Head (Ptr) returns the head pointer of the cons node, in this case
   a pointer toi a node containing a number. NumberVal is passed a
   pointer to a node and returns its numerical value. It returns a number
   if the node contains a valid number in numerical or string form and
   returns 0 otherwise. NumberVal (Head (Ptr)) has the effect of returning
   the first number on the list. We add the number into the total.

   Ptr = Tail (Ptr) sets Ptr to point to the next cons node in the list. We
   repeat the process until Ptr is NIL, i.e. we have reached the end of
   the list.

   To return the number we allocate a numerical node in KnowledgePro's
   memorys space using AllocNum. AllocNum stores the data and retuns a
   pointer to it. We assign that pointer to UserRecPtr->ReturnPtr so that
   KnowledgePro can pick it up when the function returns. Data which
   is being returned should be allocated using the functions in KPUTIL.C.

   Finally the function returns 0 to indicate successful completion.

   This is a pretty simple minded function. It doesn't do much error
   checking. It handles the case of bieing passed an empty list properly,
   but if the incoming data is not a list or contains sublists, it will
   return an improper value.

*/

INT FAR PASCAL Average (USER_REC_PTR UserRecPtr)
{
   INT         Count = 0 ;
   NUMBERTYPE  Total = 0.0 ;
   PNODE       Ptr ;

   Ptr = UserRecPtr->DataPtr ;
   while (! IsNil (Ptr))
   {
      Total += NumberVal (Head (Ptr)) ;
      Count++ ;
      Ptr = Tail (Ptr) ;
   }

   if (Count == 0)
      UserRecPtr->ReturnPtr = AllocNum (0.0) ;
   else
      UserRecPtr->ReturnPtr = AllocNum (Total / Count) ;

   return (0) ;
}
