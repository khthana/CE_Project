Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: zLoginName, zSignature, zStd_Id
Template: ChkFee.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin '%zLoginName%','%zSignature%'
+if (@found = 7)
+begin
+	Select	t1.Fee_Type_Name, t2.Fee_Type1, t2.Fee_Type2, t2.Fee_Type3,
+		t2.Fee_Type4, t2.Fee_Type5, t2.Fee_Type6, t2.Fee_Type7,
+		t2.Fee_Type8, t2.Fee_Type9, t2.Fee_Type10, t2.Fee_Type11, t2.Fee_Type12,
+		t3.term, t3.year
+	from	FeeType t1, RegisterCard t2, temptable t3
+	where 	t2.regis_std_id = '%zStd_Id%' and
+		t2.regis_year = t3.year and
+		t2.regis_term = t3.term 
+end else
+		select msg_false ='false'
