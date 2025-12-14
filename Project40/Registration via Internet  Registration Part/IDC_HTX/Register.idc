Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName, Passwd, Std_Id
Template: Register.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin '%LoginName%','%Passwd%'
+if (@found = 7)
+begin
+ 	declare @sts int
+	exec @sts = sp_checkregisnum '%std_id%'
+	if not (@sts = 7) 
+	begin
+	select	t1.std_id, t1.std_name_Eng, t1.std_Sname_Eng, t1.yearStudy,
+		t2.subj_id, t2.subj_name_eng, t2.credit_lec, t2.credit_lab,
+		t4.term, t4.year, t5.faculty_name, t6.dept_name,
+		t2.subj_type
+	from	student t1, subject t2, subject_for_register t3,
+		temptable t4, faculty t5, department t6
+	where 	t1.Std_Id='%Std_Id%' and
+		t1.dept_id=t6.dept_id and
+		t1.faculty_id = t3.faculty_id and
+		t3.faculty_id= t5.faculty_id and	
+		t1.curiculum_id = t3.curiculum_id and
+		t1.yearstudy = t3.yearstudy and
+		t3.subj_id = t2.subj_id and
+		t4.term = t3.term
+	end	else	
+		select msg_false = 'false'
+end else
+		select msg_false = 'false'