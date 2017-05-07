# Metric Validation

#### When does validation occur?

Metric calculations are validated against a truth dataset after the following events:

1) New or updated metric calculation

2) Changes to metric input (e.g. measurements) storage or format that could affect metric calculations

3) Changes to calculation engines

4) Changes to metric display (this sometimes warrants calculation review, depending on the nature of the metric display change)

#### How does validation occur?

1. Review metric calculations and ensure truth metrics were calculated according to metric calculation being validated. Current metric calculations are stored HERE
2. If truth metrics need to be updated, recalculate metrics of interest from truth datasets and import truth metrics into the Master Workbench database.  See Truth Dataset section for information on Truth Data Storage.
3. From the Master Workbench, select the validation visits using the [Truth Dataset Visit List](https://www.dropbox.com/s/qwuhozz3q5sazu9/ValidationVisits_20170506.csv?dl=0).  To do this, select Edit/Filter Visits from CSV file and browse to the truth dataset visit list.
4. From the Master Workbench (linked to the Master Workbench database), run the RBT Validation Report (Tools/Model Validation Reports). This will generate an html file of the Visit-level metric validation.  Save the validation report.
5. Review the Validation report for each metric.  Metrics to be reviewed by programmers are logged in the [CHaMP Metrics repository](https://github.com/SouthForkResearch/CHaMP_Metrics/issues).
6. Update the Validation status of each Metric for Each Visit in the 2017 Validation File. 



## Validation Management and Settings

Validation settings are managed in the Workbench database.  

**Managing Truth Metrics for Validation**

 Metric_Results controls which ResultIDs (aka Unique Model Runs for each VisitID) contain metrics tagged as truth/validation metrics.  Importing truth metrics into the Workbench database is a manual process.  

1) Generate a record for each model batch of Visit IDs in Metric_Results.  Set the ScavengeTypeID =2 (Validation).  Note that multiple records can be generated for a single Visit ID as long as the Model Version is unique (for tracking purposes).

If previous versions of validation data for the same model exist for the visit ID, 

1. change the ScavengeTypeID of the previous Metric_Result record to 1 (Model Run).  This will retain the previous validation data in the database. 
2. note in the record that the ResultID is sourced from the manual validation datasets.
3. ensure the Model Version contains sourcing information for the date or version of calculation for which the manual metric set was generated.

2) Import Visit-level metrics into Metric_VisitMetrics using MetricID values from Metric_Definitions.

3) Import Tier-level metrics into Metric_TierMetrics using MetricID values from Metric_Definitions and TierType values from LookupItemList

4) Import Channel unit-level metrics into Metric_ChannelUnitMetrics using MetricID values from Metric_Definitions.



**Managing Validation Settings**

Metric_Definitions controls the metric groupings, tolerance, and min/max thresholds of the html report. 

 

## Truth Metrics and Datasets

CHaMP maintains truth metrics and corresponding datasets for topographic surveys, auxillary metrics, and stream temperature.  **Truth metrics** are metrics that were calculated manually and/or using an outside process from the production environment code.  These metrics are stored in the Workbench database as Scavenged 'Validation' metrics (see Validation settings section).    

The **truth datasets** are stored outside of the production environment (champmonitoring.org) so that these data are not subjected to changes by crews or CHaMP staff. Truth Datasets are the source datasets used to calculate Truth Metrics.

[Truth Dataset Visit List](https://www.dropbox.com/s/qwuhozz3q5sazu9/ValidationVisits_20170506.csv?dl=0)

Topographic Truth Datasets are stored in Egnyte.  These data are updated as needed to meet current topographic processing standards through the Topographic Toolbar.  Auxillary truth metrics are stored HERE.





[Return to HOME](README.md)

 



 