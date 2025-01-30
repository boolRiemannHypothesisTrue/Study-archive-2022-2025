Ksigma=[1.8,2.0,2.2,2.3,2.5,2.6,2.7];
d=[20,30,40,60,100];
Kd=[0.88,0.86,0.8,0.72,0.6];
d_q=20:5:100;
sigma=[400,500,600,700,800,900,1000];
sigma_q = 400:5:1000;  % additional query points
F1 = griddedInterpolant(sigma,Ksigma,'spline'); % interpolant 1
F2 = griddedInterpolant(d,Kd,'spline'); % interpolant 2
Ksigma_Inter=F1(sigma_q);
Kd_Inter=F2(d_q);
%plot(Ksigma_Inter,sigma_q)
plot(Kd_Inter,d_q)


% Анализ интерполированного графика
% sigma-Ksigma
% 520--   2.04685714285714
% 820--   2.53028571428571
% 950--   2.63660714285714
%1000--   2.70000000000000


grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
