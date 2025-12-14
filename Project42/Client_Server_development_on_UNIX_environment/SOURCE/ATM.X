%#define DATAUSR "customer.dat"
%#define DATABL "balance.dat"
%#define TEMP "temp.dat"
%#define TEMP_DS "temp_des.dat"

struct usrinfo{
	string ID_account<15>;
	string Password<5>;
	};

struct balance{
	string ID_account<15>;
	string Firstname<20>;
	string Lastname<30>;
	string Balance<15>;
	};

struct balance_type{
	string  Balance<15>;
	string  ID_account<15>;
	string  Date_Time<>;
	int     Flag;
	};

struct withdraw_moneytype{
	string ID_account<15>;
	string Amount_money<15>;
	};

struct transfer_moneytype{
	string ID_account<15>;
	string Destination_id<15>;
	string Num_trans<15>;
	};

struct transfer_type{
	string ID_account<15>;
	string Destination_id<15>;
	string Num_trans<15>;
	string Balance<15>;
	string Firstname_des<20>;
	string Lastname_des<30>;
	string Date_Time<>;
	int    Flag_dest_id;
	int    Flag;	
	
	};

union transfer_resulttype switch(int errno){
      case 0:
	  transfer_type transfer;
	default:
	   void;
	   };                 

union balance_resulttype switch(int errno){
      case 0:
	  balance_type balances;
	default:
	   void;
	   };                 

program ATMPROG {
	version ATMVERS {
		usrinfo VALIDATE(usrinfo)=1;
		balance_resulttype CHECK_BALANCE(string) = 2;
		balance_resulttype WITHDRAW(withdraw_moneytype) = 3;
		transfer_resulttype TRANSFER(transfer_moneytype) = 4;
		}=1;
	}=123456788;


