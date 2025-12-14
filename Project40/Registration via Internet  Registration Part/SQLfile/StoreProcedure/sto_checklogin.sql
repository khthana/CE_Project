Create Procedure sp_checklogin(@name char(8),@password char(8))
as

/* check user login and password */

if exists(select name
		from master.dbo.syslogins
			where  name = @name and pwdcompare(@password,password) = 1)
        return 7
else 
	return 8