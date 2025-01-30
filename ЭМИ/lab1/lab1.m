% Constants
d = 0.0044;
D = 0.0079;
F0 = 0.25 * pi * (d^2);

DM = [0.466, 0.465, 0.489, 0.466, 0.474, 0.481];

TAU = [11.92, 12.39, 13.74, 17.87, 21.88, 40.01]; % Time to spill
H1 = [1.200, 1.05, 0.9, 0.75, 0.6, 0.455]; % Height of first pipe
H2 = [0.46, 0.45, 0.445, 0.435, 0.42, 0.405]; % Height of second pipe

% Calculations
DH = H1 - H2; % Counting DH
FREQ = [2.6, 2.3, 2, 1.6, 1.15, 0.4]; % Turbine frequency
AIR_DENSITY = 1.161;
WATER_DENSITY = 998.520; % Mean
DP = 9.805 * DH .* (WATER_DENSITY - AIR_DENSITY); % Counting Pressure Diff
GEXP = DM ./ TAU; % Counting GEXP
ALPHA = GEXP ./ (F0 .* sqrt(2 * WATER_DENSITY * DP)); % Counting ALPHA
RE = (4 .* GEXP) ./ (pi * D * 0.001056); % Counting RE (DynViscosityCoeff)

% Create Table
S_result = table(DM', TAU', DH', FREQ', GEXP', DP', ALPHA', RE', ...
    'VariableNames', {'M_kg', 'T_s', 'DH_m', 'FREQ_Hz', 'G_kg_s', 'DP_Pa', 'Alpha', 'Re'});
disp(S_result);

% Polynomial Fit
a = polyfit(RE, ALPHA, 3);
ALPHAFIT = @(x) polyval(a, x);
x = linspace(min(RE), max(RE), 100);

% Plot
figure;
plot(RE, ALPHA, 'o', 'MarkerSize', 5, 'DisplayName', 'EXPERIMENT');
hold on;
plot(x, ALPHAFIT(x), 'DisplayName', 'POLYFIT');
xlabel('Re', 'FontSize', 12);
ylabel('Alpha', 'FontSize', 12);
grid on;
legend show;
hold off;

% GEXP Error Calculation
GEXPMEAN = mean(GEXP);
deltarand = sum((GEXP - GEXPMEAN).^2);
deltarand = 2.57058183661 * deltarand / 30;
deltagexp = sqrt((0.001 + 0.01)^2 + deltarand^2);
disp(['GEXP Error: ', num2str(deltagexp)]);

% ROTAMETER
DMROT = [0.484, 0.484, 0.482, 0.487, 0.484, 0.469];
TAUROT = [40, 30.32, 13.46, 10.56, 8, 6.39]; % Time to spill
GEXPROT = 3600000 * DMROT ./ (TAUROT * WATER_DENSITY); % Counting GEXP
FREQROT = [0, 1.2, 2.2, 2.9, 3.9, 4.8]; % FREQ
SCALE = [0, 20, 40, 60, 80, 100]; % SCALE

% Linear Fit
B = polyfit(SCALE, GEXPROT, 1);
ALPHA_FIT = polyval(B, SCALE);

% Plot
figure;
plot(SCALE, GEXPROT, 'o', 'MarkerSize', 5, 'DisplayName', 'EXPERIMENT');
hold on;
plot(SCALE, ALPHA_FIT, 'DisplayName', 'POLYFIT');
xlabel('Scale', 'FontSize', 12);
ylabel('V, l/h', 'FontSize', 12);
grid on;
legend show;
hold off;

% Create Table
S_result_rot = table(DMROT', TAUROT', FREQROT', GEXPROT', ...
    'VariableNames', {'M_kg', 'T_s', 'FREQ_Hz', 'V_l_h'});
disp(S_result_rot);

% ROTAMETER Errors
deltagexp = max(abs(GEXPROT - polyval(B, SCALE)));
disp(['ROTAMETER Error: ', num2str(deltagexp)]);

% ROTAMETER Reference Errors
SPRAVKA = [20, 46, 76, 107, 140, 171]; % Reference SCALE
deltagexp = max(abs(GEXPROT - SPRAVKA));
disp(['ROTAMETER Reference Error: ', num2str(deltagexp)]);
