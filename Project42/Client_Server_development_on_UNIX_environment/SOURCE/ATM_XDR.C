#include <rpc/rpc.h>
#include "atm.h"
#define DATAUSR "customer.dat"
#define DATABL "balance.dat"
#define TEMP "temp.dat"
#define TEMP_DS "temp_des.dat"

bool_t
xdr_usrinfo(xdrs, objp)
	XDR *xdrs;
	usrinfo *objp;
{
	if (!xdr_string(xdrs, &objp->ID_account, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Password, 5)) {
		return (FALSE);
	}
	return (TRUE);
}

bool_t
xdr_balance(xdrs, objp)
	XDR *xdrs;
	balance *objp;
{
	if (!xdr_string(xdrs, &objp->ID_account, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Firstname, 20)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Lastname, 30)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Balance, 15)) {
		return (FALSE);
	}
	return (TRUE);
}

bool_t
xdr_balance_type(xdrs, objp)
	XDR *xdrs;
	balance_type *objp;
{
	if (!xdr_string(xdrs, &objp->Balance, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->ID_account, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Date_Time, ~0)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->Flag)) {
		return (FALSE);
	}
	return (TRUE);
}

bool_t
xdr_withdraw_moneytype(xdrs, objp)
	XDR *xdrs;
	withdraw_moneytype *objp;
{
	if (!xdr_string(xdrs, &objp->ID_account, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Amount_money, 15)) {
		return (FALSE);
	}
	return (TRUE);
}

bool_t
xdr_transfer_moneytype(xdrs, objp)
	XDR *xdrs;
	transfer_moneytype *objp;
{
	if (!xdr_string(xdrs, &objp->ID_account, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Destination_id, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Num_trans, 15)) {
		return (FALSE);
	}
	return (TRUE);
}

bool_t
xdr_transfer_type(xdrs, objp)
	XDR *xdrs;
	transfer_type *objp;
{
	if (!xdr_string(xdrs, &objp->ID_account, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Destination_id, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Num_trans, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Balance, 15)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Firstname_des, 20)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Lastname_des, 30)) {
		return (FALSE);
	}
	if (!xdr_string(xdrs, &objp->Date_Time, ~0)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->Flag_dest_id)) {
		return (FALSE);
	}
	if (!xdr_int(xdrs, &objp->Flag)) {
		return (FALSE);
	}
	return (TRUE);
}

bool_t
xdr_transfer_resulttype(xdrs, objp)
	XDR *xdrs;
	transfer_resulttype *objp;
{
	if (!xdr_int(xdrs, &objp->errno)) {
		return (FALSE);
	}
	switch (objp->errno) {
	case 0:
		if (!xdr_transfer_type(xdrs, &objp->transfer_resulttype_u.transfer)) {
			return (FALSE);
		}
		break;
	}
	return (TRUE);
}

bool_t
xdr_balance_resulttype(xdrs, objp)
	XDR *xdrs;
	balance_resulttype *objp;
{
	if (!xdr_int(xdrs, &objp->errno)) {
		return (FALSE);
	}
	switch (objp->errno) {
	case 0:
		if (!xdr_balance_type(xdrs, &objp->balance_resulttype_u.balances)) {
			return (FALSE);
		}
		break;
	}
	return (TRUE);
}
