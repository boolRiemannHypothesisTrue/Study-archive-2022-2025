a = 0.05;
R = 0.90;
delta = 4 * 10^-5;
p0 = 0.6 * 10^6;
q = 0.2 * 10^6;
m=q*a;
E = 200 * 10^9;
sigma = 240 * 10^6;
Nx = 0;
mu = 0.3;

h = p0 * R / sigma;
disp(['\nValue of h=', num2str(h), ' m\n']);
h = 8 * h;  % подобранное значение толщины чтобы выполнялся критерий прочности 
disp(['Fitted value of h=', num2str(h), ' m\n']);

D = E * h^3 / (12 * (1 - mu^2));
disp(['Cylindrical stiffness D=', num2str(D), '\n']);

k = (E * h / (4 * D * R^2))^(1 / 4);
disp(['Wave number k=', num2str(k), ' m^-1\n']);

lambda = pi / k;
disp(['Edge effect length λ=', num2str(lambda), ' m\n']);

C = [0, 1; 1, 1]; % матрица краевых условий
b = [m / (2 * D * k^2); 0];  % вектор краевых условий

consts = linsolve(C, b);
C1 = consts(1);
C2 = consts(2);
disp(['Coefficients C are:']);
disp(['C1=', num2str(C1)]);
disp(['C2=', num2str(C2), '\n']);

x = linspace(0, 2 * lambda, 100);

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

set(0,'DefaultLineLineWidth',1);
ax = gca;
ax.GridColor = 'k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';
figure('position', [0, 0, 800, 600]);

subplot(2, 2, 1);
plot(x, Mx(x) / (1e3), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$M_x(x)$, kN/m', 'Interpreter', 'latex', 'FontSize', 12);
title('Moment Mx', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

subplot(2, 2, 2);
plot(x, My(x) / (1e3), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$M_y(x)$, kN/m', 'Interpreter', 'latex', 'FontSize', 12);
title('Moment My', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

subplot(2, 2, 3);
plot(x, Ny(x) / (1e6), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$N_y(x)$, MN/m', 'Interpreter', 'latex', 'FontSize', 12);
title('Circumferential Reinforcement', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

subplot(2, 2, 4);
plot(x, Q(x) / (1e3), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$Q(x)$, kN', 'Interpreter', 'latex', 'FontSize', 12);
title('Transverse Force Q', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

figure('position', [0, 0, 800, 600]);

subplot(2, 2, 1);
plot(x, sigma_eqv_outer(x) / (1e6), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\sigma_{eqv}$, MPa', 'Interpreter', 'latex', 'FontSize', 12);
title('Equivalent Stresses for Outer Surface', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

subplot(2, 2, 2);
plot(x, sigma_eqv_inner(x) / (1e6), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\sigma_{eqv}$, MPa', 'Interpreter', 'latex', 'FontSize', 12);
title('Equivalent Stresses for Inner Surface', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

subplot(2, 2, 3);
plot(x, W(x), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$W(x)$, m', 'Interpreter', 'latex', 'FontSize', 12);
title('Deflection', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

subplot(2, 2, 4);
plot(x, phi(x), 'k');
xlabel('$x$, m', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$\phi(x)$, rad', 'Interpreter', 'latex', 'FontSize', 12);
title('Angular Displacement', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
set(gca,'DefaultLineLineWidth',1);
ax=gca;
ax.GridColor='k';
ax.GridAlpha = 0.8;
ax.GridLineStyle = '-';

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
