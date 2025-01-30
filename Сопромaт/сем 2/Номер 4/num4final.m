E = 200e9;
m = 0.3;
h = 0.08;
r1 = 0.3;
r2 = 1.4;
sigma = 240e6;

D = E * h^3 / (12 * (1 - m^2));

C = [1, r2^2, log(r2), log(r2) * r2^2;
     0, 2*r2, 1/r2, 2*r2*log(r2)+r2;
     0, 2*r1, 1/r1, 2*r1*log(r1)+r1;
     0, 0, 0, 4/r1];

b = [r2^4/(64*D); r2^3/(16*D); r1^3/(D*16); 1/(2*D)*r1];

consts = linsolve(C, b);
C1 = consts(1);
C2 = consts(2);
C3 = consts(3);
C4 = consts(4);


W = @(C1, C2, C3, C4, D, r, p) ((C1 + C2*r.^2 + C3*log(r) + C4*log(r).*r.^2).*p - r.^4.*p./(64*D));
W1 = @(C2, C3, C4, D, r) (2*r*C2 + C3./r + C4.*(2*r.*log(r) + r) - r.^3./(16*D));
W2 = @(C2, C3, C4, D, r) (2*C2 - 1./r.^2.*C3 + C4.*(3 + 2*log(r)) - r.^2*3./(16*D));
M_r = @(W2, W1, r, D, m) (D*(W2(C2, C3, C4, D, r) + m./r.*W1(C2, C3, C4, D, r)));
M_theta = @(W2, W1, r, D, m) (D*(m*W2(C2, C3, C4, D, r) + 1./r.*W1(C2, C3, C4, D, r)));

sigma_r = @(M_r, h, r, D, m) (6*M_r(W2, W1, r, D, m)./h^2);
sigma_theta = @(M_theta, h, r, D, m) (6*M_theta(W2, W1, r, D, m)./h^2);
sigma_eqv = @(sigma_r, sigma_theta) (sqrt(sigma_r.^2 + sigma_theta.^2 - sigma_r .* sigma_theta));

sigma_eqv_max = sigma_eqv(sigma_r(M_r, h, r2, D, m), sigma_theta(M_theta, h, r2, D, m));
p = sigma / (sigma_eqv_max * 10^6);
disp(p)
tiledlayout(2,2)

r_vals = linspace(r1, r2, 50);
titles = {'Distribution of $M_r$', 'Distribution of $M_{\theta}$', 'Equivalent Stress Distribution', 'Deflection at Maximum Allowable Load'};
ylabels = {'$M_r$', '$M_{\theta}$', '$\sigma_{\text{eqv}}$', 'Deflection $W$'};
functions = {@(r) M_r(W2, W1, r, D, m), @(r) M_theta(W2, W1, r, D, m), @(r) sigma_eqv(sigma_r(M_r, h, r, D, m), sigma_theta(M_theta, h, r, D, m)), @(r) W(C1, C2, C3, C4, D, r, p)};

for i = 1:4
    nexttile
    plot(r_vals, functions{i}(r_vals))
    title(titles{i}, 'Interpreter', 'latex')
    xlabel('Radius $r$ (m)', 'Interpreter', 'latex')
    ylabel(ylabels{i}, 'Interpreter', 'latex')
    grid on
    grid minor
    set(0,'DefaultLineLineWidth',1)
    ax=gca;
    ax.GridColor='k';
    ax.GridAlpha = 0.8;
    ax.GridLineStyle = '-';
end
