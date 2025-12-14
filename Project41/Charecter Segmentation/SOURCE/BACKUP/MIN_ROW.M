function [out]=min_row(in,xstart,xend,ystart,yend);

in = double(in);
for y=ystart:yend
   temp = find(in(y,xstart:xend)==0);
   temp = size(temp);
   graph(y) = temp(2);
end

out = graph(ystart);
for y=ystart+1:yend
   if graph(y)<out
      out = graph(y);
   end
end

out = round((out/(xend-xstart+1))*100);