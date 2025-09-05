CREATE OR REPLACE TABLE `glass-arcade-469814-k2.kaggle_bikes_eu.cycle_hire_features_with_id` AS (
SELECT
    ch.rental_id,
    ch.duration,
    ST_DISTANCE(
        ST_GEOGPOINT(start_station.longitude, start_station.latitude),
        ST_GEOGPOINT(end_station.longitude, end_station.latitude)
    ) / 1000 AS distance_km,
    EXTRACT(HOUR FROM ch.start_date) AS hour_of_day,
    CASE WHEN EXTRACT(DAYOFWEEK FROM ch.start_date) IN (1, 7) THEN 1 ELSE 0 END AS is_weekend,
    CASE WHEN ch.start_station_name = ch.end_station_name THEN 1 ELSE 0 END AS is_circular_trip
FROM
    `glass-arcade-469814-k2.kaggle_bikes_eu.cycle_hire_cleaned` AS ch
LEFT JOIN
    `bigquery-public-data.london_bicycles.cycle_stations` AS start_station
    ON ch.start_station_id = start_station.id
LEFT JOIN
    `bigquery-public-data.london_bicycles.cycle_stations` AS end_station
    ON ch.end_station_id = end_station.id
WHERE
    start_station.longitude IS NOT NULL AND start_station.latitude IS NOT NULL
    AND end_station.longitude IS NOT NULL AND end_station.latitude IS NOT NULL
);