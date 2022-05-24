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

%% 3.1 DFT para cada segmento de sinal
experiencia = '09';
utilizador = '05';
exp = str2double(experiencia);
user = str2double(utilizador);
DFT(user, exp, xn, label, nomes_atividades)

%for i = 1:7
     % Atualizar as variaveis para ler outro ficheiro
    exp = exp+1;
    user = ceilDiv(exp,2);
    xn = load("acc_exp"+ exp+ "_user0"+ user + ".txt");
    label = load("labels.txt");
    l_index = find(label(:,1) == exp & label(:,2) == user);
    label = label(l_index, 3:end);

    DFT(user, exp, xn, label, nomes_atividades)
%end

%% 3.2 
