create procedure sp_reset(@term char(1),@year char(4),@serial_no int)
as 

/* This procedure is utillity for clear data in data base. (clear subject which not have grade) */

begin tran
	delete register
	where  regis_subj_grade = null


	delete registercard
	where  regis_year = @year and regis_term = @term and Bill_Book_No=null


	update temptable
	set term = @term 
 
	update temptable
	set year = @year

	update temptable
	set serial_no = @serial_no

	

	

commit tran