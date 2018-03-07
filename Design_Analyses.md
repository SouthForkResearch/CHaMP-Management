

# Design-Based Analyses
*last updated 12/15/17* 

The spatially-balanced sampling design used by CHaMP can be used to generate design-based estimates of status and trend for individual metrics at the scale of the design. Since most CHaMP design have a spatial scale of a watershed, the general status and trend estimates for CHaMP metrics are generated for the entire watershed.  

## File Preparation

### [Evaluations](Design_Evaluations.md)

### Master sample frame (linear shapefile)
Each year the shapefile containing the extent of all CHaMP designs is reviewed and updated with current year design information.  Key attributes include TargetYEAR, StrataYEAR, and AStrataYEAR. Target defines the target/non-target domain of the designs, strata defines the stratification attributes used in the development of the design, and AStrata defines the recommended GRTS analysis strata suggested by watershed entities that defined the original design.  

The Master Frame files includes Target and Strata information for 2011-2017 CHaMP sampling designs.  
[Master Frame File (12/16/17)](https://www.dropbox.com/s/jm39n90abgx1t8h/MasterFrame_20171216.zip?dl=0)  
[Metadata](https://www.dropbox.com/s/x03szgqbx8qzvam/FrameMetadata_20171216.xlsx?dl=0)

*Archived Frames*  
All information in archived frames is available from the Master Frame File. Archived files are not recommended for use.  
[Master Frame File (3/3/17)](https://www.dropbox.com/s/ykzij6bfvorqg2k/CHaMP_Frames_All_20170303.zip?dl=0)  
[Master Frame File (7/7/15)](https://www.dropbox.com/s/6dtyi71lexixqrx/CHaMP_Frames_All_20150707.zip?dl=0)  

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

[Visit and Site Strata File (Decoder) 12/15/17](https://www.dropbox.com/s/98g9cv839lbllfo/CHaMP_Visits_Decoder_20171215.xlsx?dl=0)  
[Final Visit Notes](https://docs.google.com/spreadsheets/d/1OPYQjjWmyjCrZo35BWjmRJP82Widy9DHxiyym-6iqdg/edit?usp=sharing)

## Code  
Any specific code used to perform GRTS-based analyses of CHaMP data is available in the [GRTS code repository](https://southforkresearch.github.io/CHaMP-Status-and-Trend-Roll-Ups/). Please note this code is only recommended for analysts proficient in R and have a statistical background in GRTS.  

## Survey Design Analysis Products

The survey design-based analyses were done in two different forms in 2017: 
* [Status and Trend Summary](https://www.dropbox.com/s/xw2g5ngojuideln/CHaMP%20Metric%20Status%20and%20Trend%202011_2017.pdf?dl=0)
* [Variance Decomposition](https://www.dropbox.com/s/fubr0xn118n24dx/CHaMP%20Variance%20Decomposition_All%20CHaMP%20Metrics.jpg?dl=0)
* status and trend estimates based on the 2017 frame and strata for all years [pdf](https://www.dropbox.com/s/ix14rmf95s31grg/2011-2017%20CHaMP%20Status%20and%20Trend_2017Frame.pdf?dl=0), [data](https://www.dropbox.com/s/pild63rwqc9j1tq/2011-2017%20CHaMP%20Status%20and%20Trend_2017SameFrame.csv?dl=0)  
* status estimates based on the year-specific frames and strata [pdf](https://www.dropbox.com/s/di6iryfe5jhoodv/2011_2017_CHaMP_Status_and_Trend.pdf?dl=0), [data](https://www.dropbox.com/s/9vhi68ozz057tcp/2011_2017_CHaMP_Status_and_Trend.csv?dl=0)  

The second estimate results are not recommended for trend detection as year-to-year changes in the design and frame are not equally accounted for across the years. Estimates are generated using the spsurvey package available for R.

Return to [HOME](README.md)
