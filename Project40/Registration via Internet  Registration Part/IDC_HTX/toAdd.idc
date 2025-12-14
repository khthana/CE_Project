Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName, Signature, Std_Id
Template: toAdd.htx
SQLStatement:
+ declare @sts1 int
+ declare @sts2 int
+ declare @sts3 int
+ declare @sts4 int
+ declare @sts5 int 
+	
+	exec sp_getregisnum '%Std_Id%'
+
+	exec @sts1 = sp_addreg '%Std_Id%', '%Subj1%'
+	exec @sts2 = sp_addreg '%Std_Id%', '%Subj2%'
+	exec @sts3 = sp_addreg '%Std_Id%', '%Subj3%'
+	exec @sts4 = sp_addreg '%Std_Id%', '%Subj4%'
+	exec @sts5 = sp_addreg '%Std_Id%', '%Subj5%'

+	if (@sts1 = 6 and @sts2 = 6 and @sts3 = 6 and @sts4 = 6 and @sts5 = 6) 
+		select msg_none = 'none'
+	else	if ((@sts1 = 9 or @sts2 = 9 or @sts3 = 9 or @sts4 = 9 or @sts5 = 9) and
+			(@sts1 = 5 or @sts2 = 5 or @sts3 = 5 or @sts4 = 5 or @sts5 = 5))
+			select msg_pre = 'notpre', msg_false = 'false'
+		else	if (@sts1 = 9 or @sts2 = 9 or @sts3 = 9 or @sts4 = 9 or @sts5 = 9)
+				select msg_pre = 'notpre'
+			else 	if (@sts1 = 5 or @sts2 = 5 or @sts3 = 5 or @sts4 = 5 or @sts5 = 5)
+					select msg_false = 'false'
+				else	select msg_true ='true'
+
+
SQLStatement:
+	Select	t1.Regis_Subj_Id, t2.Subj_Name_Eng, t2.Credit_Lec, t2.Credit_Lab,t4.regis_no
+	from	Register t1, Subject t2, Student t3, RegisterCard t4,TempTable t5
+	where	t4.Regis_Std_Id='%Std_Id%' and
+		t4.Regis_std_id=t3.std_id and
+		t4.Regis_No=t1.Regis_No and
+		t1.Regis_Subj_Id=t2.Subj_Id and
+		t4.regis_year = t5.year and
+		t4.regis_term = t5.term 
SQLStatement:
+	Select	t11.Fee_Type_Name, t12.Fee_Type1, t12.Fee_Type2, t12.Fee_Type3,
+		t12.Fee_Type4, t12.Fee_Type5, t12.Fee_Type6, t12.Fee_Type7,
+		t12.Fee_Type8, t12.Fee_Type9, t12.Fee_Type10, t12.Fee_Type11, t12.Fee_Type12,
+		t13.term, t13.year
+	from	FeeType t11, RegisterCard t12, temptable t13
+	where 	t12.regis_std_id = '%Std_Id%' and
+		t12.regis_year = t13.year and
+		t12.regis_term = t13.term 
+		