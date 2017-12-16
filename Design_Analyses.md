

# Design-Based Analyses
last updated 12/15/17.  

The spatially-balanced sampling design used by CHaMP can be used to generate design-based estimates of status and trend for individual metrics at the scale of the design. Since most CHaMP design have a spatial scale of a watershed, the general status and trend estimates for CHaMP metrics are generated for the entire watershed.  


## File Preparation

### [Evaluations](Design_Evaluations.md)

### Master sample frame (linear shapefile)

[Master Frame File (12/16/17)](

### Visit List
1. Download all Visit .csvs from CHaMPMonitoring.org Visit tab. There will be one .csv per year. The attributes of interest are Primary Visit, VisitID, SiteName and SampleDate. 
2. Import the .csvs into an MS Access database and combine them into a single table. Append a YEAR attribute to the compiled visit table to facilitate data queries. Note that all Visits available from CHaMPMonitoring.org will be included in the downloads and it may be helpful to filter Visits and remove Visits used for CHaMP Training, AEM, or research purposes.
3. Open the CHaMP Workbench and ensure all Watersheds, Sites and Visits have been synced from CHaMPMonitoring.org.
4. From the MS Access database created in step 2, import the CHaMP_Watersheds, CHaMP_Sites, and CHaMPO_Visit tables from the Workbench SQL database.  
5. Create a query combining the Primary Visit, VisitID, SiteName, SampleDate, Latitude_DD, and Longitude_DD attributes into a single table. Additional Visit Information, such as Tags available in the Visit table, can also be compiled, although these are not directly needed for the design-based analyses.
6. If a habitat-based analysis is planned, remove all Visits from the list that are not needed for the analysis, such as
* visits not sampled using a spatially-balanced sampling design
* visits sampled with different protocols, such as "CHaMP Control Network Evaluation" and fish sampling
7. Import the file created in step 5 into GIS and add X_Albers and Y_Albers attributes.  Calculate coordinates for these attributes using the Albers Equal Area Conic USGS Projection.

### Site Decoder




Return to [HOME](README.md)
