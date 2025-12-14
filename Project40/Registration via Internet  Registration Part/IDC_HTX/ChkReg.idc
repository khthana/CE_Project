Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName, Passwd
Template: ChkReg.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin  '%LoginName%','%Passwd%'
+if (@found = 7)
+begin
+	Select msg_true = 'true'
+end
+else
+begin
+	Select msg_false from temptable
+end