#include <rpc/types.h>

#define DATAUSR "customer.dat"
#define DATABL "balance.dat"
#define TEMP "temp.dat"
#define TEMP_DS "temp_des.dat"

struct usrinfo {
	char *ID_account;
	char *Password;
};
typedef struct usrinfo usrinfo;
bool_t xdr_usrinfo();

struct balance {
	char *ID_account;
	char *Firstname;
	char *Lastname;
	char *Balance;
};
typedef struct balance balance;
bool_t xdr_balance();

struct balance_type {
	char *Balance;
	char *ID_account;
	char *Date_Time;
	int Flag;
};
typedef struct balance_type balance_type;
bool_t xdr_balance_type();

struct withdraw_moneytype {
	char *ID_account;
	char *Amount_money;
};
typedef struct withdraw_moneytype withdraw_moneytype;
bool_t xdr_withdraw_moneytype();

struct transfer_moneytype {
	char *ID_account;
	char *Destination_id;
	char *Num_trans;
};
typedef struct transfer_moneytype transfer_moneytype;
bool_t xdr_transfer_moneytype();

struct transfer_type {
	char *ID_account;
	char *Destination_id;
	char *Num_trans;
	char *Balance;
	char *Firstname_des;
	char *Lastname_des;
	char *Date_Time;
	int Flag_dest_id;
	int Flag;
};
typedef struct transfer_type transfer_type;
bool_t xdr_transfer_type();

struct transfer_resulttype {
	int errno;
	union {
		transfer_type transfer;
	} transfer_resulttype_u;
};
typedef struct transfer_resulttype transfer_resulttype;
bool_t xdr_transfer_resulttype();

struct balance_resulttype {
	int errno;
	union {
		balance_type balances;
	} balance_resulttype_u;
};
typedef struct balance_resulttype balance_resulttype;
bool_t xdr_balance_resulttype();

#define ATMPROG ((u_long)123456788)
#define ATMVERS ((u_long)1)
#define VALIDATE ((u_long)1)
extern usrinfo *validate_1();
#define CHECK_BALANCE ((u_long)2)
extern balance_resulttype *check_balance_1();
#define WITHDRAW ((u_long)3)
extern balance_resulttype *withdraw_1();
#define TRANSFER ((u_long)4)
extern transfer_resulttype *transfer_1();
