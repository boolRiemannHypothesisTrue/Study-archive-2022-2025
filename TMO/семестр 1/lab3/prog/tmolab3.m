Un = [37.11, 63.46, 88.36, 109.75, 125.39, 140.51, 153.57, 160,168.75, 181.48, 193.32];
Un = Un.*10.^(-3);  % mV to V
Ut = [0.116, 0.211, 0.315, 0.426, 0.52, 0.633, 0.739, 0.825, 0.925, 1.031, 1.115];
t2 = [21, 21, 21.1, 21.2, 21.4, 21.6, 22, 22.6, 23.2, 23.8, 25];
T2 = t2 + 273.15; % Celsius to Kelvin
Rn = 0.1;   I=Un./Rn;   Rt=Ut./I;   R0=0.28736;    Rttilda=Rt./R0 - 1;
T1 = 273.15 + (Rttilda*252*2)./(1+sqrt(1-(Rttilda*0.1485)));
l=81.5* 10^-3;  
ql=(I.*Ut)/l; % linear density of heat flow
c0 = 5.67*10^-8;    eps = (0.00013.*T1 - 0.0025);    d1 = 0.189*10^-3;
qlr=eps.*c0.*(T1.^4 - T2.^4)*pi*d1; % radiational part of heat flow
qllambda=ql - qlr;
[T1',qllambda']