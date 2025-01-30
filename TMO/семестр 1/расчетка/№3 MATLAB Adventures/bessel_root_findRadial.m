% Параметры
Bi_r = 0.11290323; % Константа B_r (для линейной функции)

% Задаем диапазон для mu (значения для оси X)
mu = linspace(0, 20, 100000);

% Вычисление значений характеристических уравнений
char_eqn_values1 = besselj(0, mu) ./ besselj(1, mu);  % Отношение Бесселя
char_eqn_values2 = mu / Bi_r;  % Линейная функция mu / Bi_r

% Строим график
figure;
plot(mu, char_eqn_values1, 'b-', 'LineWidth', 1.5); % График отношения Бесселя (синий)
hold on;
plot(mu, char_eqn_values2, 'r--', 'LineWidth', 1.5); % График линейной функции (красный)
xlabel('\epsilon');
ylabel('');
title('(J_0(\epsilon))/(J_1(\epsilon)) & \epsilon/Bi_r');
legend('(J_0(\epsilon))/(J_1(\epsilon))', '\epsilon/Bi_r', 'Location', 'NorthWest');
ylim([-100, 150]);
grid on;

% Точность для поиска пересечений
tolerance = 0.1; 

% Инициализация массива для хранения найденных корней
mu_r_values = zeros(1, 15); % Массив для хранения корней
index = 1;

% Выводим заголовок
disp([' ']);
disp([char(9733) ' Корни характеристического уравнения ' char(9733)]);
disp('По радиусу цилиндра:');

% Цикл поиска корней методом fzero
for i = 1:length(mu)-1
    % Проверка на изменение знака между соседними значениями
    if sign(char_eqn_values1(i) - char_eqn_values2(i)) ~= sign(char_eqn_values1(i+1) - char_eqn_values2(i+1))
        % Используем fzero для нахождения корня на промежутке [mu(i), mu(i+1)]
        mu_r = fzero(@(x) besselj(0, x) / besselj(1, x) - x / Bi_r, [mu(i), mu(i+1)]);
        mu_r_values(index) = mu_r;  % Сохраняем найденный корень
        index = index + 1;  % Переходим к следующему индексу
    end
end

% Отбор корней для отображения (если корни не равны нулю)
filtered_mu_r_values = mu_r_values(mu_r_values ~= 0);

% Исключаем корни по индексам (например, 2, 4, 6, 8, 10, 12, 14)
exclude_indices = [2, 4, 6, 8, 10, 12, 14];
filtered_mu_r_values = filtered_mu_r_values(~ismember(1:length(filtered_mu_r_values), exclude_indices));

% Вывод отфильтрованных значений
disp('Найденные корни (после исключения лишних):');
disp(filtered_mu_r_values);

% Отображение корней на графике
% Добавляем кружки на те места, где расположены корни
