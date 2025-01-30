% ���������
Bi_r = 0.24098361; % ��������� B_r (��� �������� �������)

% ������ �������� ��� mu (�������� ��� ��� X)
mu = linspace(0.1, 21, 1000);

% ���������� �������� ������������������ ���������
char_eqn_values1 = besselj(0, mu) ./ besselj(1, mu);  % ��������� �������
char_eqn_values2 = mu / Bi_r;  % �������� ������� mu / Bi_r

% �������� �������� �� NaN � ������ ������� ��� J_1(mu) = 0
mu_j1_zeros = [3.8317, 7.0156, 10.1735, 13.3237, 16.4706, 19.6159]; % ��� �������� ��� J_1(mu) = 0
for i = 1:length(mu_j1_zeros)
    % ������� ������ ������� mu, ������� ������������� ����� �������
    [~, idx] = min(abs(mu - mu_j1_zeros(i)));
    char_eqn_values1(idx) = NaN;  % ����������� NaN � ����� �������
end

% ������ ������
figure;
plot(mu, char_eqn_values1, 'b', 'LineWidth', 1.5); % ������ ��������� ������� (�������)
hold on;
plot(mu, char_eqn_values2, 'k', 'LineWidth', 1.5); % ������ �������� ������� (������)
xlabel('\epsilon');
ylabel('');
title('(J_0(\epsilon))/(J_1(\epsilon)) & \epsilon/Bi_r');
legend('(J_0(\epsilon))/(J_1(\epsilon))', '\epsilon/Bi_r', 'Location', 'NorthWest');
ylim([-100, 150]);
grid on;

% ��������� ����� �����������
known_roots = [0.6739, 3.8940, 7.0498, 10.1971, 13.3418, 16.4853, 19.6281]; % ��������� �����
for i = 1:length(known_roots)
    mu_root = known_roots(i);
    y_root = besselj(0, mu_root) / besselj(1, mu_root);  % �������� ������� � ����� �����
    plot(mu_root, y_root, 'ko', 'MarkerFaceColor', 'w'); % 'ko' ��� ������� �����
end

% ���������� �������� � ������ �������� (J_1(mu) = 0)
for i = 1:length(mu_j1_zeros)
    plot([mu_j1_zeros(i), mu_j1_zeros(i)], ylim, 'k--', 'LineWidth', 1.5);  % ������� ���������� ������������ �����
end
