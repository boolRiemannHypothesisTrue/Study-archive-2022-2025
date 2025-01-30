% ���������
Bi_x = 0.21803279; % ��������� Bi_x (��� �������� �������)

% ������ �������� ��� mu (�������� ��� ��� X)
mu = linspace(18, 19, 100000);

% ���������� �������� ������������������ ���������
char_eqn_values1 = cot(mu);   % ������� cot(mu)
char_eqn_values2 = mu / Bi_x; % �������� ������� mu / Bi_x

% ������ ������
figure;
plot(mu, char_eqn_values1, 'r', 'LineWidth', 1.5); % ������ cot(mu) (�������)
hold on;
plot(mu, char_eqn_values2, 'b', 'LineWidth', 1.5); % ������ mu / Bi_x (�����)
xlabel('$\mu$', 'Interpreter', 'latex'); % ������� ��� X (LaTeX)
ylabel('$\cot(\mu)$ & $\mu/Bi_x$', 'Interpreter', 'latex'); % ������� ��� Y (LaTeX)
title('$\cot(\mu)$ & $\mu/Bi_x$', 'Interpreter', 'latex'); % ��������� (LaTeX)
legend('$\cot(\mu)$', '$\mu/Bi_x$', 'Location', 'NorthWest', 'Interpreter', 'latex'); % ������� (LaTeX)
ylim([-100, 150]);  % ����������� ��� Y
grid on;

% ������������� ������� ��� �������� ������
mu_x_values = [];  % ������ ��� �������� ������

% �����������
tolerance = 0.1;

% ����� ������ ������� fzero
for i = 1:length(mu)-1
    % �������� �� ��������� ����� ����� ��������� ����������
    if sign(char_eqn_values1(i) - char_eqn_values2(i)) ~= sign(char_eqn_values1(i+1) - char_eqn_values2(i+1))
        % ���������� fzero ��� ���������� ����� �� ���������� [mu(i), mu(i+1)]
        mu_x = fzero(@(x) cot(x) - x / Bi_x, [mu(i), mu(i+1)]);
        mu_x_values = [mu_x_values, mu_x];  % ��������� ��������� ������
    end
end

% ���������� ������, ������� � ������ ��������
mu_cot_zeros = pi * (1:floor(25/pi)); % ����� ������� cot(mu) �� ��������� [0, 25]

% ��������������� �������� (��� ����������� ������ ������ ������)
filtered_mu_x_values = mu_x_values(mu_x_values ~= 0);
filtered_mu_x_values = filtered_mu_x_values(1:2:end); % �������� ������� ������� ��������

% ������� �����, ���������� � ����� �������
filtered_mu_x_values = filtered_mu_x_values(~ismember(filtered_mu_x_values, mu_cot_zeros));

% ������ ��������������� ������
disp('��������� ����� (�� ������ ��������):');
disp(filtered_mu_x_values);  

% ����������� ������ �� ������� (��� ����� ��������)
for i = 1:length(filtered_mu_x_values)
    mu_root = filtered_mu_x_values(i);
    y_root = mu_root / Bi_x;  % �������� ������� � ����� �����
    plot(mu_root, y_root, 'ko', 'MarkerFaceColor', 'w'); % 'ko' ��� ������� �����
end

% ���������� �������� � ������ �������� (��� cot(mu) = NaN)
for i = 1:length(mu_cot_zeros)
    plot([mu_cot_zeros(i), mu_cot_zeros(i)], ylim, 'k--', 'LineWidth', 1.5);  % ������ ���������� ������������ �����
end
