Datasource: Proj97
Template: funct2.htx
SQLStatement: 
+select  t1.Room_Code,Room_Type,Room_Capacity,Room_Floor_No,Building_Code,Building_Name,Building_Place,
+        t3.room_code,t3.Subj_Id,Class_Day,Class_Time_Begin,Class_Time_End,Class_Max_Std,       
+        t4.Subj_Id,Subj_Name_Eng,t4.Credit_Lec,t4.Credit_Lab,
+        t5.Teacher_Id,t5.Subj_Id,t5.Academic_Year,t5.Academic_Term,
+        t6.Teacher_Id,t6.Teacher_Name_Thai,t6.Teacher_Sname_Thai      
+from    Room t1,Building t2, Class t3,Subject t4,TeacherClass t5,TeacherInfo t6 
+where  t1.Building = t2.Building_Code and t3.room_code = t1.room_code and t3.Subj_Id = t4.Subj_Id
+       and t5.Subj_Id = t4.Subj_Id and t5.Teacher_Id = t6.Teacher_Id and t3.Subj_Id = '%Subj_Id%'
Username: webusr
