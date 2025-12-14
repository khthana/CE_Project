function [copy]=copy_image(picture,h,w,y,x);

copy = 0;
for i=x+1:w
   if picture(y,i)==0
      
      for j=y+1:h
         if picture(j,x)==0
            
            for k=1:x-1
               if picture(y,x-k)==0
                  
                  for l=1:y-1
                     if picture(y-l,x)==0
                        copy = 1;
                        return;
                     end
                  end
                  
               end
            end
            
         end
      end
      
   end
end