## Program Metric Review 

After within season metric review has been completed by crews a completeness review and integrity-consistency review takes place for all metrics. 

#### Completeness Review

* Ensure crews have uploaded all files and promoted visits. QA notes are added to all visits not promoted.  In some cases, raw files may be compiled from Crews and stored in Egnyte Cloud Storage.  
* Review completion status and ETA of Stream Temperature Data.  Due to the variable download dates and data availability of Stream Temperature data, Stream Temperature Data Review doesn't hold up Visit Promotions.  

#### Integrity and Consistency Review

An [R script]() is run to generate Program wide summaries of metrics within year and across years.  Summaries include graphs of the following items and summary statistics in a related .csv:

* Cross year correlations of each metric 
* Box plots of individual sites with multiple visits for each metric
* Watershed-scale summaries by strata for each metric
* Watershed-scale summaries by Valley Class for each metric

The 10% and 90% thresholds are used as a guide for identifying outliers, along with review of site-scale box plots (e.g.  sites with persistent LWD jams or features that are anomalous may not be anomalous in year to year comparisons within a site).  In 2011 and 2012 a strict metric-level review by these percentages were used, but a high percentage of false identification of invalid metrics and improved data logger inputs removed the reliance on strict outlier identification.  Instead, the visual review of a suite of products (e.g. cross-year validation, within year review of metric-to-metric graphs, and strict data entry rules) provides a multi-faceted approach to generating consistent and accurate metrics.

1/4/18:   QA Metric Review Product Files (2011-2017)   
2/16/18: [QA Site Review Product Files (2011-2017)](https://www.dropbox.com/sh/ml5aqfmhb2vz3gz/AABr1HSr8dyQxJBr7354FrHia?dl=0)


##### Running the QA Metric Script

The Metric File can be generated using a variety of software, including R, MS Access, SQL or code that can concatenate attributes from multiple sources.  Here we describe the process using MS Access.  

_**File Preparation**_

1.  Create (or open) an MS Access database.  

2.  Import the following files:

   a. BankfullWidth table from the CHaMP AllMeasurements.mdb database available from the [Data Export](https://www.champmonitoring.org/DataExport/Details/1#tab-overview) tab of champmonitoring.org.  If you cannot see the Data Export tab, contact support@champmonitoring.org and request permissions updates.

   b. Metric .csv exported from the CHaMP [Workbench Metric Review](http://workbench.northarrowresearch.com/Tools_Menu/Metrics/metric_review.html) tool (Note that any number of metrics can be included, as long as the metric names match the DisplayNameShort column of the Metric Data Dictionary.csv file)

   c.  Download the CHaMP_Visits_Decoder file (Note: The only attribute pulled from this file is the ValleyClass, which can also be pulled from alternative sources if this file isn't accessible)

   d.  Visit .csv files (all years) from champmonitoring.org.

3.   Use a query to combine attributes across files 2a-d with the attributes matching the Example File.   


**_Code_**

The latest code is available in the CHaMP Management GitHub Repository.  
