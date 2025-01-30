 %[x,y,z]=ellipsoid(0,0,0,14,61,10);
 %axis equal;
 %surf(x,y,z)
 %hold on
 %s=surf(x+3,y,z+5);
 %direction=[1,0,0];
 %rotate(s,direction,45)
 [r,the]=meshgrid([0:0.1:5],[0:pi/10:2*pi]);
 x=r.*cos(the);
  y=r.*sin(the);
   z=x.^2 + y.^2;
   surf(x,y,-z+5)