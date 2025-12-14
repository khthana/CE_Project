create procedure sp_checksubjyear(@stdid char(8),@subj char(8))
as

/* check for prevent when student in lower class will to regis subject of highler class */

declare @c1 char(2)
declare @c2 char(2)
declare @y1 char(1)
declare @y2 char(1)

select @c1=curiculum_id, @y1=yearstudy
from student
where std_id= @stdid

select @c2=curiculum_id, @y2=yearstudy
from subject_for_register
where subj_id= @subj


/* check register of Computer Engineering Department */
/* check between Computer Engineering and Computer Engineering (Continue) */
if (@c1='07' and @c2='19') 
	if (@y2='3' and @y1 in ('1','2','3')) 
		return 5
	else if (@y2='2' and @y1 in ('1','2'))
		      return 5
	     else if (@y2='1' and @y1 = '1')
			return 5
		  else return 7	

if (@c1='19' and @c2='07')
	if (@y2='4' and @y1 in ('1','2')) 
		return 5
	else if (@y2='3' and @y1 = '1')
		      return 5
	     else return 7	


/* check between Computer Engineering (highler class) and Computer Engineering (lower class) */
if (@c1='07' and @c2='07')
	if (@y2='4' and @y1 in ('1','2','3')) 
		return 5
	else if (@y2='3' and @y1 in ('1','2'))
		      return 5
	     else if (@y2='2' and @y1 = '1')
			print 'connot'
		else return 7	
	
		
/* check between Computer Engineering (Continue:highler class) and Computer Engineering (Continue lower class) */
if (@c1='19' and @c2='19')
	if (@y2='3' and @y1 in ('1','2')) 
		return 5
	else if(@y2='2' and @y1 = '1')
		      return 5
	     else return 7