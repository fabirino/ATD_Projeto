%% 1 Carregar os dados

experiencia = '09';
utilizador = '05';
exp = str2double(experiencia);
user = str2double(utilizador);
nomes_atividades = ["WALK" "WALK UP" "WALK DOWN" "SIT" "STAND" "LIE" "STAND SIT" "SIT STAND" "SIT LIE" "LIE SIT" "STAND LIE" "LIE STAND"];

label = load("labels.txt");
l_index = find(label(:,1) == exp & label(:,2) == user);
label = label(l_index, 3:end);

xn = load("acc_exp"+ experiencia+ "_user"+ utilizador + ".txt");
% Variaveis
N = length(xn);
fs = 50;
Ts = 1/fs;
T0 = N * Ts;
Omega0 = (2*pi)/T0;
Ws = 2 * pi * fs;
W0 = (2 * pi) / T0;
tt = 0:Ts:(N - 1)*Ts;
tt = tt'; 

%% 2 - Representar graficamente os graficos

plotgraph(exp, user, label, xn, Ts, nomes_atividades);

% Plot para todos ficheiros
for i = 1:7
    % Atualizar as variaveis para ler outro ficheiro
    exp = exp+1;
    user = ceilDiv(exp,2);
    xn = load("acc_exp"+ exp+ "_user0"+ user + ".txt");
    label = load("labels.txt");
    l_index = find(label(:,1) == exp & label(:,2) == user);
    label = label(l_index, 3:end);

    plotgraph(exp, user, label, xn, Ts, nomes_atividades);
end

%% 3.1 DFT para cada segmento de sinal || 3.2 Frequencias Relevantes
%% 3.4 e 3.5 

experiencia = '09';
utilizador = '05';
exp = str2double(experiencia);
user = str2double(utilizador);
DFT(user, exp, xn, label, nomes_atividades)
fprintf("\n\n\n\n");
% for i = 1:7
     % Atualizar as variaveis para ler outro ficheiro
     exp = exp+1;
     user = ceilDiv(exp,2);
     xn = load("acc_exp"+ exp+ "_user0"+ user + ".txt");
     label = load("labels.txt");
     l_index = find(label(:,1) == exp & label(:,2) == user);
     label = label(l_index, 3:end);

     DFT(user, exp, xn, label, nomes_atividades);

% end

%% 3.3 Numero de passos por minuto por utilizador
% Frequencias no Eixo do X de cada user
% Walk
w5 = [1.6770  0.0000 1.8579  1.8212];
w6 = [1.713 1.7526  1.7598];
w7 = [1.7609  1.8127 1.8557  1.8480];
w8 = [1.7876  1.8667  1.7730 1.9276  1.9231];

% Walk up
wu5 = [1.5284  1.6535  1.6432 1.6835  1.6696  1.7513 ];
wu6 = [1.5695  1.6746  1.6129 1.6535];
wu7 = [1.4727  1.7327  1.7736 1.7002  1.7129  1.7129 ];
wu8 = [1.8325  1.8584 1.8072  1.9608  1.8591];

% Walk down
wd5 = [0.0000  1.6935  1.8103 1.8072];
wd6 = [1.7736  1.8041  1.7949 1.7766  0.0000  1.7766];
wd7 = [1.4583  1.5949  1.8784 1.7617  1.8919];
wd8 = [1.7889  2.0588  2.0154 2.2869  2.1053 2.0790];

% Totais
w = [w5 w6 w7 w8];
wu = [wu5 wu6 wu7 wu8];
wd = [wd5 wd6 wd7 wd8];

% No passos
step_5 = mean(w5) * 60;
step_6 = mean(w6) * 60;
step_7 = mean(w7) * 60;
step_8 = mean(w8) * 60;

step_u5 = mean(wu5) * 60;
step_u6 = mean(wu6) * 60;
step_u7 = mean(wu7) * 60;
step_u8 = mean(wu8) * 60;

step_d5 = mean(wd5) * 60;
step_d6 = mean(wd6) * 60;
step_d7 = mean(wd7) * 60;
step_d8 = mean(wd8) * 60;

% Media e Desvio Padrao
media = mean(w) * 60;
mediaU = mean(wu) * 60;
mediaD = mean(wd) * 60;

desvio = std(w) * 60;
desvioU = std(wu) * 60;
desvioD = std(wd) * 60;

%% 4.1

N = length(xn);
% Dividir o sinal em segmentos de tamanho 30 (30 obtido por tentativas)
Nframe = floor(N/30);
freq_rel = [];
t_frames = [];


if (mod(Nframe,2) == 0)
    f_frame = (-fs/2):fs/Nframe:(fs/2) - fs/Nframe;
else
    f_frame = (-fs/2)+(fs/(2*Nframe)):fs/Nframe:(fs/2)-(fs/(2*Nframe));
end

% Janela retangular
for i = 1:Nframe:N-Nframe+1
    % considerar apenas o eixo dos z
    x_frame = xn(i:i+Nframe-1, 3);
    m_x_frame = abs(fftshift(fft(x_frame)));
    m_x_frame_max = max(m_x_frame(abs(f_frame) > 0.01));

    x = find(m_x_frame == m_x_frame_max);
    t_frame = tt(i:i+Nframe+1);

    freq_rel = [freq_rel f_frame(x)];
    % time corresponding to the middle sample of the window
    t_frames = [t_frames t_frame(round(Nframe/2)+1)];

end

freq_rel = freq_rel(freq_rel > 0);

figure;
stem(t_frames, freq_rel);
xlabel("Time (s)");
ylabel("Frequency (Hz)");
title("Janela Retangular (exp:" + exp+ ", user:" + user + ")");

% Janela de Hamming
Tframe = 0.128; % largura da janela de análise em s
Toverlap = 0.064; % sobreposiçao das janelas em s
Nframe = round(Tframe*fs); % número de amostras na janela
Noverlap = round(Toverlap*fs); % número de amostras sobrepostas na janela

h = hamming(Nframe); % janela de hamming

figure;
plot(0:Nframe-1,h)
axis tight
xlabel('n')
title("Janela de Hamming(exp:" + exp+ ", user:" + user + ")")


