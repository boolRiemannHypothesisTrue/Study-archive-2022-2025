% Параметры сигнала
Fs = 1000; % Частота дискретизации
t = 0:1/Fs:1; % Временной интервал от 0 до 1 секунды
f = 5; % Частота сигнала в Гц (уменьшена для медленных колебаний)

% Входной сигнал амплитудой 10 мВ
Vin1 = 0.01; % Амплитуда входного сигнала, 10 мВ
Vout1 = 10 * Vin1 * sin(2 * pi * f * t); % Усиленный выходной сигнал

% Входной сигнал амплитудой 500 мВ
Vin2 = 0.5; % Амплитуда входного сигнала, 500 мВ
Vout2 = 10 * Vin2 * sin(2 * pi * f * t); % Усиленный сигнал
Vout2(Vout2 > 1) = 1; % Ограничение сверху
Vout2(Vout2 < -1) = -1; % Ограничение снизу

% Данные для амплитудной характеристики
Uinput = [0,10, 20, 30, 40, 50, 60, 70, 80, 90];
Uoutput = [0,0.48, 0.95, 1.431, 1.868, 2.307, 2.728, 3.127, 3.503, 3.851];
% Рофло-расчеты
Ibase1=0.1088;Ibase2=0.0924;Icollector1=4.23;Icollector2=3.7;Ubase1=0.186;Ubase2=0.181;Ucollector1=6.07;Ucollector2=6.9;Ecollector=12.5;
h11=abs((Ubase2-Ubase1)/(Ibase2-Ibase1))*1000 %Входное сопротивление транзистора,Ом
h12=abs((Ubase2-Ubase1)/(Ucollector2-Ucollector1)) %Коэффициент обратной связи по напряжению,Безразмерная 
h21=abs((Icollector2-Icollector1)/(Ibase2-Ibase1))*1000 %Коэффициент передачи по току,Безразмерная 
h22=abs((Icollector2-Icollector1)/(Ubase2-Ubase1))/1000 % Выходная проводимость,См
Rcollector=(Ecollector-Ucollector2)/Icollector2 *1000 %Сопротивление коллектора,Ом
Kampl=h21*Rcollector/h11 % Коэффициент усиления
fmax=72000;%Верхний частотный предел,Гц 
fmin=10.8;%Нижний частотный предел,Гц
df=fmax-fmin % Полоса пропускания,Гц 
% Построение графиков
figure;

% График для 10 мВ
subplot(3, 1, 1);
plot(t, Vout1, 'k', 'LineWidth', 1);
title('$Output\ signal\ for\ input\ voltage\ of\ 10\ mV$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Voltage\ (V)$', 'Interpreter', 'latex');
grid on;

% График для 500 мВ
subplot(3, 1, 2);
plot(t, Vout2, 'k', 'LineWidth', 1);
title('$Output\ signal\ for\ input\ voltage\ of\ 500\ mV$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Voltage\ (V)$', 'Interpreter', 'latex');
grid on;

% График амплитудной характеристики
subplot(3, 1, 3);
plot( Uinput,Uoutput, 'k', 'LineWidth', 1);
title('$Amplitude\ characteristic\ of\ the\ amplifier\ at\ 1\ kHz\ (no\ load\ mode)$', 'Interpreter', 'latex');
ylabel('$Output\ Voltage\ (V)$', 'Interpreter', 'latex');
xlabel('$Input\ Voltage\ (mV)$', 'Interpreter', 'latex');
grid on;
