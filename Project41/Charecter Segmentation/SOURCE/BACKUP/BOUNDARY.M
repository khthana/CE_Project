function [bound_x,bound_y]=boundary(picture,y,x);

count = 1;
bound_x(count) = x;
bound_y(count) = y;

tx1 = x;
ty1 = y;
tx2 = x;
ty2 = y-1;

while (ty2~=y)|(ty1~=y)|(tx2~=x)|(tx1~=x-1)
   
   if picture(ty2,tx2)==0
      count = count+1;
      bound_x(count) = tx2;
      bound_y(count) = ty2;
   end
   
   if (tx1<tx2)&(ty1==ty2) type = 1; end
   if (tx1>tx2)&(ty1==ty2) type = 2; end
   if (tx1==tx2)&(ty1<ty2) type = 3; end
   if (tx1==tx2)&(ty1>ty2) type = 4; end
   
   switch type
      case 1,
         if picture(ty2,tx2)==0
            tx1 = tx2;
            ty1 = ty2;
            ty2 = ty2-1;
         elseif picture(ty2,tx2)~=0
            tx1 = tx2;
            ty1 = ty2;
            ty2 = ty2+1;
         end
         
      case 2,
         if picture(ty2,tx2)==0
            tx1 = tx2;
            ty1 = ty2;
            ty2 = ty2+1;
         elseif picture(ty2,tx2)~=0
            tx1 = tx2;
            ty1 = ty2;
            ty2 = ty2-1;
         end
         
      case 3,
         if picture(ty2,tx2)==0
            tx1 = tx2;
            tx2 = tx2+1;
            ty1 = ty2;
         elseif picture(ty2,tx2)~=0
            tx1 = tx2;
            tx2 = tx2-1;
            ty1 = ty2;
         end
         
      case 4,
         if picture(ty2,tx2)==0
            tx1 = tx2;
            tx2 = tx2-1;
            ty1 = ty2;
         elseif picture(ty2,tx2)~=0
            tx1 = tx2;
            tx2 = tx2+1;
            ty1 = ty2;
         end
   end
end