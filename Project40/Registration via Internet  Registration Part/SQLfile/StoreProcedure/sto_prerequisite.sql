Create Procedure sp_prerequisite(@stdid char(8),@subj char(8))
as

/* procedure for check prerequisite pass? */

declare @presubj_id char(8)
declare @grade char(1)

if exists( select presubj_id from prerequisite where subj_id = @subj)
begin
	select @presubj_id = presubj_id from prerequisite where subj_id = @subj
	
	select @grade = t1.regis_subj_grade
	from register t1, registercard t2 
	where t1.regis_no = t2.regis_no and
		t1.regis_subj_id = @presubj_id and
		t2.regis_std_id = @stdid

	if @grade in ( null,'F') 
		return 9
	
end