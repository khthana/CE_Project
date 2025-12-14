<?php
class frame_category_item
{
function print_frame($id){
echo"
  <html>
  <frameset cols='18%,*' border=0>
 	     <frame
src='http://161.246.5.146/auction1/main/display_category.php3?id=$id' name ='left_frame'> 	      
    
	     <frame 
src='http://161.246.5.146/auction1/main/main4.php3?id=$id' name ='right_frame'>
    
   </frameset>
	</html>
";
}// end function
}// end class
?>

