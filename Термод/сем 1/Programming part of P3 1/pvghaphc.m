% Данные для состояний
v = [0.053686895, 0.053686895, 0.083214688, 0.49248948, 0.60717417];% объёмы
p = [1700., 2176., 1403.871, 109.66198, 109.66198];               % давления

% Коэффициенты
n = 1.13; % коэффициент политропы
k = 1.4285676; % коэффициент адиабаты

% Определение точек цикла
V12 = linspace(v(1), v(2), 100); % изохора 1-2
P12 = linspace(p(1), p(2), 100); % давление изменяется

V23 = linspace(v(2), v(3), 100); % изотерма 2-3
P23 = p(2) * (v(2) ./ V23);      % P*V = const для изотермы

V34 = linspace(v(3), v(4), 100); % адиабата 3-4
P34 = p(3) * (v(3) ./ V34).^k;   % Давление на этапе 3-4
P34(end) = p(4); % Убедитесь, что последнее значение соответствует p(4)

V45 = linspace(v(4), v(5), 100); % изобара 4-5
P45 = p(4) * ones(1, 100);       % давление постоянно

V51 = linspace(v(5), v(1), 100); % политропа 5-1
P51 = p(1) * (v(1) ./ V51).^n;   % Давление на этапе 5-1

% Отладка
disp(['P3: ', num2str(p(3))]);
disp(['P4: ', num2str(p(4))]);
disp('Давление на этапе 3-4:');
disp(P34);

% Построение графика
figure;
hold on;
plot(V12, P12, 'k-', 'LineWidth', 2);          % изохора
plot(V23, P23, 'k-', 'LineWidth', 2);          % изотерма
plot(V34, P34, 'k-', 'LineWidth', 2);          % адиабата
plot(V45, P45, 'k-', 'LineWidth', 2);          % изобара
plot(V51, P51, 'k-.', 'LineWidth', 2);         % политропа

% Узлы
plot(v(1), p(1), 'ko', 'MarkerFaceColor', 'k'); % точка 1
plot(v(2), p(2), 'ko', 'MarkerFaceColor', 'k'); % точка 2
plot(v(3), p(3), 'ko', 'MarkerFaceColor', 'k'); % точка 3
plot(v(4), p(4), 'ko', 'MarkerFaceColor', 'k'); % точка 4
plot(v(5), p(5), 'ko', 'MarkerFaceColor', 'k'); % точка 5

% Номера узлов
text(v(1) - 0.002, p(1) + 20, ' 1', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(v(2) - 0.002, p(2) - 20, ' 2', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
text(v(3) + 0.002, p(3) - 20, ' 3', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
text(v(4) + 0.002, p(4) + 20, ' 4', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
text(v(5) + 0.002, p(5) + 20, ' 5', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

% Оформление графика
xlabel('Объём, v [м^3/кг]');
ylabel('Давление, p [кПа]');
title('Термодинамический цикл в p-v координатах');
legend('Изохора 1-2', 'Изотерма 2-3', 'Адиабата 3-4', 'Изобара 4-5', 'Политропа 5-1');
grid on;
grid minor;
hold off;
