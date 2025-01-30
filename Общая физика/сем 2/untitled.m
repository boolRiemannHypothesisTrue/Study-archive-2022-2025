
Imax1=[6.5,22,40,39,30,24,18,16,14];
w=[300,350,400,450,500,550,600,650,700];
w=2*3.1415*w;
plot(w,Imax1,'.','MarkerSize',7)

hold on 
Imax2=[0.875,1.25,2.125,2,1.5625,1.375,1.125,1,.875];
plot(w,Imax2,'.','MarkerSize',7)
hold off 


grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.65;
ax.GridLineStyle = '-';
