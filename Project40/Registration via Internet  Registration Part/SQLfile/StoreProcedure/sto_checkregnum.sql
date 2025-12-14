create procedure sp_checkregisnum(@stdid char(8))
as 
	declare @year char(4)
	declare @term char(1)
 		select @year = year,@term = term
		from temptable
if not exists(select regis_std_id from registercard where regis_std_id = @stdid 
		and regis_year = @year and  regis_term = @term )
        return 8
else 
	return 7