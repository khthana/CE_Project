Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: room, LoginName, Passwd, Std_id
Template: toShow.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin '%LoginName%','%Passwd%'
+if (@found = 7)
+begin
+ if ( '%room%' = '1P' )
+ begin
+	select	t1.subj_name_eng, t2.subj_id, t2.term, t3.year,
+		t1.credit_lec, t1.credit_lab, t4.curiculum_name_eng, t5.faculty_name
+	from	subject t1, subject_for_register t2, TempTable t3, Curiculum t4,
+		Faculty t5
+	where 	t1.subj_id = t2.subj_id and
+		t2.curiculum_id = t4.curiculum_id and
+		t2.faculty_id = t5.faculty_id and
+		t2.faculty_id = '01' and	
+		t2.curiculum_id = '19' and
+		t2.yearstudy = '1' and
+		t2.term = t3.term
+ end
+
+ if ( '%room%' = '2P' )
+ begin
+	select	t1.subj_name_eng, t2.subj_id, t2.term, t3.year,
+		t1.credit_lec, t1.credit_lab, t4.curiculum_name_eng, t5.faculty_name
+	from	subject t1, subject_for_register t2, TempTable t3, Curiculum t4,
+		Faculty t5
+	where 	t1.subj_id = t2.subj_id and
+		t2.curiculum_id = t4.curiculum_id and
+		t2.faculty_id = t5.faculty_id and
+		t2.faculty_id = '01' and	
+		t2.curiculum_id = '19' and
+		t2.yearstudy = '2' and
+		t2.term = t3.term
+ end
+
+ if ( '%room%' = '3P' )
+ begin
+	select	t1.subj_name_eng, t2.subj_id, t2.term, t3.year,
+		t1.credit_lec, t1.credit_lab, t4.curiculum_name_eng, t5.faculty_name
+	from	subject t1, subject_for_register t2, TempTable t3, Curiculum t4,
+		Faculty t5
+	where 	t1.subj_id = t2.subj_id and
+		t2.curiculum_id = t4.curiculum_id and
+		t2.faculty_id = t5.faculty_id and
+		t2.faculty_id = '01' and	
+		t2.curiculum_id = '19' and
+		t2.yearstudy = '3' and
+		t2.term = t3.term
+ end
+
+ if ( '%room%' = '3D' )
+ begin
+	select	t1.subj_name_eng, t2.subj_id, t2.term, t3.year,
+		t1.credit_lec, t1.credit_lab, t4.curiculum_name_eng, t5.faculty_name
+	from	subject t1, subject_for_register t2, TempTable t3, Curiculum t4,
+		Faculty t5
+	where 	t1.subj_id = t2.subj_id and
+		t2.curiculum_id = t4.curiculum_id and
+		t2.faculty_id = t5.faculty_id and
+		t2.faculty_id = '01' and	
+		t2.curiculum_id = '07' and
+		t2.yearstudy = '3' and
+		t2.term = t3.term
+ end
+
+ if ( '%room%' = '4D' )
+ begin
+	select	t1.subj_name_eng, t2.subj_id, t2.term, t3.year,
+		t1.credit_lec, t1.credit_lab, t4.curiculum_name_eng, t5.faculty_name
+	from	subject t1, subject_for_register t2, TempTable t3, Curiculum t4,
+		Faculty t5
+	where 	t1.subj_id = t2.subj_id and
+		t2.curiculum_id = t4.curiculum_id and
+		t2.faculty_id = t5.faculty_id and
+		t2.faculty_id = '01' and	
+		t2.curiculum_id = '07' and
+		t2.yearstudy = '4' and
+		t2.term = t3.term
+ end
+end
