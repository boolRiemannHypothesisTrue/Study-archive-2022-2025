% System parameters
f = 50;          % Frequency of input voltage (Hz)
Vm = 100;        % Amplitude of input voltage (V)
R = 10;          % Load resistance (Ohms)
C = 1000000e-6;     % Capacitance of the filter (Farads)
T = 1 / f;       % Period of signal (s)

% Time vector
t = 0:1e-5:2*T;  % Time (two periods)

% Input sinusoidal voltage (voltage on the secondary winding of the transformer)
u2 = Vm * sin(2 * pi * f * t);

% Rectified output voltage (non-filtered)
uload = max(u2, 0);  % Only positive values

% Initialize voltage across the capacitor (u_load) and current
u_load = zeros(size(t));  % Output voltage (filtered)
tau = R * C;              % Time constant of the RC circuit

% Simulate the filtered output using an ideal peak-detection approach
for i = 2:length(t)
    if uload(i) > u_load(i - 1)  % Charging (follows the input when it is higher)
        u_load(i) = uload(i);
    else  % Discharging through R-C circuit (follows exponential decay)
        u_load(i) = u_load(i - 1) * exp(-1e-5 / tau);
    end
end

% Plotting the graphs
figure;

% Input voltage u2 plot
subplot(3, 1, 1);
plot(t, u2, 'k', 'LineWidth', 1.5);  % 'r' stands for red color
title('$u_{2}(t)$: Input voltage (secondary transformer winding)', 'Interpreter', 'latex', 'FontSize', 12);
xlabel('Time $t$ (s)', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$u_{2}(t)$ (V)', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;
% Rectified output voltage uload plot (non-filtered)
subplot(3, 1, 2);
plot(t, uload, 'k', 'LineWidth', 1.5);  % 'b' stands for blue color
title('$u_{load}(t)$: Output voltage (non-filtered)', 'Interpreter', 'latex', 'FontSize', 12);
xlabel('Time $t$ (s)', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$u_{load}(t)$ (V)', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;

% Rectified output voltage uload with filter plot
subplot(3, 1, 3);
plot(t, u_load, 'k', 'LineWidth', 1.5);  % 'g' stands for green color
title('$u_{load}(t)$: Output voltage with C-filter', 'Interpreter', 'latex', 'FontSize', 12);
xlabel('Time $t$ (s)', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$u_{load}(t)$ (V)', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor;

% Adjust all subplots to have aligned time axes
linkaxes(findall(gcf, 'Type', 'Axes'), 'x');
