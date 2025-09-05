# Previsão da Duração de Viagens de Bicicleta com BigQuery ML

## Descrição
Este projeto, parte do "BigQuery AI Hackathon" do Kaggle, tem como objetivo construir um modelo de Machine Learning para prever a duração em segundos de viagens no sistema de aluguel de bicicletas de Londres. Todo o processo, da análise à modelagem, foi realizado utilizando ferramentas da Google Cloud Platform, principalmente o BigQuery e o BigQuery ML.

## Ferramentas Utilizadas
- **Google BigQuery:** Para armazenamento, processamento de dados e análise exploratória.
- **BigQuery ML (BQML):** Para treinamento e avaliação dos modelos de Machine Learning diretamente com SQL.
- **Google Cloud Storage (GCS):** Para exportação do resultado final em grande escala.
- **SQL:** Linguagem principal para todas as etapas do projeto.
- **Python:** Para a etapa final de submissão no ambiente Kaggle.

## Processo do Projeto

### 1. Análise Exploratória e Limpeza
Análise de um dataset com mais de 83 milhões de linhas. Principais descobertas:
- Identificação e remoção de outliers (durações negativas ou excessivamente longas).
- Descoberta de um forte padrão de uso para **lazer** (viagens circulares em parques, com maior duração nos fins de semana) em contraste com o uso para **transporte** (viagens mais curtas e em horários de pico durante a semana).

### 2. Engenharia de Features
Criação de variáveis preditivas para o modelo, incluindo:
- `distance_km`: Distância geoespacial em linha reta entre a estação de início e fim.
- `hour_of_day`: Hora do dia do início da viagem.
- `is_weekend`: Variável binária para identificar fins de semana.
- `is_circular_trip`: Variável binária para identificar viagens de lazer (início e fim na mesma estação).

### 3. Modelagem e Avaliação
Foram treinados e comparados dois modelos usando BigQuery ML:
1.  **Modelo Baseline (Regressão Linear):** Obteve um RMSE de **~1634 segundos**.
2.  **Modelo Avançado (Boosted Tree Regressor):** Superou o baseline, alcançando um RMSE de **~1626 segundos**.

### 4. Geração do Resultado
A previsão final foi gerada para um conjunto de teste de 5% dos dados (holdout) e o resultado, um arquivo CSV com mais de 3 milhões de linhas, foi exportado via Google Cloud Storage.

## Desafios e Aprendizados
Um dos maiores desafios foi lidar com as restrições de localidade de dados entre a Europa e os EUA no BigQuery, exigindo a criação de datasets em regiões específicas e o uso do GCS para a exportação de dados. Além disso, a biblioteca de submissão do Kaggle (`bq_helper`) se mostrou instável, o que nos levou a construir um pipeline de treino/teste/previsão manual e mais robusto.