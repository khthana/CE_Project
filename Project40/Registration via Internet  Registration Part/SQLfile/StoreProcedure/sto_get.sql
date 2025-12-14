create procedure sp_getregisnum(@stdid char(8))
as 

/* This Procedure is used in initail register. it will get serail number from Temptable */

	declare @year char(4)
	declare @term char(1)
 		select @year = year,@term = term
		from temptable
if not exists(select regis_std_id from registercard where regis_std_id = @stdid 
		and regis_year = @year and regis_term = @term )
begin
begin tran 
	

	declare @x int
	select @x = (select serial_no from temptable) /* get serial number */
	select @x = @x + 1  /* increase serial number */

	update temptable
	set serial_no = @x

	insert into registercard(regis_no,regis_std_id,regis_year,
			regis_term,regis_date)
	select serial_no,@stdid,year,term,getdate()
	from temptable
commit tran
end else 
	return 7