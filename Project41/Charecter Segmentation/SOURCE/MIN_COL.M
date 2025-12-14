function [out]=min_col(in,xstart,xend,ystart,yend);

in = double(in);
for x=xstart:xend
   temp = find(in(ystart:yend,x)==0);
   temp = size(temp);
   graph(x) = temp(1);
end

out = graph(xstart);
for x=xstart+1:xend
   if graph(x)<out
      out = graph(x);
   end
end

out = round((out/(yend-ystart+1))*100);