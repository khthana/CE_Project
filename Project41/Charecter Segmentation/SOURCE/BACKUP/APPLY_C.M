function apply_c(pwd,image_file);
more off;
echo off;
clc;

pwd_image_file = strcat(pwd,image_file);
info = imfinfo(pwd_image_file);
[imf,map] = imread(pwd_image_file);
imf = double(imf);
tmm = mod(imf,16);

for tone=1:16
   
   lvl = tone-1;
   
   picture = zeros(info.Height,info.Width);
   
   for y=1:info.Height
      for x=1:info.Width
         if (imf(y,x)~=0)&(tmm(y,x)==lvl)
            
            picture(y,x) = imf(y,x);
            imf(y,x) = 0;
            [imf,picture] = segment_c...
            (imf,picture,tmm,lvl,y,x,info.Width,info.Height);
         end
      end
   end
   
   picture = uint8(picture);
   image(picture);
   colormap(map);
   drawnow;
end
questdlg('The end of image','Image Processing','OK','OK');