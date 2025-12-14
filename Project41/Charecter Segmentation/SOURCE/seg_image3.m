function [pwd,count_file]=seg_image3(pwd,image_file);
more off;
echo off;
clc;

pwd_image_file = strcat(pwd,image_file);
info = imfinfo(pwd_image_file);
[imf,map] = imread(pwd_image_file);

[row_1] = row(imf,1,info.Width,1,info.Height);

maxs = size(row_1);
maxs = maxs(2);
maxs = maxs-1;
count_file = 0;

for a_1=1:maxs
   
   iw = info.Width+2;
   ih = row_1(a_1+1)-row_1(a_1)+3;
   im = ones(ih,iw);
   im(2:ih-1,2:iw-1) = imf(row_1(a_1):row_1(a_1+1),:);
   
   im = uint8(im);
   image(im);
   colormap(map);
   drawnow;
   pause;
   
   im = double(im);
   
   for pixel_x=1:iw
      have = all(im(:,pixel_x));
      if have==0
         for pixel_y=1:ih
            if im(pixel_y,pixel_x)==0
               
               [bound_x,bound_y] = boundary(im,pixel_y,pixel_x);
               
               maxs = size(bound_x);
               maxs = maxs(2);
               
               max_x = bound_x(1);
               min_x = bound_x(1);
               max_y = bound_y(1);
               min_y = bound_y(1);
               
               for m=2:maxs
                  if max_x < bound_x(m)
                     max_x = bound_x(m);
                  end
                  if max_y < bound_y(m)
                     max_y = bound_y(m);
                  end
                  if min_x > bound_x(m)
                     min_x = bound_x(m);
                  end
                  if min_y > bound_y(m)
                     min_y = bound_y(m);
                  end
               end
               
               h_1 = max_y-min_y+1;
               w_1 = max_x-min_x+1;
               
               picture_1 = ones(h_1,w_1);
               
               for a=1:maxs
                  picture_1(bound_y(a)-min_y+1,bound_x(a)-min_x+1) = 0;
                  im(bound_y(a),bound_x(a)) = 1;
               end
               
               for a=1:h_1
                  for b=1:w_1
                     if im(min_y+a-1,min_x+b-1)==0
                        [copy] = copy_image(picture_1,h_1,w_1,a,b);
                        if copy==1
                           picture_1(a,b) = 0;
                           im(min_y+a-1,min_x+b-1) = 1;
                        end
                     end
                  end
               end
               
               picture_1 = uint8(picture_1);
               image(picture_1);
               colormap(map);
               drawnow;
               pause;
               
               question = questdlg('You want save image','Image Processing',...
                                   'Yes','No','No');
               switch question
                  case 'Yes',
                     [save_file,save_pwd] = uiputfile('*.bmp','Save Image File');
                     if (save_file ~= 0)
                        if (save_pwd ~= 0)
                           save_image = strcat(save_pwd,save_file);
                           imwrite(picture_1,map,save_image,'bmp');
                        end
                     end
               end
               
               question = questdlg('You want run histogram','Image Processing',...
                                   'Yes','No','No');
               switch question
                  case 'Yes',
                     back(picture_1,h_1,w_1,map);
               end
               
               question = questdlg('You want running program','Image Processing',...
                                   'Yes','No','No');
               switch question
                  case 'No',
                     return;
               end
               
%              picture_2 = double(picture_2);
%              [picture_2] = size_image(picture_2,h_2,w_2);
               
%              picture_2 = uint8(picture_2);
%              image(picture_2);
%              colormap(map);
%              drawnow;
               
            end
         end
      end
   end
   
   question = questdlg('The end of line , You want running program','Image Processing',...
                       'Yes','No','No');
   switch question
      case 'No',
         return;
   end
end
questdlg('The end of image','Image Processing','OK','OK');