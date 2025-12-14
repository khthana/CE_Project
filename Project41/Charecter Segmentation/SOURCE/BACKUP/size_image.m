function [matrix]=size_image(front,size_h,size_w);

height = 20;
width = 20;
matrix = ones(height,width);
retio_h = size_h/height;
retio_w = size_w/width;

for h=1:height
   temp_h = round((retio_h*h)+0.5);
   if temp_h > size_h
      temp_h = size_h;
   end
   
   for w=1:width
      temp_w = round((retio_w*w)+0.5);
      if temp_w > size_w
         temp_w = size_w;
      end
      matrix(h,w) = front(temp_h,temp_w);
   end
end