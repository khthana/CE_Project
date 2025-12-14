function [pwd,image_file]=fil_image(pwd,image_file);
more off;
echo off;
clc;

pwd_image_file = strcat(pwd,image_file);
info = imfinfo(pwd_image_file);
[m,map]=imread(pwd_image_file);
m = double(m);
m = char(m);

for h=1:info.Height
   for w=1:info.Width
      if m(h,w)==0
         if (m(h  ,w-1)~=0)&(m(h  ,w+1)~=0)&...
            (m(h+1,w-1)~=0)&(m(h+1,w+1)~=0)&(m(h+1,w)~=0)&...
            (m(h-1,w-1)~=0)&(m(h-1,w+1)~=0)&(m(h-1,w)~=0)
            m(h,w) = 1;
         end
      end
   end
end

m = double(m);
m = uint8(m);
image(m);
colormap(map);

image_file = 'fil.bmp';
save_pwd_image_file = strcat(pwd,image_file);
imwrite(m,map,save_pwd_image_file,'bmp');