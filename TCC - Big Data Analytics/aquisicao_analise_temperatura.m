%% Aquisição e analise de dados de um sensor de temperatura

clear
clc

%% Conectar ao Arduino

% Use o comando arduino para se conectar a um dispositivo Arduino.
a = arduino;

%% Medição de temperatura
% O datasheet do sensor de temperatura LM35 nos diz que a leitura de tensão
% é diretamente proporcional à temperatura em graus Celsius, com um deslo-
% camento de 0,5V e um fator de escala de 10 mV/°C (equivalente a 100°C/V).
% Portanto, a conversão pode ser representada como: $T_C = (V-0.05)*100$
%
% Podemos ler a tensão de saída, convertá-la para Celsius e converter o
% resultado para Fahrenheit da seguinte forma:

v = readVoltage(a,'A0');
TempC = (v-0.05)*100;
TempF = 9/5*TempC + 32;
fprintf('Leitura de temperatura:\n  %.1f °C\n  %.1f °F\n',TempC,TempF)

%% Registre e plote 10 segundos de dados de temperatura
ii = 0;
TempC = zeros(1e4,1);
t = zeros(1e4,1);

tic
while toc < 10
    ii = ii + 1;
    % Ler o valor atual da tensão
    v = readVoltage(a,'A0');
    % Calcular a temperatura da tensão (com base no datasheet)
    TempC(ii) = (v-0.05)*100;
    TempF = 9/5*TempC + 32;
    % Obter o tempo desde o início
    t(ii) = toc;
end

% Pós-processamento e plotagem dos dados. Primeiro remova qualquer excesso
% de zeros nas variáveis de log.

TempC = TempC(1:ii);
t = t(1:ii);

% Temperatura da plotagem versus tempo
figure
plot(t,TempC,'-o')
xlabel('Tempo decorrido (seg)')
ylabel('Temperatura (\circC)')
title('Variação da temperatura em dez segundos')
set(gca,'xlim',[t(1) t(ii)])

%% Cálculo da taxa de aquisição

timeBetweenDataPoints = diff(t);
averageTimePerDataPoint = mean(timeBetweenDataPoints);
dataRateHz = 1/averageTimePerDataPoint;
fprintf('Adquirido um ponto de dados por %.3f segundos (%.f Hz)\n',... 
    averageTimePerDataPoint,dataRateHz)

%% Por que meus dados são tão instáveis?

measurableIncrementV = 5/1023;
measurableIncrementC = measurableIncrementV*100;
measurableIncrementF = measurableIncrementC*9/5;
fprintf('O menor incremento mensurável desse sensor pelo Arduino é\n %-6.4f V\n %-6.2f°C\n %-6.2f°F\n',... 
    measurableIncrementV,measurableIncrementC,measurableIncrementF);

%% Adquira e exiba dados ao vivo

figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [20 40];

stop = false;
startTime = datetime('now');
while ~stop
    % Ler o valor atual da tensão
    v = readVoltage(a,'A0');
    % Calcular a temperatura da tensão (com base no datasheet)
    TempC = (v-0.05)*100;
    TempF = 9/5*TempC + 32;    
    % Obter hora atual
    t =  datetime('now') - startTime;
    % Adicionar pontos à animação
    addpoints(h,datenum(t),TempC)
    % Atualizar eixos
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    % Verifique a condição de parada
    stop = readDigitalPin(a,'D12');
end

%% Plote os dados gravados

[timeLogs,tempLogs] = getpoints(h);
timeSecs = (timeLogs-timeLogs(1))*24*3600;
figure
plot(timeSecs,tempLogs)
xlabel('Tempo decorrido (seg)')
ylabel('Temperatura (\circC)')

%% Suavizar leituras com filtro de média móvel

smoothedTemp = smooth(tempLogs,25);
tempMax = smoothedTemp + 2*9/5;
tempMin = smoothedTemp - 2*9/5;

figure
plot(timeSecs,tempLogs, timeSecs,tempMax,'r--',timeSecs,tempMin,'r--')
xlabel('Tempo decorrido (seg)')
ylabel('Temperatura (\circC)')
hold on 

%%
% Plote o sinal de temperatura original e suavizado e ilustre a incerteza.

plot(timeSecs,smoothedTemp,'r')

%% Salvar resultados em um arquivo

T = table(timeSecs',tempLogs','VariableNames',{'Time_seg','Temp_C'});
filename = 'Dados_de_Temperatura.xlsx';
% Gravar tabela em arquivo
writetable(T,filename)
% Imprimir confirmação na linha de comando
fprintf('Tabela de resultados com %g de medições de temperatura salvas no arquivo %s\n',...
    length(timeSecs),filename)
