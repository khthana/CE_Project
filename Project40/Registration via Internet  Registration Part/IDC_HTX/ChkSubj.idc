Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: yLoginName, ySignature, yStd_Id
Template: ChkSubj.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin '%yLoginName%','%ySignature%'
+if (@found = 7)
+begin
+	Select	t1.Regis_Subj_Id, t2.Subj_Name_Eng, t2.Credit_Lec, t2.Credit_Lab,t4.regis_no,
+		t5.term, t5.year, t4.Regis_Date
+	from	Register t1, Subject t2, Student t3, RegisterCard t4, temptable t5
+	where	t4.Regis_Std_Id='%ystd_id%' and
+		t4.Regis_std_id=t3.std_id and
+		t4.Regis_No=t1.Regis_No and
+		t1.Regis_Subj_Id=t2.Subj_Id and
+		t4.regis_year = t5.year and
+		t4.regis_term = t5.term 
+end else
+		select msg_false = 'false'
