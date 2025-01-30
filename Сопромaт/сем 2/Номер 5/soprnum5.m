a = 0.05;
R = 0.90;
p0 = 0.6 * 10^6;
q = 0.2 * 10^6;
m = q * a;
E = 200 * 10^9;
sigma = 240 * 10^6;
Nx = 0;
mu = 0.3;

h = 9 * p0 * R / sigma; % оптимизированное значение толщины
disp(['Value of h=', num2str(h), ' m']);

D = E * h^3 / (12 * (1 - mu^2));
disp(['Cylindrical stiffness D=', num2str(D)]);

k = (E * h / (4 * D * R^2))^(1 / 4);
disp(['Wave number k=', num2str(k), ' m^-1']);

lambda = pi / k;
disp(['Edge effect length λ=', num2str(lambda), ' m']);

C = [0, 1; 1, 1]; % матрица краевых условий
b = [m / (2 * D * k^2); 0];  % вектор краевых условий

consts = linsolve(C, b);
C1 = consts(1);
C2 = consts(2);
disp(['Coefficients C:']);
disp(['C1=', num2str(C1)]);
disp(['C2=', num2str(C2)]);

x = linspace(0, 2 * lambda, 100);

% Функции для вычисления величин
W = @(x) C1 * exp(-k * x) .* cos(k * x) + C2 * exp(-k * x) .* sin(k * x) + p0 * R^2 / (E * h);
phi = @(x) -k * exp(-k * x) .* ((C1 - C2) * cos(k * x) + (C1 + C2) * sin(k * x));
Mx = @(x) 2 * k^2 * exp(-k * x) .* D .* (C1 * sin(k * x) - C2 * cos(k * x));
My = @(x) mu * Mx(x);
Ny = @(x) mu * Nx + E * h / R * W(x);
Q = @(x) 2 * k^3 * D * exp(-k * x) .* ((C1 + C2) * cos(k * x) - (C1 - C2) * sin(k * x));
sigma_x_inner = @(x) Nx / h + 6 * Mx(x) / h^2;
sigma_x_outer = @(x) Nx / h - 6 * Mx(x) / h^2;
sigma_y_inner = @(x) Ny(x) / h + 6 * My(x) / h^2;
sigma_y_outer = @(x) Ny(x) / h - 6 * My(x) / h^2;
sigma_eqv_inner = @(x) sqrt(sigma_x_inner(x).^2 + sigma_y_inner(x).^2 - sigma_x_inner(x) .* sigma_y_inner(x));
sigma_eqv_outer = @(x) sqrt(sigma_x_outer(x).^2 + sigma_y_outer(x).^2 - sigma_x_outer(x) .* sigma_y_outer(x));

% Графики
figure('Position', [0, 0, 800, 600]);
subplot_titles = {'Moment Mx', 'Moment My', 'Circumferential Reinforcement', 'Transverse Force Q'};
plot_functions = {Mx, My, Ny, Q};
plot_ylabels = {'$M_x(x)$, kN/m', '$M_y(x)$, kN/m', '$N_y(x)$, MN/m', '$Q(x)$, kN'};
for i = 1:4
    subplot(2, 2, i);
    plot(x, plot_functions{i}(x) / (1e3), 'k');
    xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel(plot_ylabels{i}, 'Interpreter', 'latex', 'FontSize', 12);
    title(subplot_titles{i}, 'Interpreter', 'latex', 'FontSize', 12);
    grid on;
    grid minor;
    set(gca, 'GridColor', 'k', 'GridAlpha', 0.8, 'GridLineStyle', '-');
end

% Графики эквивалентных напряжений и прочности
figure('Position', [0, 0, 800, 600]);
subplot_titles = {'Equivalent Stresses for Outer Surface', 'Equivalent Stresses for Inner Surface', 'Deflection', 'Angular Displacement'};
plot_functions = {sigma_eqv_outer, sigma_eqv_inner, W, phi};
plot_ylabels = {'$\sigma_{eqv}$, MPa', '$\sigma_{eqv}$, MPa', '$W(x)$, m', '$\phi(x)$, rad'};
for i = 1:4
    subplot(2, 2, i);
    plot(x, plot_functions{i}(x) / (1e6), 'k');
    xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel(plot_ylabels{i}, 'Interpreter', 'latex', 'FontSize', 12);
    title(subplot_titles{i}, 'Interpreter', 'latex', 'FontSize', 12);
    grid on;
    grid minor;
    set(gca, 'GridColor', 'k', 'GridAlpha', 0.8, 'GridLineStyle', '-');
end

% Расчет коэффициента запаса прочности
sigma_eqv_inner_max = max(abs(sigma_eqv_inner(x)));
sigma_eqv_outer_max = max(abs(sigma_eqv_outer(x)));
disp(['Maximum equivalent stress for inner surface σ_eqv_inner_max=', num2str(sigma_eqv_inner_max / (1e6)), ' MPa']);
disp(['Maximum equivalent stress for outer surface σ_eqv_outer_max=', num2str(sigma_eqv_outer_max / (1e6)), ' MPa']);
if sigma_eqv_inner_max > sigma_eqv_outer_max
    n = sigma / sigma_eqv_inner_max;
else
    n = sigma / sigma_eqv_outer_max;
end
disp(['Safety factor n=', num2str(n)]);
