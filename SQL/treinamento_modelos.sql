EXPORT DATA
OPTIONS(
  -- ATENÇÃO: Substitua [NOME_DO_SEU_BUCKET] pelo nome do seu bucket no GCS
  uri='gs://[NOME_DO_SEU_BUCKET]/submission-*.csv',
  format='CSV',
  overwrite=true,
  header=true
) AS (
  SELECT
      rental_id AS id, -- Renomeia 'rental_id' para 'id' para atender ao formato do Kaggle
      CAST(predicted_duration AS INT64) AS duration
  FROM
    ML.PREDICT(
      MODEL `glass-arcade-469814-k2.kaggle_bikes_eu.final_model_trained_on_split`,
      (
        SELECT
          *
        FROM
          `glass-arcade-469814-k2.kaggle_bikes_eu.cycle_hire_features_with_id`
        WHERE
          -- Seleciona os ~5% de dados restantes (1/20) para a previsão
          ABS(MOD(FARM_FINGERPRINT(CAST(rental_id AS STRING)), 20)) >= 19
      )
    )
);