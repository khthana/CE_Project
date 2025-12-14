create procedure sp_calcost(@stdid char(8))
as

/* calculate cost transaction */
begin tran
	declare @year char(8)
	declare @term char(1)
	declare @faculty char(2)
	declare @yearenter char(4)
	declare @std_entype char(2)
	declare @regis_no int
	declare @cost int

/* query value from table for keep in variable */
select @year=year, @term=term
from temptable

select  @faculty=t1.faculty_id,@yearenter=t1.std_year_enter, @regis_no=t2.regis_no,
	@std_entype=t1.std_entype
from student t1,registercard t2
where  t1.std_id = t2.regis_std_id and
	t1.std_id = @stdid and 
        t2.regis_year = @year and 
	t2.regis_term = @term
	

/* calculate 12 type of cost and keep into database */ 

update registercard
set fee_type1 =
	( select fee_cost 
  	  from feecost
	  where fee_type_no = 1 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

select @cost = fee_cost
from feecost
where   fee_type_no = 2 and
	fee_year = @year and
	fee_term = @term and
	std_faculty_id = @faculty and
	std_type_no = @std_entype and
	std_year_enter1 = @yearenter

update registercard
set fee_type2 =
	( select (sum(t1.credit_lec) + sum(t1.credit_lab))*@cost 
	  from subject t1,register t2
	  where t1.subj_id = t2.regis_subj_id and
 		t2.regis_no = @regis_no and
		t2.regis_status = 'p'
	  group by t2.regis_no )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type3 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 3 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type4 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 4 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type5 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 5 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type6 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 6 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type7 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 7 and
		fee_year = @year and
		fee_term = @term and		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type8 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 8 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type9 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 9 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type10 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 10 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term


update registercard
set fee_type11 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 11 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

update registercard
set fee_type12 =
	( select fee_cost 
	  from feecost
	  where fee_type_no = 12 and
		fee_year = @year and
		fee_term = @term and
		std_faculty_id = @faculty and
		std_type_no = @std_entype and
		std_year_enter1 = @yearenter )
where regis_no = @regis_no and regis_year = @year and regis_term = @term

commit tran