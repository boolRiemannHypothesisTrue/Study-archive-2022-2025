% Данные
C = [55, 65, 75, 85, 95, 105, 115];
I = [0.385, 0.52, 0.635, 0.685, 0.66, 0.58, 0.53];
Uc = [21.83, 24.86, 26.7, 25.5, 21.9, 16.83, 14.1];
P = [2.1, 3.65, 5.5, 6.2, 5.8, 4.5, 3.8];
k = [0.61, 0.78, 0.96, 1, 0.98, 0.86, 0.8];

% Создание интерполированных данных
C_interp = linspace(min(C), max(C), 100); % Новые значения C для интерполяции
I_interp = interp1(C, I, C_interp, 'spline'); % Интерполяция для I
Uc_interp = interp1(C, Uc, C_interp, 'spline'); % Интерполяция для Uc
P_interp = interp1(C, P, C_interp, 'spline'); % Интерполяция для P
k_interp = interp1(C, k, C_interp, 'spline'); % Интерполяция для k

% Создание графиков
subplot(2, 2, 1);
plot(C_interp, I_interp,  'LineWidth', 1.5, 'MarkerSize', 8);
grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
title('График I(C)');
xlabel('C (мкФ)');
ylabel('I (А)');

subplot(2, 2, 2);
plot(C_interp, Uc_interp, 'LineWidth', 1.5, 'MarkerSize', 8);
grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
title('График Uc(C)');
xlabel('C (мкФ)');
ylabel('Uc (В)');

subplot(2, 2, 3);
plot(C_interp, P_interp,  'LineWidth', 1.5, 'MarkerSize', 8);
grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
title('График P(C)');
xlabel('C (мкФ)');
ylabel('P (Вт)');

subplot(2, 2, 4);
plot(C_interp, k_interp,  'LineWidth', 1.5, 'MarkerSize', 8);
grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
title('График k(C)');
xlabel('C (мкФ)');
ylabel('k');

