Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: Std_Id
Template: toChg.htx
SQLStatement:
+ declare @sts int
+	 exec @sts = sp_updatereg '%std_id%','%old_subj%','%new_subj%'
+	if (@sts = 5) 
+		select msg_false = 'false'
+	else	if (@sts=9)
+			select msg_pre = 'notpre'
+		else	select msg_true = 'true'
+Select	t1.Regis_Subj_Id, t2.Subj_Name_Eng, t2.Credit_Lec, t2.Credit_Lab,t4.regis_no
+	from	Register t1, Subject t2, Student t3, RegisterCard t4,TempTable t5
+	where	t4.Regis_Std_Id='%Std_Id%' and
+		t4.Regis_std_id=t3.std_id and
+		t4.Regis_No=t1.Regis_No and
+		t1.Regis_Subj_Id=t2.Subj_Id and
+		t4.regis_year = t5.year and
+		t4.regis_term = t5.term 

