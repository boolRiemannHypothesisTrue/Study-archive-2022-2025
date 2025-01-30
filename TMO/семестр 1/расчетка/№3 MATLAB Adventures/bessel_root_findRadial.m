% ���������
Bi_r = 0.11290323; % ��������� B_r (��� �������� �������)

% ������ �������� ��� mu (�������� ��� ��� X)
mu = linspace(0, 20, 100000);

% ���������� �������� ������������������ ���������
char_eqn_values1 = besselj(0, mu) ./ besselj(1, mu);  % ��������� �������
char_eqn_values2 = mu / Bi_r;  % �������� ������� mu / Bi_r

% ������ ������
figure;
plot(mu, char_eqn_values1, 'b-', 'LineWidth', 1.5); % ������ ��������� ������� (�����)
hold on;
plot(mu, char_eqn_values2, 'r--', 'LineWidth', 1.5); % ������ �������� ������� (�������)
xlabel('\epsilon');
ylabel('');
title('(J_0(\epsilon))/(J_1(\epsilon)) & \epsilon/Bi_r');
legend('(J_0(\epsilon))/(J_1(\epsilon))', '\epsilon/Bi_r', 'Location', 'NorthWest');
ylim([-100, 150]);
grid on;

% �������� ��� ������ �����������
tolerance = 0.1; 

% ������������� ������� ��� �������� ��������� ������
mu_r_values = zeros(1, 15); % ������ ��� �������� ������
index = 1;

% ������� ���������
disp([' ']);
disp([char(9733) ' ����� ������������������� ��������� ' char(9733)]);
disp('�� ������� ��������:');

% ���� ������ ������ ������� fzero
for i = 1:length(mu)-1
    % �������� �� ��������� ����� ����� ��������� ����������
    if sign(char_eqn_values1(i) - char_eqn_values2(i)) ~= sign(char_eqn_values1(i+1) - char_eqn_values2(i+1))
        % ���������� fzero ��� ���������� ����� �� ���������� [mu(i), mu(i+1)]
        mu_r = fzero(@(x) besselj(0, x) / besselj(1, x) - x / Bi_r, [mu(i), mu(i+1)]);
        mu_r_values(index) = mu_r;  % ��������� ��������� ������
        index = index + 1;  % ��������� � ���������� �������
    end
end

% ����� ������ ��� ����������� (���� ����� �� ����� ����)
filtered_mu_r_values = mu_r_values(mu_r_values ~= 0);

% ��������� ����� �� �������� (��������, 2, 4, 6, 8, 10, 12, 14)
exclude_indices = [2, 4, 6, 8, 10, 12, 14];
filtered_mu_r_values = filtered_mu_r_values(~ismember(1:length(filtered_mu_r_values), exclude_indices));

% ����� ��������������� ��������
disp('��������� ����� (����� ���������� ������):');
disp(filtered_mu_r_values);

% ����������� ������ �� �������
% ��������� ������ �� �� �����, ��� ����������� �����
