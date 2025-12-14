function [seg_pic,copy_pic]=segment_g...
         (seg_pic,copy_pic,tone_up,tone_low,y,x,max_x,max_y);

check = 0;
count = 1;
max_size = 1;
pixel_x(1) = x;
pixel_y(1) = y;

for temp_y=y-1:y+1
   for temp_x=x-1:x+1
      
      if (temp_y>=1)&(temp_y<=max_y)&...
         (temp_x>=1)&(temp_x<=max_x)
         
         if (seg_pic(temp_y,temp_x)>=tone_low)&...
            (seg_pic(temp_y,temp_x)<=tone_up)
            
            copy_pic(temp_y,temp_x) = seg_pic(temp_y,temp_x);
            seg_pic(temp_y,temp_x) = 0;
            
            check = check+1;
            max_size = max_size+1;
            pixel_y(max_size) = temp_y;
            pixel_x(max_size) = temp_x;
         end
      end
   end
end

while check>0
   
   count = count+1;
   check = check-1;
   
   for temp_y=pixel_y(count)-1:pixel_y(count)+1
      for temp_x=pixel_x(count)-1:pixel_x(count)+1
         
         if (temp_y>=1)&(temp_y<=max_y)&...
            (temp_x>=1)&(temp_x<=max_x)
            
            if (seg_pic(temp_y,temp_x)>=tone_low)&...
               (seg_pic(temp_y,temp_x)<=tone_up)
               
               copy_pic(temp_y,temp_x) = seg_pic(temp_y,temp_x);
               seg_pic(temp_y,temp_x) = 0;
               
               check = check+1;
               max_size = max_size+1;
               pixel_y(max_size) = temp_y;
               pixel_x(max_size) = temp_x;
            end
         end
      end
   end
end