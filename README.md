# Bike Trip Duration Prediction with BigQuery ML

### Description

This project, part of Kaggle's "BigQuery AI Hackathon," aims to build a Machine Learning model to predict the duration in seconds of trips in London's bike rental system. The entire process, from analysis to modeling, was conducted using Google Cloud Platform tools, primarily BigQuery and BigQuery ML.

### Tools Used

* Google BigQuery: For data storage, processing, and exploratory analysis.

* BigQuery ML (BQML): For training and evaluating Machine Learning models directly with SQL.

* Google Cloud Storage (GCS): For the large-scale export of the final result.

* SQL: The primary language for all project stages.

* Python: For the final submission step in the Kaggle environment.

### Project Workflow

1.  Exploratory Analysis and Cleaning
    * Analysis of a dataset with over 83 million rows. Key findings:

    * Identification and removal of outliers (negative or excessively long durations).

    * Discovery of a strong pattern of leisure use (circular trips in parks, with longer durations on weekends) in contrast to commuter use   (shorter trips during peak hours on weekdays).

2.  Feature Engineering
    * Creation of predictive variables for the model, including:

    * distance_km: Geospatial straight-line distance between the start and end stations.

    * hour_of_day: The hour of the day when the trip started.

    * is_weekend: A binary variable to identify weekends.

    * is_circular_trip: A binary variable to identify leisure trips (starting and ending at the same station).

3. Modeling and Evaluation
    * Two models were trained and compared using BigQuery ML:

    * Baseline Model (Linear Regression): Achieved an RMSE of ~1634 seconds.

    * Advanced Model (Boosted Tree Regressor): Outperformed the baseline, achieving an RMSE of ~1626 seconds.

4.  Result Generation
    * The final prediction was generated for a 5% holdout test set, and the result, a CSV file with over 3 million rows, was exported via Google Cloud Storage.

### Challenges and Learnings

One of the biggest challenges was handling data locality restrictions between Europe and the US in BigQuery, which required creating datasets in specific regions and using GCS for data export. 
Additionally, the Kaggle submission library (bq_helper) proved to be unstable, leading us to build a more robust, manual train/test/predict pipeline.
