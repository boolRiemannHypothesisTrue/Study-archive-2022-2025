R1=0.18;
R2=0.21;% meter
p1=7*10^6;% МПа
p2=2*10^6;
T1=170;% celcius
T2=130;
deltaT=T1-T2;
E=200*10^9; % Па
alpha=1.25*10^(-5); % inv celcius
PoissonCoeff=0.3;



r=linspace(0.18,0.21,250);  


sigma_r_p=(p1.*R1.^2 - p2.*R2.^2)./(R2.^2 - R1.^2) - (p1-p2).*((R1.*R2).^2)./((R2.^2 - R1.^2).*r.^2);
sigma_theta_p=(p1.*R1.^2 - p2.*R2.^2)./(R2.^2 - R1.^2) + (p1-p2).*((R1.*R2).^2)./((R2.^2 - R1.^2).*r.^2);
sigma_z_p=(p1.*R1.^2 - p2.*R2.^2)./(R2.^2 - R1.^2)+ 0*r;  % необходимый костыль матлаба


K=E*alpha*deltaT./(2*(1-PoissonCoeff)*log(R2/R1));
sigma_r_t=-K*(log(R2./r)+ (R1.^2)*(1-(R2.^2)./(r.^2))*log(R2./R1)/(R2.^2 - R1.^2));
sigma_theta_t=K*(1-log(R2./r) - (R1.^2)*(1+(R2.^2)./(r.^2))*log(R2./R1)/(R2.^2 - R1.^2));
sigma_z_t=K*(1-2*log(R2./r) - 2*(R1.^2)*log(R2./R1)/(R2.^2 - R1.^2));


tiledlayout(2,2)

nexttile

%plot(r,sigma_r_p)  
%plot(r,sigma_r_t)
plot(r,sigma_r_p + sigma_r_t)



grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
colororder(["#000000"])

nexttile

%plot(r,sigma_theta_p)
%plot(r,sigma_theta_t)
plot(r,sigma_theta_p + sigma_theta_t)




grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='#000000';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';


nexttile

%plot(r,sigma_z_p)
%plot(r,sigma_z_t)
plot(r,sigma_z_p+sigma_z_t)


grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';





nexttile

%{ поиск опасной точки. Для этого вводим функцию равную сумме МОДУЛЕЙ всех
% суммарных напряжений и ищем ее максимум на интервале [R1,R2]
%}
sigma_sum=abs(sigma_z_p+sigma_z_t)+abs(sigma_theta_p + sigma_theta_t)+abs(sigma_r_p + sigma_r_t);
plot(r,sigma_sum)







grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';




 