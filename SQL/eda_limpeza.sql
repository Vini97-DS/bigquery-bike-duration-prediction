CREATE OR REPLACE TABLE `glass-arcade-469814-k2.kaggle_bikes_eu.cycle_hire_cleaned` AS (
  SELECT
    *
  FROM
    `bigquery-public-data.london_bicycles.cycle_hire`
  WHERE
    duration BETWEEN 60 AND 86400
);