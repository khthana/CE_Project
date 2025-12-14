/* kputil.h - Header for User functions */

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


extern INT FAR PASCAL Dispatch (USER_REC_PTR UserRecPtr) ;
extern PNODE AllocMemory (USHORT wBytes) ;
extern PNODE AllocNum (NUMBERTYPE Num) ;
extern PNODE AllocStr (PSZ Str) ;
extern USHORT NodeSize (INT NodeType) ;
extern PNODE Cons (PNODE HeadItem, PNODE TailItem) ;
extern VOID AttachList (PPNODE List1, PNODE List2) ;
extern PNODE AppendLists (PNODE List1, PNODE List2) ;
extern PNODE Head (PNODE List) ;
extern PNODE Tail (PNODE List) ;
extern PNODE Element (PNODE List, USHORT Num) ;
extern PSZ StringVal (PNODE NodePtr) ;
extern NUMBERTYPE NumberVal (PNODE NodePtr) ;
extern NUMBERTYPE StrToNum (PSZ Str) ;
extern VOID NumToStr (PSZ NumStr, NUMBERTYPE Num) ;
extern BYTE NodeType (PNODE NodePtr) ;
extern VOID AttachValue (PNODE TopicList, PNODE Params, BOOL RemoveOldValue) ;
extern PNODE ValueOf (PNODE TopicList, PNODE Params) ;


