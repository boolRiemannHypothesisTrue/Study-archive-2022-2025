% Данные для T-s координат
T = [453.15, 580.032, 580.032, 268.15, 330.59337]; % Температура
s = [-0.11329597, 0.0088489039, 0.09711665, 0.09711665, 0.22967216]; % Энтропия

% Определение точек цикла
s12 = linspace(s(1), s(2), 100); % изохора 1-2
T12 = linspace(T(1), T(2), 100); % температура изменяется

s23 = linspace(s(2), s(3), 100); % изотерма 2-3
T23 = T(2) * ones(1, 100);        % T = const для изотермы

s34 = linspace(s(3), s(4), 100); % адиабата 3-4
T34 = linspace(T(3), T(4), 100);  % линейная интерполяция температуры

% Прямая линия между точками 4 и 5
s45 = [s(4), s(5)]; % энтропия
T45 = [T(4), T(5)]; % температура

s51 = linspace(s(5), s(1), 100); % политропа 5-1
T51 = linspace(T(5), T(1), 100);  % линейная интерполяция температуры

% Построение графика
figure;
hold on;
plot(s12, T12, 'k-', 'LineWidth', 2);          % изохора 1-2
plot(s23, T23, 'k-', 'LineWidth', 2);          % изотерма 2-3
plot(s34, T34, 'k-', 'LineWidth', 2);          % адиабата 3-4
plot(s45, T45, 'k-', 'LineWidth', 2);          % прямая линия 4-5
plot(s51, T51, 'k-.', 'LineWidth', 2);         % политропа 5-1

% Узлы
plot(s, T, 'ko', 'MarkerFaceColor', 'k'); % точки цикла

% Номера узлов с изменением координат
text(s(1) - 0.01, T(1), '1', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right'); % Узел 1
text(s(2) + 0.01, T(2), '2', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');  % Узел 2
text(s(3) + 0.01, T(3), '3', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');  % Узел 3
text(s(4) - 0.01, T(4), '4', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right'); % Узел 4
text(s(5) + 0.01, T(5), '5', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');  % Узел 5

% Оформление графика
xlabel('Энтропия, s [кДж/(кг·К)]');
ylabel('Температура, T [К]');
title('Термодинамический цикл в T-s координатах');
legend('Изохора 1-2', 'Изотерма 2-3', 'Адиабата 3-4', 'Изобара 4-5', 'Политропа 5-1');
grid on;
grid minor;
hold off;
