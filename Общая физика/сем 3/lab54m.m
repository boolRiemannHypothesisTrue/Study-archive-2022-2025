y=[1.53*10^4,2.06*10^4,2.3*10^4,2.44*10^4];
x=[0.1111,0.0625,0.04,0.0277];
c=polyfit(x,y,1);
y_est = polyval(c,x);
plot(x,y_est)
hold on
plot(x,y,'.','MarkerSize',17)
hold off


c = polyfit(x, y, 1);
p = polyval(c, x);
residuals = y - p; % вычисление остатков

% Оценка погрешностей
p_err = sqrt(sum(residuals.^2) / (length(y) - 2)); % Стандартная ошибка оценки
Cov = inv(transpose(x)*x)*p_err^2; % Ковариационная матрица
A_err = sqrt(Cov(1,1)); % Погрешность коэффициента A
B_err = sqrt(Cov(2,2)); % Погрешность коэффициента B

% Вывод результатов
disp(['Коэффициент A: ', num2str(c(1)), ', Погрешность: ', num2str(A_err)]);
disp(['Коэффициент B: ', num2str(c(2)), ', Погрешность: ', num2str(B_err)]);


grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='#000000';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
