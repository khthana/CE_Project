Create Procedure sp_checkgrade(@stdid char(8),@subj char(8))
as

/* check grade for prevent student will repeat regis subject which ever studied and pass (not F) */ 

declare @grade char(1)
	select @grade = t1.regis_subj_grade
	from register t1, registercard t2 
	where t1.regis_no = t2.regis_no and
		t2.regis_std_id = @stdid and
		t1.regis_subj_id = @subj

	if not(@grade = 'F') 
		return 5