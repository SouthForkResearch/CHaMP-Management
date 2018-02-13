
## Data Archiving
The following steps can be taken to archive a full suite of measurement, metric and model products for CHaMP.  We recommend saving these products in a folder called CHaMP_ProductsDL_YEARMMDD  on a local server. Archiving a local copy of the data should be repeated annually or after major updating and processing events.

### Files, Metrics and Model Products
_From CHaMPMonitoring.org:_  
1. Download Measurements database, Study Design database, and Temperature Metrics database from the [Program-wide Data Exports tab](https://www.champmonitoring.org/DataExport/Details/1#tab-overview) 
2. Download Temperature Measurements Database from the Data Exports tab of EACH WATERSHED of interest.  Temperature Measurements databases are only available on Watershed-specific Export tabs due to file sizes. 
3. Download the list of Visits for each Year (or Watershed-Year combination).  A .csv file of the full list of Visits may be downloaded for each year of interest from the Visit tab.  We recommend saving this as the 'accounting inventory' of all possible Visits that exist for your watershed.  
4.  Download the Evaluation files for each year for each Watershed of interest.  The Evaluation files are required for GRTS-based analyses and are a useful inventory of land owner permissions for each year of sampling.  These can be downloaded from the Program-level [Site Evaluations](https://www.champmonitoring.org/Reports/Details/1#tab-siteevaluations) tab or the Site Evaluation tab within the Field Support menu of each Watershed.

_From the CHaMP Workbench:_  
5. Download Metrics .csv from the Workbench [Tools menu/Review Metrics](http://workbench.northarrowresearch.com/Tools_Menu/Metrics/metric_review.html)  
6. Save a copy of your Active version of the [SQL Workbench database](http://workbench.northarrowresearch.com/Technical_Reference/working_with_sqlite_databases.html) in your archival folder
7. Download files and model products using the Data menu item "[Download API Files](http://workbench.northarrowresearch.com/Data_Menu/download_champ_data.html)".  All files should be downloaded (Measurement files, Topographic Files, Hydraulic Model files, etc.) Before doing this step, Use the "[Syncrhonize CHaMP Data](http://workbench.northarrowresearch.com//Data_Menu/synchronize_champ_data.html)" Option (also in the Data menu) to retrieve a list of all files available for your visits.  
* Note that it may be necessary to download files for ~10 visits at a time to avoid download errors via the API. 

_From the Dropbox Archives_
8. A copy of the [Master Frame File](https://www.dropbox.com/sh/ilhztlguxwn5v6z/AACr-BNIiV_OwjipGwaAAXRna?dl=0) for CHaMP is available from Dropbox and will also be made accessible from the Study Design pages of CHaMP Monitoring.  This file tracks the Frame extents (TargetYEAR attribute) and Strata (StrataYEAR attribute) desginations of reaches for each year of sampling within each watershed. 
