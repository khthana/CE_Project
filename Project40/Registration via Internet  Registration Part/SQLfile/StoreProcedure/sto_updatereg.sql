create procedure sp_updatereg(@stdid char(8),@old_subj_id char(8),@new_subj_id char(8))
as

/* Procedure for Change Subject */

	declare @sts int
	declare @reg_no int
if not exists( 	
	select * 
	from 	student t1,subject_for_register t2,temptable t3
	where 	t1.std_id = @stdid and
		t2.term = t3.term and
  		t2.subj_id = @new_subj_id and
		t1.faculty_id = t2.faculty_id 	)
		return 5	/* when Subject Id is not subject in faculty */
else if not exists(
	select subj_id
	from subject
	where subj_id = @old_subj_id and (credit_lec + credit_lab) = 
	(select (credit_lec + credit_lab)	 from subject
	 where subj_id = @new_subj_id )  )
		return 5	/* when not equal credit */ 
else if exists(
	/* check for prevent change to same subject but different curriculum */ 
	select subj_id
	from subject
	where subj_id = @old_subj_id and subj_name_eng = 
	(select subj_name_eng
	 from subject
	 where subj_id = @new_subj_id )  )	
		return 5		
else begin
     exec @sts = sp_checksubjyear @stdid,@new_subj_id
	if (@sts = 5)
		return 5	/* when student in lower class will to regis subject of highler class */
	else
	begin
	   exec @sts = sp_checkgrade @stdid,@new_subj_id
	   if (@sts = 5)
		return 5	/* when grade not equal "F" */	  
	else
	begin		
	    exec @sts = sp_prerequisite @stdid,@new_subj_id
		if not(@sts = 9)	/* prerequisite pass? */
		begin
		begin tran
			select @reg_no = regis_no
			from registercard t1, temptable t2 
			where t1.regis_std_id = @stdid  and
				t1.regis_year = t2.year and
				t1.regis_term = t2.term
			update register
			set regis_subj_id = @new_subj_id                              
			where 	regis_no = @reg_no and				regis_subj_id = @old_subj_id

		commit tran
		end	else
			return 9	/* prerequisite error */
	end
	end
      end