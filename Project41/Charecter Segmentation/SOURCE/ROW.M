function [out]=row(in,xstart,xend,ystart,yend);

th = 0;
error = round((xend-xstart+1)*(th/100));

in = double(in);
in = char(in);
for y=ystart:yend
   temp = find(in(y,xstart:xend)==0);
   temp = size(temp);
   graph(y) = temp(2);
end

count = 0;
ecount = 0;
temp = error;
if graph(ystart)>temp
   count = 1;
   out(1) = ystart;
else
   ecount = 1;
   merror(1) = ystart;
   if graph(ystart)<temp
      temp = graph(ystart);
   end
end

for y=ystart+1:yend
   if graph(y)==temp
      ecount = ecount+1;
      merror(ecount) = y;
   elseif graph(y)<temp
      ecount = 1;
      merror(1) = y;
      temp = graph(y);
   elseif (ecount~=0)&(graph(y)>error)
      count = count+1;
      out(count) = merror(round(ecount/2));
      temp = error;
      ecount = 0;
   end
end

if ecount~=0
   count = count+1;
   out(count) = merror(round(ecount/2));
else
   count = count+1;
   out(count) = yend;
end