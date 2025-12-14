function back(imf,height,width,map);

[err_row] = min_row(imf,1,width,1,height);
[err_col] = min_col(imf,1,width,1,height);
err_row = num2str(err_row);
err_col = num2str(err_col);

error = inputdlg({'Defind error in row matrix','Defind error in column'},...
                  'Defind error',1,{err_row,err_col});
error = char(error);
error = str2num(error);
err_row = error(1);
err_col = error(2);

[row_1] = find_row(imf,1,width,1,height,err_row);

maxs = size(row_1);
maxs = maxs(2);
maxs = maxs-1;
aaaa = maxs;

for a_1=1:maxs
   
   im = imf(row_1(a_1):row_1(a_1+1),:);
   ih = row_1(a_1+1)-row_1(a_1)+1;
   
   [col_1] = find_col(im,1,width,1,ih,err_col);
   maxs = size(col_1);
   maxs = maxs(2);
   maxs = maxs-1;
   bbbb = maxs;
   
   for b_1=1:maxs
      
      picture_1 = im(:,col_1(b_1):col_1(b_1+1));
      iw = col_1(b_1+1)-col_1(b_1)+1;
      
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
      
      if (aaaa>1)|(bbbb>1)
         question = questdlg('You want run histogram this picture','Image Processing',...
                             'Yes','No','No');
         switch question
            case 'Yes',
               back(picture_1,ih,iw,map);
         end
      end
   end
end

question = questdlg('You want run histogram all picture','Image Processing',...
                    'Yes','No','No');
switch question
   case 'Yes',
      back(imf,height,width,map);
end