Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName, Passwd, Std_Id
Template: ChgSubj.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin '%LoginName%','%Passwd%'
+if (@found = 7)
+begin
+	select	t1.std_id, t1.std_name_Eng, t1.std_Sname_Eng, t1.yearStudy,
+		t2.term, t2.year, t3.faculty_name, t4.dept_name,
+		t10.Regis_Subj_Id, t20.Subj_Name_Eng, t20.Credit_Lec, t20.Credit_Lab, t40.regis_no
+	from	student t1, temptable t2, faculty t3, department t4,
+		Register t10, Subject t20, Student t30, RegisterCard t40
+	where 	t1.Std_Id='%Std_Id%' and
+		t1.dept_id=t4.dept_id and
+		t1.faculty_id = t3.faculty_id and
+		t40.regis_year = t2.year and
+		t40.regis_term = t2.term and
+
+		t40.Regis_Std_Id='%Std_Id%' and
+		t40.Regis_std_id=t30.std_id and
+		t40.Regis_No=t10.Regis_No and
+		t10.Regis_Subj_Id=t20.Subj_Id
+end else
+		select msg_false = 'false'
