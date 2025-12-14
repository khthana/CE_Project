Datasource: Proj97
Template: funct1.htx
SQLStatement:
+SELECT  Room_Code,Room_Floor_No,Room_Type,Room_Capacity,Building_Code,Building_Name,Building_Place
+from Room T1,Building T2
+where T1.Building = T2.Building_Code  and  Room_Code like '%RoomCode%%'
Username: webusr

