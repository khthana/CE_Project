function apply_g(pwd,image_file);
more off;
echo off;
clc;

level = inputdlg({'Defind level of gray image'},'Defind level',1,{'4'});
level = char(level);
level = str2num(level);

hold = round(256/level);

pwd_image_file = strcat(pwd,image_file);
info = imfinfo(pwd_image_file);
[imf,map] = imread(pwd_image_file);
imf = double(imf);

for tone=1:level
   if tone==1
      tone_up = hold-1;
      tone_low = 1;
   else
      tone_up = (tone*hold)-1;
      tone_low = (tone*hold)-hold;
   end
   
   picture = zeros(info.Height,info.Width);
   
   for y=1:info.Height
      for x=1:info.Width
         if (imf(y,x)>=tone_low)&(imf(y,x)<=tone_up)
            picture(y,x) = imf(y,x);
            imf(y,x) = 0;
            [imf,picture] = segment_g...
            (imf,picture,tone_up,tone_low,y,x,info.Width,info.Height);
         end
      end
   end
   
   picture = uint8(picture);
   image(picture);
   colormap(map);
   drawnow;
end
questdlg('The end of image','Image Processing','OK','OK');