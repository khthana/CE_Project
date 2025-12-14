create procedure sp_insertreg(@stdid char(8),@subj char(8))
as	
	declare @sts int
if (@subj like 'x%')	/* if subject start with X. it's mean user not want to study this subject. */
			/* and not mark in check box */
	return 6
else 
begin
   	exec @sts = sp_prerequisite @stdid,@subj	/* prerequisite pass? */
if not(@sts = 9)
begin
begin tran
	declare @year char(4)
	declare @term char(1)
 		select @year = year,@term = term
		from temptable
	

	declare @reg_no int
		select @reg_no = regis_no
		from registercard
		where regis_std_id = @stdid and 
			regis_year = @year and regis_term = @term
		
		if (@subj not like 'x%')	
		begin
			insert into register(regis_no,regis_subj_id,regis_status)
			values(@reg_no,@subj,'p')
		end
commit tran
end else
	return 9
end