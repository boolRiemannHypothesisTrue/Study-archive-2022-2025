% Новые данные
C_new = [40, 50, 60, 70, 80, 90, 100];
Ic_new = [0.35, 0.44, 0.51, 0.6, 0.68, 0.75, 0.84];
I_new = [0.38, 0.32, 0.3, 0.29, 0.31, 0.34, 0.39];
k_new = [0.77, 0.89, 0.96, 1, 0.93, 0.85, 0.74];

% Интерполяция новых данных
C_interp_new = linspace(min(C_new), max(C_new), 100); % Новые значения C для интерполяции
Ic_interp_new = interp1(C_new, Ic_new, C_interp_new, 'pchip'); % Интерполяция для Ic
I_interp_new = interp1(C_new, I_new, C_interp_new, 'spline'); % Интерполяция для I
k_interp_new = interp1(C_new, k_new, C_interp_new, 'spline'); % Интерполяция для k

% Создание графиков
figure; % Создание новой фигуры
subplot(2, 2, 1);
plot(C_interp_new, Ic_interp_new,  'LineWidth', 1.5, 'MarkerSize', 8);
grid on
grid minor
set(0,'DefaultLineLineWidth',1)
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

title('График Ic(C)');
xlabel('C (мкФ)');
ylabel('Ic (А)');

subplot(2, 2, 2);
plot(C_interp_new, I_interp_new,  'LineWidth', 1.5, 'MarkerSize', 8);
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

subplot(2, 2, 3);
plot(C_interp_new, k_interp_new,  'LineWidth', 1.5, 'MarkerSize', 8);
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
