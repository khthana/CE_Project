create procedure sp_deletereg(@stdid char(8),@subj char(8))
as
begin tran

/* Procedure for delete subject */

	declare @reg_no int
		select @reg_no = regis_no
			from registercard t1, temptable t2 
			where t1.regis_std_id = @stdid  and
				t1.regis_year = t2.year and
				t1.regis_term = t2.term
		
		if (@subj not like 'x%') 	
		begin
			delete register
			where regis_subj_id = @subj and regis_no = @reg_no
		end
commit tran