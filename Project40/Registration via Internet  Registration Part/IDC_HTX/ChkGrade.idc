Datasource: Project97
Username: Operator
Password: operator
RequiredParameters: LoginName_, signature_, Std_Id_
Template: ChkGrade.htx
SQLStatement:
+declare @found int 
+exec @found= sp_checklogin '%LoginName_%','%Signature_%'
+if (@found = 7)
+begin
+ Select T1.Regis_Subj_Id,T3.Subj_Name_Eng,
+	T3.Credit_Lec,T3.Credit_Lab,T1.Regis_Subj_Grade,
+	T2.Regis_Year,T2.Regis_Term,
+	T2.Regis_Std_Id,T5.Faculty_Name, T6.Dept_Name,T4.Std_Name_Eng,
+	T4.Std_Sname_Eng
+ From Register T1,RegisterCard T2,Subject T3,Student T4,Faculty T5,Department T6
+ Where 	T2.Regis_Std_Id = '%Std_Id_%' and
+	T1.Regis_No = T2.Regis_No and
+	T1.Regis_Subj_Id = T3.Subj_Id and
+	T4.Std_Id = '%Std_Id_%' and
+	T4.Faculty_Id = T5.Faculty_Id and
+	T4.Dept_Id = T6.Dept_Id and
+	T2.Regis_Year = '%Year%' and
+	T2.Regis_Term = '%Term%' 
+
+Select GPS,GPA,Status
+From GPA  
+Where
+ 	Std_id = '%Std_Id_%' and
+	Year = '%Year%' and
+	Term = '%Term%'
+
+end else
+begin
+		select msg_false = 'false'
+end

