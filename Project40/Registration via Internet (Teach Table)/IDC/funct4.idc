Datasource: Proj97
Template: funct4.htx
SQLStatement:
+DELETE FROM UT_TAB1
+/*insert ut_tab1('datestr',p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,date_order)*/
+insert into ut_tab1
+values ('MON',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','1')
+insert ut_tab1
+values ('TUE',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','2')
+insert ut_tab1
+values ('WED',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','3')
+insert ut_tab1
+values ('THU',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','4')
+insert ut_tab1
+values ('FRI',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','5')
+insert ut_tab1
+values ('SAT',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','6')

+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P1=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p01'
+ and ut_classw.std_id='%stdid%'
+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P2=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p02'
+ and ut_classw.std_id='%stdid%'

+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P3=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p03'
+ and ut_classw.std_id='%stdid%'

+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P4=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p04'
+ and ut_classw.std_id='%stdid%'

+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P5=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p05'
+ and ut_classw.std_id='%stdid%'

+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P6=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p06'
+ and ut_classw.std_id='%stdid%'
+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P7=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p07'
+ and ut_classw.std_id='%stdid%'

+/*------------------------------------*/
+UPDATE UT_TAB1
+SET P8=ut_classw.subj_id
+FROM UT_CLASSw, UT_TAB1 
+WHERE rtrim(UT_CLASSw.CLASS_DT)=rtrim(UT_TAB1.DATESTR)  AND ut_classw.class_period='p08'
+ and ut_classw.std_id='%stdid%'


+/*------------------------------------*/
+SELECT  std_Name_eng,std_sname_eng from student
+where student.std_id='%stdid%'

+SELECT  * from ut_tab1
+order by date_order

Username: sa

