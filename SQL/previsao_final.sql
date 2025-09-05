CREATE OR REPLACE MODEL `glass-arcade-469814-k2.kaggle_bikes_eu.final_model_trained_on_split`
OPTIONS(model_type='BOOSTED_TREE_REGRESSOR', input_label_cols=['duration']) AS
SELECT
    * EXCEPT(rental_id) -- O ID da viagem é removido, pois não deve ser usado para treinar
FROM
    `glass-arcade-469814-k2.kaggle_bikes_eu.cycle_hire_features_with_id`
WHERE
    -- A função FARM_FINGERPRINT cria uma divisão aleatória e reprodutível dos dados
    ABS(MOD(FARM_FINGERPRINT(CAST(rental_id AS STRING)), 20)) < 19; -- Usa ~95% dos dados (19/20)