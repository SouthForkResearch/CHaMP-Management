# Step 7: Metric Review

Any issues encountered in the Review process should be documented in [JIRA ](https://trackisemp.atlassian.net/issues/?filter=10501).

1. Download the [Workbench Software](http://workbench.northarrowresearch.com/) and database to your machine.
2. Open CHaMP Workbench. Once installed, the easiest way to find it is to search for 'CHaMP' on your computer (this works in Windows 8 or higher). 
3. Ensure the Visits for review are in the main list of visits in the Workbench.  If not, [Sync Watersheds, Sites and Visits](http://workbench.northarrowresearch.com/Data_Menu/synchronize_champ_data.html) into the Workbench and re-check.
4. Select visits for metric review.  Use the year, protocol and watershed filters or select Visits individually in the main visit inventory.  Rows will be blue when selected.  Hold the Shift Key down to select multiple Visits.

![Select Visits](https://southforkresearch.github.io/CHaMP-Management/images/WB_SelectVisits.png)

5. [Download metrics](workbench.northarrowresearch.com/Data_Menu/download_metrics.html) using the Metric Download option from the Data menu.  This will download metrics directly from CHaMPmonitoring.org into the Workbench and will take a few minutes. Select these [Schemas](MetricSchemas.md) for download: 

QA - Aux Channel Metrics (CHaMP)  
QA - Aux Tier 1 Metrics (CHaMP)  
QA - Aux Visit Metrics (CHaMP)  
QA - Topo Channel Metrics (CHaMP)  
QA - Topo Tier 1 Metrics (CHaMP)  
QA - Topo Tier 2 Metrics (CHaMP)  
QA - Topo Visit Metrics (CHaMP)  
QA - TopoAux Tier 1 Metrics (CHaMP)  
QA - TopoAux Visit Metrics (CHaMP)  

Repeat the metric download process throughout the QA season if any updates are made to the topographic or Measurement data.

6.  Open the [Metric Review](http://workbench.northarrowresearch.com/Tools_Menu/Metrics/metric_review.html) window from the Tools menu and select CHaMP.  

7.  Sort each metric in the metric grid and review metrics with null values. The following nulls are acceptable:

   * Side channel metrics if no side channels exist.
   * Tier 1, Tier 2, and Channel Unit metrics if the Channel Unit Type does not exist at the site.  
   * A method was not completed at a site (e.g. no Pebble counts will result in null D16, D50, and D84 values). Please add notes in [champmonitoring.org](www.champmonitoring.org) if this is the case.

   If unexpected nulls exist:

   * Check the Measurement data on [champmonitoring.org](www.champmonitorig.org) to ensure the appropriate source data exists and [data upload](QA_DataUpload.md) is complete for the source data.
   * If the metric is derived from topographic data, open the Project from the [CHaMP Toolbar](champtools.northarrowresearch.com/) and [Run Validation](champtools.northarrowresearch.com/7_finalize/validate_data/).


   * Add notes to applicable records ([see #4 of QA Status tab](https://southforkresearch.github.io/CHaMP-Management/QA_QAStatus.html)).  

8. Review Metric Plots. The Workbench has a preset list of Plot Types to Review for QA. If you do not see Plots for Aux Visit metrics, update your Workbench using the Help menu option.  Metric Plots are not available for Tier 1, Tier 2, and Channel Unit Schemas.

   If a suspect metric value appears, find the suspect metric in the grid and review all metrics for the Visit  and select one of the following conditions.  Options for adding notes are described in [QA Status](QA_QAStatus.md)

   * Spurious value is not valid due to confirmed field collection issue (operator error, equipment error, or not measured).  Update or remove source data and make a note on the Record or Measurement Type.
   * Spurious value is valid but an outlier.  Leave the metric and the source data and make a note. Include speculations on why the outlier may have occurred (e.g. log jam, turbid water, high flows, etc.)
   
A few items to note: 
* Fish Cover Undercut values only apply to 2011.  Ignore zeros and nulls for all other years.
* Bankfull Depth and Bankfull Volume values are not available via the topographic metrics.  Final metric values for these are from the River Bathymetry Toolkit, which was retired in 2016. 
* Residual Depth values exist for ALL channel units in the Channel Unit tables, but only values for SlowWater/Pools are summarized for the Residual Pool Depth metric.

9. If any source data are updated, review updated metrics after the metric engines have been run again.

[Return to QA Home](QAMain.md)
