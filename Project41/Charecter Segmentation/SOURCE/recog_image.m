function recog_image(pwd,count_file);
more off;
echo off;
clc;

loop_base = 0;
for count=1:count_file
   pwd_temp_file = strcat(pwd,'temp',num2str(count),'.bmp');
   t_info = imfinfo(pwd_temp_file);
   [t,t_map] = imread(pwd_temp_file);
   t = double(t);
   
   for test=1:loop_base
      pwd_base_file = strcat(pwd,'base',num2str(test),'.bmp');
      [b,b_map] = imread(pwd_base_file);
      b = double(b);
      compare = b|t;
      front_t = 0;
      front_b = 0;
      
      for h=1:t_info.Height
         for w=1:t_info.Width
            if compare(h,w)==0
               front_t = front_t+1;
            end
            if b(h,w)==0
               front_b = front_b+1;
            end
         end
      end
      
      compare = uint8(compare);
      image(compare);
      drawnow;
      
      recog(test) = (front_t/front_b)*100;
   end
   
   matching = 1;
   temp = recog(1);
   
   for test=2:loop_base
      if recog(test)>temp
         matching = test;
         temp = recog(test);
      end
   end
   
   match = strcat('match ',num2str(recog(matching)),' % by front ',num2str(matching));
   questdlg(match,'Image Processing','OK','OK');
   
end
questdlg('The End of Recognize Image','Image Processing','OK','OK');