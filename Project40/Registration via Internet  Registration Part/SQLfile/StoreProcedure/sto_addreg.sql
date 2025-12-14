create procedure sp_addreg(@stdid char(8),@subj char(8))
as

/* Procedure for Add Subject */ 

	declare @sts int	/* status variable */
   	
if (@subj = "")
	return 6	/* when users not input Subject Id */ 
else if not exists( 	
	select * 
	from 	student t1,subject_for_register t2,temptable t3
	where 	t1.std_id = @stdid and
		t2.term = t3.term and
  		t2.subj_id = @subj and
		t1.faculty_id = t2.faculty_id 	)
	return 5	/* when Subject Id is not subject in faculty */
else begin
	exec @sts = sp_checksubjyear @stdid,@subj
	if (@sts = 5)
		return 5
	/* when student in lower class will to regis subject of highler class */
	else
	begin
	   exec @sts = sp_checkgrade @stdid,@subj
	   if (@sts = 5)
		return 5	/* when grade not equal "F" */	 
	else
	begin		
		exec @sts = sp_prerequisite @stdid,@subj	/* prerequisite pass? */
		if not(@sts = 9)
		begin
		begin tran
			declare @year char(8)
			declare @term char(1)
			declare @faculty char(2)
			declare @yearenter char(4)
			declare @regis_no int
			declare @fee_type2 int
			declare @cost int
			select @year=year, @term=term
    			from temptable
			select @faculty=t2.faculty_id, @yearenter=t2.std_year_enter, @regis_no=t3.regis_no
			from student t2,registercard t3
			where  t2.std_id = t3.regis_std_id and
				t2.std_id = @stdid and 
				t3.regis_year = @year and t3.regis_term = @term
		
			insert into register(regis_no,regis_subj_id,regis_status)
			values(@regis_no,@subj,'p')

	/* calculate cost */
			select @fee_Type2 = fee_type2
			from registercard
			where regis_no = @regis_no and 
			regis_year = @year and regis_term = @term
		
			select @cost = fee_cost
			from feecost
			where   fee_type_no = 2 and
				fee_year = @year and
				fee_term = @term and
				std_faculty_id = @faculty and
				std_year_enter1 = @yearenter

				update registercard
				set fee_type2 =
				( select @fee_type2 + ((credit_lec + credit_lab) * @cost) 
	  			from subject 
	  			where subj_id = @subj )
				where regis_no = @regis_no and 
					regis_year = @year and regis_term = @term
			
			commit tran
			return 7	/* add subject finish */
		end else 
			return 9	/* prerequisite error */
	    end 			   
	    end		      		
	end