Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName, Signature, Std_Id
Template: Registry.htx
SQLStatement:
+ declare @sts0 int
+ declare @sts1 int
+ declare @sts2 int
+ declare @sts3 int
+ declare @sts4 int
+ declare @sts5 int
+ declare @sts6 int
+ declare @sts7 int
+ declare @sts8 int
+ declare @sts9 int
+		exec sp_getregisnum '%std_id%'
+
+		exec @sts0 = sp_insertreg '%Std_Id%','%Subj_0%'
+		exec @sts1 = sp_insertreg '%Std_Id%','%Subj_1%'
+		exec @sts2 = sp_insertreg '%Std_Id%','%Subj_2%'
+		exec @sts3 = sp_insertreg '%Std_Id%','%Subj_3%'
+		exec @sts4 = sp_insertreg '%Std_Id%','%Subj_4%'
+		exec @sts5 = sp_insertreg '%Std_Id%','%Subj_5%'
+		exec @sts6 = sp_insertreg '%Std_Id%','%Subj_6%'
+		exec @sts7 = sp_insertreg '%Std_Id%','%Subj_7%'
+		exec @sts8 = sp_insertreg '%Std_Id%','%Subj_8%'
+		exec @sts9 = sp_insertreg '%Std_Id%','%Subj_9%'
+
+	if (@sts0 = 9 or @sts1 = 9 or @sts2 = 9 or @sts3 = 9 or @sts4 = 9 or @sts5 = 9
+	   or @sts6 = 9 or @sts7 = 9 or @sts8 = 9 or @sts9 = 9 )
+		select msg_pre = 'notpre'
+	else select msg_true = 'true'
+
+	exec sp_calcost '%Std_Id%'
+
SQLStatement:
+	Select	t1.Regis_Subj_Id, t2.Subj_Name_Eng, t2.Credit_Lec, t2.Credit_Lab,t4.regis_no,
+		t4.Regis_Date, t5.term, t5.year
+	from	Register t1, Subject t2, Student t3, RegisterCard t4,TempTable t5
+	where	t4.Regis_Std_Id='%Std_Id%' and
+		t4.Regis_std_id=t3.std_id and
+		t4.Regis_No=t1.Regis_No and
+		t1.Regis_Subj_Id=t2.Subj_Id and
+		t4.regis_year = t5.year and
+		t4.regis_term = t5.term 
+
SQLStatement:
+	Select	t1.Fee_Type_Name, t2.Fee_Type1, t2.Fee_Type2, t2.Fee_Type3,
+		t2.Fee_Type4, t2.Fee_Type5, t2.Fee_Type6, t2.Fee_Type7,
+		t2.Fee_Type8, t2.Fee_Type9, t2.Fee_Type10, t2.Fee_Type11, t2.Fee_Type12
+	from	FeeType t1, RegisterCard t2,TempTable t3
+	where 	t2.regis_std_id = '%Std_Id%'  and
+		t2.regis_year = t3.year and
+		t2.regis_term = t3.term 