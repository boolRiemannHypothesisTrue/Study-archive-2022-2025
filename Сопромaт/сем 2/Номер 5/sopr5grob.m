% var.10
a = 0.06;
R = 1;

p0 = 0.6 * 10^6;
q = 0.2 * 10^6;

E = 200 * 10^9;
sigma = 240 * 10^6;
Nx = 0;
mu = 0.3;

h = p0 * R / sigma;
fprintf('\nЗначение h = %f м\n', h);
h = 6 * h;  % Подобранное значение толщины чтобы выполнялся критерий прочности
fprintf('Подогнанное значение h = %f м\n', h);

D = E * h^3 / (12 * (1 - mu^2));
fprintf('\nЦилиндрическая жесткость D = %f\n', D);

k = (E * h / (4 * D * R^2))^(1 / 4);
fprintf('\nВолновое число k = %f м^-1\n', k);

lambda = pi / k;
fprintf('\nДлина краевого эффекта λ = %f м\n', lambda);

C = [-1, 1;  % Первое условие - угол поворота в точке разреза (x==0) равен нулю. Второе условие на поперечную силу в точке разреза равную q/2
     1, 1];
b = [0; -0.5 * q / (2 * D * k^3)];

consts = C \ b;
C1 = consts(1);
C2 = consts(2);
fprintf('\nКоэффициенты C равны:\nC1 = %f\nC2 = %f\n', C1, C2);

W = @(x) C1 .* exp(-k .* abs(x)) .* cos(k .* abs(x)) + C2 .* exp(-k .* abs(x)) .* sin(k .* abs(x)) + p0 * R^2 / (E * h);
phi = @(x) -k .* exp(-k .* abs(x)) .* ((C1 - C2) .* cos(k .* abs(x)) + (C1 + C2) .* sin(k .* abs(x)));
Mx = @(x) 2 * k^2 .* exp(-k .* abs(x)) .* D .* (C1 .* sin(k .* abs(x)) - C2 .* cos(k .* abs(x)));
My = @(x) mu .* Mx(x);
Ny = @(x) mu * Nx + E * h / R .* W(x);
Q = @(x) 2 * k^3 .* D .* exp(-k .* abs(x)) .* ((C1 + C2) .* cos(k .* abs(x)) - (C1 - C2) .* sin(k .* abs(x)));

sigma_x_inner = @(x) Nx / h + 6 * Mx(x) / h^2;
sigma_x_outer = @(x) Nx / h - 6 * Mx(x) / h^2;
sigma_y_inner = @(x) Ny(x) / h + 6 * My(x) / h^2;
sigma_y_outer = @(x) Ny(x) / h - 6 * My(x) / h^2;
sigma_eqv_inner = @(x) sqrt(sigma_x_inner(x).^2 + sigma_y_inner(x).^2 - sigma_x_inner(x) .* sigma_y_inner(x));
sigma_eqv_outer = @(x) sqrt(sigma_x_outer(x).^2 + sigma_y_outer(x).^2 - sigma_x_outer(x) .* sigma_y_outer(x));

x_positive = linspace(0, 2 * lambda, 100);
x_negative = linspace(-2 * lambda, 0, 100);
x = [x_negative, x_positive];

figure('Position', [100, 100, 1600, 1200]);

subplot(2, 2, 1);
plot(x, Mx(x) / 10^3, 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('$M_x$(x), кН/м', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра момента Mx');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

subplot(2, 2, 2);
plot(x, My(x) / 10^3, 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('$M_y$(x), кН/м', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра момента My');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

subplot(2, 2, 3);
plot(x, Ny(x) / 10^6, 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('$N_y$(x), МН/м', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра окружного усиления');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

subplot(2, 2, 4);
plot(x, Q(x) / 10^3, 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('Q(x), кН', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра поперечной силы Q');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

figure('Position', [100, 100, 1600, 1200]);

subplot(2, 2, 1);
plot(x, sigma_eqv_outer(x) / 10^6, 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('$σ_{eqv}$, МПа', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра эквивалентных напряжений для внешней поверхности оболочки');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

subplot(2, 2, 2);
plot(x, sigma_eqv_inner(x) / 10^6, 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('$σ_{eqv}$, МПа', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра эквивалентных напряжений для внутренней поверхности оболочки');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

subplot(2, 2, 3);
plot(x, W(x), 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('W(x), м', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра прогиба');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

subplot(2, 2, 4);
plot(x, phi(x), 'k');
hold on;
xlabel('x, м', 'FontSize', 12);
ylabel('φ(x), рад', 'FontSize', 12, 'Interpreter', 'latex');
title('Эпюра углового перемещения');
grid on;
xticks(-2 * lambda:0.05:2 * lambda);

sigma_eqv_inner_max = max(abs(sigma_eqv_inner(x)));
sigma_eqv_outer_max = max(abs(sigma_eqv_outer(x)));
fprintf('Maximum equivalent stress for inner surface σ_{eqv_inner_max} = %f MPa\n', sigma_eqv_inner_max / 1e6);
fprintf('Maximum equivalent stress for outer surface σ_{eqv_outer_max} = %f MPa\n', sigma_eqv_outer_max / 1e6);

if sigma_eqv_inner_max > sigma_eqv_outer_max
    n = sigma / sigma_eqv_inner_max;
else
    n = sigma / sigma_eqv_outer_max;
end
fprintf('Safety factor n = %f\n', n);
