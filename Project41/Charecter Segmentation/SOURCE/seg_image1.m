function [pwd,count_file]=seg_image1(pwd,image_file);
more off;
echo off;
clc;

pwd_image_file = strcat(pwd,image_file);
info = imfinfo(pwd_image_file);
[imf,map] = imread(pwd_image_file);

[err_row] = min_row(imf,1,info.Width,1,info.Height);
[err_col] = min_col(imf,1,info.Width,1,info.Height);
err_row = num2str(err_row);
err_col = num2str(err_col);

error = inputdlg({'Defind error in row matrix','Defind error in column'},...
                  'Defind error',1,{err_row,err_col});
error = char(error);
error = str2num(error);
err_row = error(1);
err_col = error(2);

[row_1] = find_row(imf,1,info.Width,1,info.Height,err_row);

maxs = size(row_1);
maxs = maxs(2);
maxs = maxs-1;
count_file = 0;

for a_1=1:maxs
   
   im = imf(row_1(a_1):row_1(a_1+1),:);
   ih = row_1(a_1+1)-row_1(a_1)+1;
   
   image(im);
   colormap(map);
   drawnow;
   pause;
   
   [col_1] = find_col(im,1,info.Width,1,ih,err_col);
   maxs = size(col_1);
   maxs = maxs(2);
   maxs = maxs-1;
   
   for b_1=1:maxs
      
      picture_1 = im(:,col_1(b_1):col_1(b_1+1));
      
      image(picture_1);
      colormap(map);
      drawnow;
      pause;
      
%     picture_1 = double(picture_1);
%     [picture_1] = size_image(picture_1,h_1,w_1);
      
%     picture_1 = uint8(picture_1);
%     image(picture_1);
%     colormap(map);
%     drawnow;
      
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
      
      question = questdlg('You want running program','Image process',...
                          'Yes','No','No');
      switch question
         case 'No',
            return;
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