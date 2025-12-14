Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName, Signature, Std_Id
Template: toMov.htx
SQLStatement:
+
+	exec sp_deletereg '%Std_Id%','%Subj0%'
+	exec sp_deletereg '%Std_Id%','%Subj1%'
+	exec sp_deletereg '%Std_Id%','%Subj2%'
+	exec sp_deletereg '%Std_Id%','%Subj3%'
+	exec sp_deletereg '%Std_Id%','%Subj4%'
+	exec sp_deletereg '%Std_Id%','%Subj5%'
+	exec sp_deletereg '%Std_Id%','%Subj6%'
+	exec sp_deletereg '%Std_Id%','%Subj7%'
+	exec sp_deletereg '%Std_Id%','%Subj8%'
+	exec sp_deletereg '%Std_Id%','%Subj9%'
+
+	Select	t1.Regis_Subj_Id, t2.Subj_Name_Eng, t2.Credit_Lec, t2.Credit_Lab,t4.regis_no
+	from	Register t1, Subject t2, Student t3, RegisterCard t4,TempTable t5
+	where	t4.Regis_Std_Id='%Std_Id%' and
+		t4.Regis_std_id=t3.std_id and
+		t4.Regis_No=t1.Regis_No and
+		t1.Regis_Subj_Id=t2.Subj_Id and
+		t4.regis_year = t5.year and
+		t4.regis_term = t5.term 
