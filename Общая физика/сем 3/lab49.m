Angle =0:15:360;
%theta=theta*pi/180;
%rho=[.368,.153,.037,.0061,.196,.423,.687,.883,1,.982,.847,.626,.368,.153,.037,.0061,.196,.423,.687,.883,1,.988,.847,.62,.368];
Mag =[0.167,0.056,0.083,0.194,0.444,0.694,0.888,0.944,1,0.861,0.722,0.361,0.167,0.056,0.083,0.194,0.444,0.694,0.888,0.944,1,0.861,0.638,0.361,0.167];
% Заданные данные (theta и f(theta))
thetaData =0:15:360;
thetaData=deg2rad(thetaData);
fData =[0.167,0.056,0.083,0.194,0.444,0.694,0.888,0.944,1,0.861,0.722,0.361,0.167,0.056,0.083,0.194,0.444,0.694,0.888,0.944,1,0.861,0.638,0.361,0.167];

% Нулевые начальные значения параметров
initialGuess = [0, 0];

% Определение функции, которую вы хотите подгонять
model = @(params, theta) params(1) + (1 - params(1)) * cos(theta).^2 + params(2);

% Минимизация суммы квадратов ошибок
optimalParams = fminsearch(@(params) norm(model(params, thetaData) - fData), initialGuess);

% Определение оптимальных значений констант
C1 = optimalParams(1);
C2 = optimalParams(2);


grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
