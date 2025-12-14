Datasource: proj97
Template: thing1.htx

SQLStatement: 
+ declare @a1 char(20), @a2 char(7), @a3 int, @a4 char(7), @a5 int
+ select @a1 = '%T1%', @a2 = '%T2%', @a3 = %T3%, @a4 = '%T4%', @a5 =  %T5%
+ insert into room
+ (RoomCode,Building,RoomFloorNo,RoomType,RoomCapacity)
+ values (@a1,@a2,@a3,@a4,@a5 )

+ select * from  room

Username: sa

