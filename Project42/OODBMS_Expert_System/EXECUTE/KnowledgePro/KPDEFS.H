/* kpdefs.h - Windows Version */

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
   Constants and definitions for KPUTIL.C and User defined functions
*/

#include <windows.h>


#define CONSNODE         1
#define CONSTANT         2
#define FUNCTION         3
#define NUMBER           4
#define NILNODE          255

#define FAR              far
#define CHAR             char
#define INT              int
#define VOID             void
#define SHORT            int
#define LONG             long

typedef unsigned char  UCHAR ; 
typedef unsigned int   USHORT ;
typedef unsigned long  ULONG ; 
typedef unsigned int   UINT ;  
typedef char far       *PSZ ;
typedef unsigned char  BYTE ;
typedef USHORT far     *LPUSHORT ;
typedef VOID FAR       *PVOID ;
typedef long FAR       *LPLONG ;

typedef double  NUMBERTYPE ;

/* The definition of the Node. Nodes are KnowledgePro's basic structural
   type. There are other node types, but they are not available to
   user functions. Each node consists of a flag byte indicating its type,
   followed by the data.
*/

typedef struct node
{
   BYTE     Flags ;
   union
      {
      struct
         {
         struct node FAR   *HeadPtr ;
         struct node FAR   *TailPtr ;
         } _cons ;
      CHAR        StringData ;
      NUMBERTYPE  NumData ;
      } _variant ;
} NODE ;

typedef NODE FAR *PNODE ;    /* A PNODE, used in most functions is a FAR
                                pointer to a node. */

typedef PNODE FAR *PPNODE ;  /* A PPNODE, is a FAR pointer to a node. pointer */

typedef BOOL  FAR *PBOOL ;


/* Some defines that may be useful to you. */

#define NIL  0L

#define MAKEULONG(l, h)  ((ULONG)(((USHORT)(l)) | ((ULONG)((USHORT)(h))) << 16))

#define MAKEP(seg, off)  ((PVOID)MAKEULONG(off, seg))

#define IsNil(p) ((p) == 0L)

#define SEG(p)       (((LPUSHORT)&(p))[1])
#define OFF(p)       (((LPUSHORT)&(p))[0])

#define ULONGFROMP(p)  ((ULONG)(((ULONG)((ULONG)SEG(p) << 4)) + OFF(p)))

#define CopyList(p)  (AppendList ((p), NIL))

