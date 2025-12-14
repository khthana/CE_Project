function [out]=find_col(in,xstart,xend,ystart,yend,th);

error = round((yend-ystart+1)*(th/100));

in = double(in);
for x=xstart:xend
   temp = find(in(ystart:yend,x)==0);
   temp = size(temp);
   graph(x) = temp(1);
end

count = 0;
ecount = 0;
temp = error;
if graph(xstart)>temp
   count = 1;
   out(1) = xstart;
else
   ecount = 1;
   merror(1) = xstart;
   if graph(xstart)<temp
      temp = graph(xstart);
   end
end

for x=xstart+1:xend
   if graph(x)==temp
      ecount = ecount+1;
      merror(ecount) = x;
   elseif graph(x)<temp
      ecount = 1;
      merror(1) = x;
      temp = graph(x);
   elseif (ecount~=0)&(graph(x)>error)
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
   out(count) = xend;
end