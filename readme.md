# TCC - BIG DATA ANALYTICS: UMA APLICAÇÃO DE COLETA DE DADOS DE UM SENSOR DE TEMPERATURA COM ARDUINO E MATLAB

## Introdução

Este é o meu Trabalho de Conclusão de Curso desenvolvido com MATLAB para coletar, armazenar e analisar dados de um sensor de temperatura, conectado a um dispositivo Arduino. O código permite a medição precisa da temperatura ambiente, a visualização dos dados em tempo real e a análise posterior dos registros e gerar insights (compreensão, conhecimento, discernimento,) relevantes.

## Sobre o Projeto

O objetivo deste projeto é demonstrar como adquirir dados de um sensor de temperatura usando um Arduino e, em seguida, analisar esses dados no MATLAB. O código cobre os seguintes aspectos:

- Conexão ao Arduino: O código estabelece uma conexão com o Arduino, permitindo a leitura dos dados do sensor de temperatura.
- Medição e Conversão de Temperatura: O script realiza a conversão da tensão lida do sensor LM35 para valores de temperatura em graus Celsius e Fahrenheit, de acordo com as especificações do datasheet.
- Aquisição e Análise de Dados: O código registra e plota dados de temperatura em tempo real, permitindo a observação das variações ao longo de um intervalo de tempo definido.
- Suavização de Dados: O código também demonstra como aplicar um filtro de média móvel aos dados registrados para reduzir o ruído e visualizar tendências mais claras.
- Exportação de Dados: Além disso, os dados registrados podem ser exportados para um arquivo Excel (.xlsx) para análises posteriores ou relatórios.

## Requisitos 

- MATLAB R2014b ou superior
- MATLAB Support Package for Arduino Hardware

## Como usar 

Para executar o códigog em seu próprio sistema, siga estas etapas:

### 1. Preparação do Hardware:

- Monte o circuito arduino como na imagem abaixo.
- Certifique-se de que o Arduino esteja conectado ao computador.
- Clonar ou Baixar o Repositório:

<div align="center">
  <br><img src="https://github.com/user-attachments/assets/74d9f44d-0c55-44d6-a0a0-f1d3f0189a5f" aling=center>
</div>

### 2. Executar o Código:

- Abra o arquivo aquisicao_analise_temperatura.m no MATLAB.
- Certifique-se de que o Arduino esteja conectado ao computador e identificado pelo MATLAB.
- Execute o script. Você pode fazer isso pressionando o botão "Run" (Executar) no ambiente MATLAB ou digitando `run aquisicao_analise_temperatura` no prompt de comando.

### 3. Aquisição de Dados e Visualização em Tempo Real:

- Siga as instruções apresentadas pelo código. Ele irá realizar a aquisição de dados de temperatura em tempo real por um período de 10 segundos.
- Durante esse período, você verá um gráfico que mostra a variação da temperatura em relação ao tempo.

### 4. Exportação de Dados:

- Os dados registrados podem ser exportados para um arquivo Excel (.xlsx) para análises futuras. O arquivo será salvo com o nome `Dados_de_Temperatura.xlsx`.

### 5. Parar a Aquisição:

- Durante a aquisição em tempo real, você pode parar o processo pressionando um botão físico conectado ao Arduino (pino D12).

## Personalização

Você pode personalizar o código e as configurações de acordo com seus requisitos específicos. Por exemplo, em vez de exportar os dados para um arquivo Excel, você pode implementar um sistema de armazenamento em banco de dados para permitir uma análise mais avançada, consulta e recuperação de dados históricos. Você pode implementar notificações por email, mensagens de texto ou notificações via aplicativo sempre que certos eventos ocorrerem, como atingir uma temperatura crítica, entre outras.

## Contribuições

Contribuições são sempre bem-vindas! Se você tiver sugestões de melhorias, correções de bugs ou novas funcionalidades, sinta-se à vontade para abrir um pull request. 👨‍💻📚
