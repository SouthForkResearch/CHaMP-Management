The CHaMP Topo Toolbar is designed to guide the user through the production of a high-resolution digital elevation model (DEM) from topographic survey data collected using the CHaMP protocol. The general workflow involves importing survey data into ArcGIS, projecting/transforming the unprojected survey data (if the survey is the first for a site), editing the survey data, building and editng a Triangulated Irregular Network (TIN) from the survey data, building and editing a Digital Elevation Model (DEM) from the TIN, and generating a water depth map from the DEM.

The CHaMP Topo Toolbar provides custom tools for creating, inspecting, and editing the datasets required for producing high-resolution DEM’s from total station survey data. In addition, the Coordinate Transformation Tool can be found in the CHaMP toolbar. 

Following is a list of the steps that are taken to process topographic survey data:

1. scouting pre-survey

 - Export Control File
 - Scout Map

2. Create Survey GDB

3. process survey data

 - Update Z values for Breakline Vertices
 - Validate Description Codes
 - Process Instrument File
 - Survey Quality Report
 - Load Survey Data
 - Transformation Tool
 - Survey Extent Polygon

4. generate topographic surfaces

 - Create Topo TIN
 - Convert TIN to DEM
 - Detrend
 - Review TIN Integrity

5. generate channel features

 - Bankfull Extent
 - Wetted Extent
 - Digitize Channel Unit Polygons
 - Verify Channel Units and Clip
 - Stream Surface
 - Thalweg
 - Bankfull Centerline and Islands
 - Bankfull Cross Sections
 - Wetted Centerline and Islands
 - Wetted Cross Sections

6. survey evaluation

 - 3D Point Quality Raster
 - Interpolation Error Raster
 - Point Density Raster
 - Roughness Height Raster
 - Slope Raster
 - Survey Error Raster

7. finalize

 - Map Images
 - Note
 - Publish
 - Survey Review
 - Validate Data

8. advanced tools

 - Add LiDAR to survey
 - Clean Transformation
 - Clear Workspace
 - Options
 - Prepare Survey For New Transformation
 - Substrate Raster Generation (batch process)

9. technical reference

 - Font Size Issues in ArcMap
 - Methods
 - Topographic Point Quality
 - troubleshooting
 - ArcMap Screen Resolution


We have developed a system for troubleshooting problems with the GIS processing of the survey data. Please follow these steps if you encounter any problems in the GIS processing workflow:

1. CHaMP topographic data processing toolbar http://champtools.northarrowresearch.com. 

2. CHaMP Topographic Processing Quick Guide (2013): This document contains the recommended workflow for CHaMP Topographic Processing. Also note additional guides for ArcGIS and Foresight, and tutorials.

3. Help menus and videos: http://champtools.northarrowresearch.com. 

4. CHaMP GIS Processing Video Tutorials: A series of video tutorials is available for download: http://champtools.northarrowresearch.com/video-tutorials. Videos are always accessible via YouTube

5. ArcGIS Help Resources for learning basic functions of ArcGIS:
  http://help.arcgis.com/en/arcgisdesktop/10.0/help/index.html
