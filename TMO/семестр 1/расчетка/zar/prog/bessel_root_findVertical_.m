% Параметры
Bi_x =0.13548387; % Константа Bi_x (для линейной функции)

% Задаем диапазон для mu (значения для оси X)
mu = linspace(0, 19, 100000);

% Вычисление значений характеристических уравнений
char_eqn_values1 = cot(mu);   % Функция cot(mu)
char_eqn_values2 = mu / Bi_x; % Линейная функция mu / Bi_x

% Строим график
figure;
plot(mu, char_eqn_values1, 'r', 'LineWidth', 1.5); % График cot(mu) (красный)
hold on;
plot(mu, char_eqn_values2, 'b', 'LineWidth', 1.5); % График mu / Bi_x (синий)
xlabel('$\mu$', 'Interpreter', 'latex'); % Подпись оси X (LaTeX)
ylabel('$\cot(\mu)$ & $\mu/Bi_x$', 'Interpreter', 'latex'); % Подпись оси Y (LaTeX)
title('$\cot(\mu)$ & $\mu/Bi_x$', 'Interpreter', 'latex'); % Заголовок (LaTeX)
legend('$\cot(\mu)$', '$\mu/Bi_x$', 'Location', 'NorthWest', 'Interpreter', 'latex'); % Легенда (LaTeX)
ylim([-100, 150]);  % Ограничение оси Y
grid on;

% Инициализация массива для хранения корней
mu_x_values = [];  % Массив для хранения корней

% Погрешность
tolerance = 0.1;

% Поиск корней методом fzero
for i = 1:length(mu)-1
    % Проверка на изменение знака между соседними значениями
    if sign(char_eqn_values1(i) - char_eqn_values2(i)) ~= sign(char_eqn_values1(i+1) - char_eqn_values2(i+1))
        % Используем fzero для нахождения корня на промежутке [mu(i), mu(i+1)]
        mu_x = fzero(@(x) cot(x) - x / Bi_x, [mu(i), mu(i+1)]);
        mu_x_values = [mu_x_values, mu_x];  % Сохраняем найденный корень
    end
end

% Отображение корней на графике
for i = 1:length(mu_x_values)
    mu_root = mu_x_values(i);
    y_root = mu_root / Bi_x;  % Значение функции в точке корня
    plot(mu_root, y_root, 'ko', 'MarkerFaceColor', 'w'); % 'ko' для черного круга
end

% Добавление асимптот в точках разрывов (для cot(mu) = NaN)
mu_cot_zeros = pi * (1:floor(25/pi)); % Точки разрыва cot(mu) на интервале [0, 25]
for i = 1:length(mu_cot_zeros)
    plot([mu_cot_zeros(i), mu_cot_zeros(i)], ylim, 'k--', 'LineWidth', 1.5);  % Черные пунктирные вертикальные линии
end

% Отфильтрованные значения (для отображения только нужных корней)
filtered_mu_x_values = mu_x_values(mu_x_values ~= 0);
 filtered_mu_x_values=filtered_mu_x_values(1:2:end);

% Печать корней
disp('Найденные корни (по высоте цилиндра):');
disp(filtered_mu_x_values);
