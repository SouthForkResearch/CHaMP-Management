<h2>CHaMP 2017 Toolbar Process for Required Updates</h2>
<p>Date: August 30, 2017</br>
Toolbar version: 7.0.20.0.</br>
Created by: Arielle A. Gervasi, South Fork Research, Inc.</p>


<h3>Introduction</h3>

<p>As the CHaMP project grows, updates to the data requirements necessitate changes to the tools. Previous surveys need to be brought up to current standards in order to facilitate metrics generation and continued use. The updates listed below will bring the CHaMP survey up to the standards of the 2017 CHaMP toolbar version 7.0.20.0 and the latest Topo Metric Engine. This version of the toolbar is the first to be compatible with open source shapefile data, and survey data will now be stored within a standard Topo Data folder rather than using a survey geodatabase. The process below is ordered to facilitate ease and lessen the chance of encountering validation errors. Also, you should create a ReadME Text document listing the repairs you performed for each survey. Please note that these instructions assume a familiarity with ArcGIS and its included Toolboxes.</p>

<h3>Getting CHaMP Data to Update</h3>

<h4>CHaMP Topo Processing Toolbar</h4>
<ul>
        <li>Obtain and install the latest CHaMP Topo Processing Toolbar from:</li>
        <ul>
                        <li>http://champtools.northarrowresearch.com/</li>
        </ul>
        <li>Uninstall any previous versions of the CHaMP Topo Processing Tools before installing a new version of the toolbar. This is done from the ArcMap Customize menu and choosing Add-In Manager (Customize menu). Make sure that you close all ESRI products, including ArcMap, before installing the new version. </li>
        <li>The Add-In Manager is where you will select the CHaMP toolbar as an add-in (upload from file). </li>
</ul>

<h4>Create Folder Structure</h4>
<ul>
	<li>Open the CHaMP Workbench.</li>
	<li>Choose the <strong>Tools</strong> menu, then <strong>Options</strong>.</li>
	<li>Select the <strong>Folders</strong> tab and make sure the parameters are set to something similar to the following folders:</li>
		<ul>
			<li>Monitoring data: C:\CHaMP\MonitoringData</li>
			<li>Input output folder: C:\CHaMP\InputOutputFiles</li>
			<li>Temp workspace: C:\CHaMP\RBTTempFolder</li>
		</ul>
	<li>Click OK to return to the main dialog box.</li>
	<li>Type the Visit ID number in the <strong>Visit ID</strong> box and hit Enter.</li>
	<li>Right Click on the selected visit and Choose the menu option, <strong>Browse Monitoring Data Folder</strong>.</li>
	<li>The file will be created in <strong>MonitoringData</strong> folder in the following folder structure:</li>
		<ul>
			<li>Year</li>
			<li>Watershed</li>
			<li>Site ID</li>
			<li>Visit_xxxx</li>			
		</ul>
</ul>

<h4>Obtain Topo Survey Data</h4>
<ul>
	<li>Login to www.champmonitoring.org.</li>
	<li>Choose the watershed where your visit occurs from the <strong>Watershed</strong> dropdown menu.</li>
	    <li>Choose the year your visit occurs from the <strong>Year</strong> dropdown menu on the right.</li>
	<li>Once the page has fully loaded, Click on the <strong>Field Support</strong> tab, then the <strong>Data Check In</strong> tab.</li>
	<li>Type the Visit ID number in the <strong>Visit ID</strong> field and hit Enter.</li>
	<li>On the left side of the record you will see a <strong>Blue Cloud with a Down Arrow</strong>. Double Click on the cloud.</li>
	<li>In the dialog box that opens, use the drop down menu; Select <strong>Topographic Data</strong>.</li>
	<li>Click on the <Strong>Blue Box with the White Arrow</strong> on the right side of the dialog box for the following:</li>
		<ul>
			<li><strong>TopoData.zip</strong></li>
		</ul>
	<li>This folder will go to your Downloads folder.</li>
	    <li>From your <strong>Downloads</strong> folder, move the Topo.zip folder into the Visit ID folder for your visit and unzip. Keep a copy of the zipped folder in case you need to obtain an original file later.</li>
</ul>

<hr>

<h3>Opening Surveys in ArcMap</h3>

<h4>Checks/Repairs to do Before you Open the Survey with the CHaMP Toolbar</h4>

<p>If the survey is from 2011 and has not been opened in a 2015 or 2016 toolbar version, the repairs listed below should be completed in ArcMap before you run any tools in the toolbar because these issues will prevent several of the tools from running properly or may cause the CHaMP Toolbar or ArcMap to stop working.</p>
<ul>
        <li>Habitat_Units feature class should be called "Channel_Units"</li>
        <ul>
                 <li>Inside the TopoData > Topography > TIN0001 folder, check for Channel_Units.</li>
                 <li>If it is called not present, go to the TopoData > SurveyData folder.</li>
                 <li>Copy the Habitat_Units feature class, change the name to Channel_Units, and move it into the Topography > TIN0001 folder.</li>
        </ul>
        <li>Check for the feature class "Breaklines"</li>
        <ul>
                 <li>Inside TopoData > SurveyData, check for the feature class Breaklines.</li>
                 <li>Go to the CustomData folder, where the Soft_Breaklines and Hard_Breaklines feature class should be present. Copy the Hard_Breaklines feature class and rename to Breaklines.</li>
                 <li>Move Breaklines into the SurveyData folder and open in ArcMap.</li>
                 <li>Add field <strong>LineType</strong> (Text, 4)</li>
                 <li>Populate LineType field with "HARD"</li>
                 <li>Append Soft_Breaklines to Breaklines feature class.</li>
                 <li>Populate LineType field with "SOFT" where field value is null.</li>
        </ul>
</ul>

<h4>Open the Survey in Workflow Manager</h4>
<ul>
	<li>Open ArcGIS and select the <strong>Workflow Manager</strong> icon from the Toolbar, which will dock the Workflow Manager into your ArcMap document.</li>
	    <li>Click "Open Existing" at the top of the Workflow Manager.</li>
	<li>Navigate to the TopoData folder for your visit and select the <strong>project.rs.xml</strong> file inside.</li>	
	    <li>This will load the survey into the Manager and you are ready to start updating!</li>
</ul>

<hr>

<h3>Notes on Repairing Surveys</h3></h3>

<h4>Validate Data</h4>	
<ul>
        <li><strong>Validate Data</strong> is the guide to finding the necessary updates. Necessary repairs will be displayed in the Validate Data window, which you can open by double-clicking "Validate Data" under Finalize in the Workflow Manager.</li>
        <li><strong>The 3 types of issues displayed by the tool include:</strong></li>
        <ul>
                 <li>Error (red 'x'): Must be repaired in order to republish survey.</li>
                 <li>Warning (yellow '!'): Does not need to be resolved in order to be republished, but should be reviewed and potentially repaired as outlined in the methods below.</li>
                 <li>Missing (blue '?'): The layer is missing from the TopoData folder.</li>
        </ul>
        <li>The window will also display the suggested resolution. Refresh this window as you repair by clicking the green "Recycle" symbol to check whether the issue has been repaired or whether a fix has generated a new issue.</li>
        <li>Note that the Workflow Manager will also display the same symbols as the Validate Data window  next to the relevant tool.</li>
</ul>

<h4>Add Data vs. Survey Project Layer Manager</h4>
<ul>
        <li>There are two ways to open data:</li>
        <ul>
                 <li>Add Data</li>
                 <li>Survey Project Layer Manager</li>
        </ul>
        <li>When running processes through the Workflow Manager, the Toolbar automatically updates the visible layers in the Table of Contents (ToC) using the <strong>Survey Project Layer Manager</strong>. This adds the data to the map as a layer package with useful symbolization, which you will want as a helpful visualization when repairing most features.</li>
        <li><strong>Add Data</strong> simply adds the shapefile as a standard point, line, or polygon feature to the ToC. This should be used when you only need to do a simple repair, such as adding an attribute field.</li>
        <li>To select what layers you see using the Survey Project Layer Manager, open this tool and check the box next to the relevant layer.</li>
        <li>The tool will usually save these settings as you continue using the Workflow Manager to run processes, so if there are layers that continue to be added to the ToC when you no longer wish to view them, go back into the Survey Project Layer Manager, select "Unselect all layers in the tree below" and hit "Update Table of Contents" to clear out everything from the ToC.</li>
</ul>

<h4>Missing Features</h4>
<ul>
         <li>Any feature required for update (ie. from the section "<u>Checks/Repairs to do Before you Open the Survey with the CHaMP Toolbar</u>" above or "<u>Survey Features and Surface</u>" below) found to be missing during repair should be acquired by:    
         <ul>
                 <li>Downloading the survey geodatabase (not corrected) for the visit ID from the CHaMP Monitoring website.</li>
                 <li>Unzip the geodatabase into the Visit ID folder.</li>
                 <li>Add the feature class to the ToC and use the Export > Data function to export the feature class as a shapefile into the TopoData folder.</li>
                 <li>Note: Naming conventions and folder structure must match the standard formatting in the TopoData folder. The naming and structure should either be indicated in the repair documentation, or another TopoData folder can be referenced.</li>
         </ul>
         <li>This is caused by either an error during the export process of the pre-2017 data from survey geodatabase format to the TopoData folder format for the 2017 Toolbar, or because the feature did not exist in the geodatabase. You can confirm the feature class was not transferred inside the xml document. It will indicate missing features with a message such as:
         <ul>
              <li> < FeatureClass exported="False" > </li> 
              <li> < Source>D:\CHaMP_Data_API\2012\Tucannon\CBW05583-169855\VISIT_752\Topo\SurveyGeoDatabase_Transformation.gdb\Transformation01\Stream_Features_Transformation01< /Source ></li>
              <li> < Message >No Features found</ Message > </li>
         </ul>
</ul>

<h4>Order of Updates and Dependencies</h4>	

<p>The following is the suggested order for repair. Generally, you should follow the order of operations outlined in the Workflow Manager. However, some fixes may affect other files in the data and require recreation or editing of related features. This document will attempt to provide an outline of which features are dependent on or affected by other features. This will be noted in an "<u>Affected Layers</u>" section for each layer. If this section is not listed, that means this feature does not affect other features in the Topo Data folder.</p>

<hr>

<h3>Survey Features and Surfaces</h3>

<p>These are the underlying points and surfaces that help inform the creation of the Channel Features. Thus, these should be updated first before going through the Workflow Manager in order.</p>

<h3>Recreate the DEM</h3>

<p><strong>Recreate the DEM if one of the following is true:</strong></p>
<ul>
	<li>One or more bankfull or top of bank points do not exist on the DEM raster. This is a <strong>Warning</strong> only and may not be fully corrected by re-running the tool. If this message does not disappear once the DEM has been recreated, then move on.</li>
	<li>One or more edge of water points do not reside on the DEM data extent. This is an <strong>Error</strong> and must be corrected.</li>
</ul>

<p><strong>Recreating the DEM</strong></p>
<ul>
        <li>Run "Convert Topo TIN to DEM" in the Workflow Manager.</li>
        <li>Run "Detrend DEM" in the Workflow Manager.</li>
        <li>Note: The tool is built to modify the DEM edges so that they fall on whole meters and then increase the size of the DEM by a buffer of 10 meters to capture any edge of water, bankfull, or top of bank Topo Points within the DEM.</li>
        <li><strong>If you receive a green check mark</strong> next to these tools in the Workflow Manager, re-open the Validate Data window and verify whether the edge of water points error has disappeared. If it has not, move on to "<u>Resolving Edge of Water Points Error</u>" below.</li>
        <li><strong>If you receive a red 'x'</strong> next to the tools in Workflow Manager, and the Validate Data window now displays the error message "The raster is required to be divisible with corner coordinates on whole metres and it is not” after recreating the DEM, you have two options:</li>
        <ul> 
                  <li>Start over and skip the DEM recreation:</li>
                  <ul>
                            <li>This is a reasonable fix assuming there are only a small number of points (ie. 1-4) outside of the DEM and/or the points outside the raster are less than 20cm away from the DEM, so that you are not making any major modifications to the Topo Points.</li>
                            <li>Close your ArcMap session, return to your Visit ID folder, delete the TopoData folder and unzip a new copy of the folder from the Topo.zip folder.</li>
                            <li>Reload the survey using the Workflow Manager. Instead of recreating the DEM, skip to the section "<u>Resolving Edge of Water Points Error</u>" below.</li>
                  </ul>
                  <li>Recreate the DEM manually:</li>
                  <ul>
                            <li>Close Close your ArcMap session, return to your Visit ID folder, delete the TopoData folder and unzip a new copy of the folder from the Topo.zip folder.</li>
                            <li>Go into the Topography > TIN0001 folder and save the original DEM as “DEM_Orig”</li>
                            <li>Re-open ArcMap, keeping the CHaMP Topo Toolbar closed.</li>
                            <li>Open the TIN to Raster tool inside 3D Analyst Tools > Conversion > From TIN </li>
                            <li>Use the “tin” file inside the TIN0001 folder. Set the output as “DEM”.</li>
                            <li>Set Sampling Distance as “CELLSIZE 0.1”</li>
                            <li>Open the Environmental Settings</li>
                            <li>Under Processing Extent, use the file selection to select the “tin” from the TIN0001 folder.</li>
                            <li>Round down the left and bottom number to the nearest whole meter. Round up the top and right. Buffer the DEM by 10m by adding 10 to each of these numbers.</li>
                            <li>Run the tool and then reopen the survey xml in the Toolbar.</li>
                 </ul>
        </ul>
        <li>If the newly created DEM or Detrended DEM does not align with the rest of the data, stop repair immediately and contact CHaMP GIS Support staff. This is rare, however, it occasionally happens.</li>
</ul>

<p><strong>Resolving Edge of Water Points Error</strong></p>        
<ul>
        <li>If this message does not disappear once the DEM has been recreated, or you were not able to recreate the DEM, open the Survey Project layer Manager and select the DEM, Detrended DEM, Edge of Water Points, and Breaklines. Update the Table of Contents.
There are two options for repair:</li>
        <ul>
                 <li><strong>If the offending point(s) is less than 20 cm</strong> from the DEM, move it onto the DEM. You will also need to move any Breaklines that are snapped to the point and re-snap (many times the points at the edge of the survey will not have any attached Breaklines). If you have moved any Breakline vertices, run the "Update Z Values for Breakline Vertices" tool when you are finished editing the Edge of Water Points.</li>
    	<li><strong>If the offending point(s) is more than 20 cm</strong> from the DEM, copy it to a new feature class called EdgeofWater_Points_remove inside the SurveyData folder. Move on and complete all other repairs. Just before Publishing the Final Geodatabase, delete the points from the original EdgeofWater_Points feature class.</li>
       </ul>
</ul>	

<p><strong>Affected Layers</strong></p>
<ul>
        <li>If you recreated the DEM, you must recreate:
        <ul>
                <li>The Detrended DEM</li>
                <li>The Stream Surface Rasters (Stream Surface TIN, DEM, and Water Depth)</li>
        </ul>
        <li>If you moved an Edge of Water point:</li>
        <ul>
                <li>Any Breakline associated with the point -- see "<u>Breaklines</u>" below.</li>
        </ul>
</ul>

<h3>Topo Points</h3>
<p><strong>When to repair</strong></p>
<ul>
        <li>You receive the message that there is an incorrect number of "in" or "out" flow points.</li>
        <li>You receive the message that the "in" or "out" flow point does not exist inside the main channel extent polygon, DEM, or Water Depth raster.</li>
        <li>You receive the message that the "in" flow is at a lower elevation that the "out" flow.</li> 
</ul>

<p><strong>Incorrect number of "in" or "out" flow points</strong></p>
<ul>
	<li>This is typically due to there not being a designated "in" and "out" point in the Topo Points layer.</li>
	    <li>Using the Layer Manager, add Topo Points, Edge of Water Points, and Wetted Extent to the ToC.</li>
	    <li>Using the "lw" and "rw" designation, determine which end is the "in" flow (top of survey) and which end of the survey is the "out" flow (bottom of survey).</li>
	    <li>Rename the two "wg" points closest to the top and the bottom of the survey, by changing the <strong>Code</strong> attribute value from "wg" to either "in" or "out".</li> 
	    <li>The points should then change to be symbolized as stars instead of points.</li>
	    <li>Recreate the Thalweg after this step, as the Thalweg should use the "in" and "out" points as endpoints.
</ul>

<p><strong>The "in" or "out" flow point does not exist inside the main channel extent polygon</p></strong>
<ul>
	<li>Both points need to fall within the following feature classes or rasters.</li>
		<ul>
			<li>Wetted Extent feature class</li>
			<li>DEM raster</li>
			<li>Water Depth raster</li>
		</ul>
	    <li>Add the Topo Points, Wetted Extent, DEM, and Water Depth to the ToC using the Layer Manager.</li>
	<li>If the points do not fall within these polygons/rasters, try recreating the Wetted Extent polygon using the slider tool (see the section "<u>Wetted Extent</u>" below on how).</li>
	    <li>First, save the original WExtent polygon.</li>
	    <li>Remove the layers from the ToC using the "Unselect all layers in the tree below" option in the Layer Manager.</li>
	    <li>Make a copy and rename the original file by going to ArcCatalog: Topography > TIN0001 > Stages > Wetted. Make a copy of "WExtent.shp" as "WExtent_orig.shp"</li>
	    <li>After recreating the Wetted Extent polygon with the Slider tool, if the error is still not resolved, see if the polygon can be edited minimally at the edges to include the point. Edit and save this new Wetted Extent polygon.</li>
	    <li>Lastly, if you recreate the Wetted Extent, you must recreate the Stream Surface (Water Depth) rasters later as you go through the workflow in the "<u>Channel Features</u>" section below.</li>
</ul>

<p><strong>The "in" flow is at a lower elevation that the "out" flow. </p></strong>
<ul>
        <li>Usually this is because an operator accidentally designated the flow points incorrectly, and by simply renaming the "in" flow as "out", and vice versa, this is resolved.</li>
        <li>In some cases, this is not an error, in very flat survey sites. Recreate the Thalweg and this may resolve the issue.</li> 
</ul>

<p><strong>Affected Layers</strong></p>
<ul>
        <li>If "in"/"out" points are designated/moved</li>
        <ul>
                       <li>Thalweg</li>
        </ul> 
        <li>If you edit a Wetted Extent polygon to include a Topo Point:</li>
        <ul>
                       <li>See "<u>Wetted Extent</u>" below.</li>
        </ul>
        <li>In general, if a Topo Point is majorly moved/edited</li>
        <ul>
                       <li>All layers in Workflow Manager -- Topo Points are the underlying basis that informs the DEM creation and location of edge of water/channel features etc. This is why Topo Points are not usually moved more than 20cm or far enough to greatly change their Z-value (elevation value).</li>
                       <li>Breaklines  -- See "<u>Breaklines</u>" below.</li>
    </ul>
</ul>

<h3>Breaklines</h3>

<p><strong>If you have moved any Topo or Edge of Water points</strong></p>
<ul>
        <li>You may need to move the ends of any Breaklines which fall on those points.</li>
        <li>Make sure Breakline vertices fell on original points. If they did, move the line until it snaps to the relocated point.</li>
        <li>Run the Update Z Values for Breakline Vertices tool.</li>
</ul>
<p><strong>Crossed Breaklines</strong></p>
<ul>
        <li>This is rare and will be indicated with a validation error/warning.</li>
        <li>Make sure hard Breaklines do not cross. If they do, either edit out a section or move the line and point. If Breaklines have crossed, you will need to remove any vertices created by ArcMap where the cross occurred.</li>
        <li>Run the Update Z Values for Breakline Vertices tool if you edit any Breaklines.</li>
</ul>

<p><strong>Missing Breakline Topo Points</strong></p>
<ul>
        <li>This is rare and will be indicated with a validation error/warning.</li>
        <li>If breaklines do not have points associated with them, follow the steps below.</li>
        <ul>
                  <li>Select the breaklines which do not have points.</li>
                  <li>Export them to a new features class: BreaklinesforPoints</li>
                  <li>Use the Feature Vertices to Points tool to Output Feature Class:</li>
                  <li>Input Features: BreaklinesforPoints</li>
                  <li>Output Feature Class: Topo_Points_New</li>
                  <li>Point Type (optional: All).</li>
                  <li>Append Topo_Points_New to Topo_Points.</li>
        </ul>
</ul>

<h3>Control_Points Feature Class Updates (2011 Surveys only)</h3>
<p><strong>When to make this repair:</strong> If your survey is from 2011</p>
​	           
<ul>       
        <li>Use Add Data > TopoData > SurveyData > Control_Points.shp</li>
        <li>Open Attribute Table.</li>
    <li>Add field: <strong>Type</strong> (Text, 10).</li>
    <li>Populate field with one of the following values.</li>
    	<ul>
    		<li><u>Control</u> for Code <strong>cp</strong></li>
    		<li><u>Benchmark</u> for Code <strong>bm</strong></li>
    		<li><u>Backsight</u> for Code <strong>bs</strong></li>
    	</ul>
</ul>

<h3>Stream Features</h3>
<ul>
	<li>If Stream_Features feature class is not present, add from a newer visit for the same site and remove any records.</li>
	<li>If Stream_Features feature class is present.</li>
		<ul>
			<li>Open Attribute Table.</li>
			<li>Check table for the following fields and ADD if they are not present:</li>
				<ul>
					<li>VDE (dbl)</li>
					<li>HDE (dbl)</li>
					<li>PQuality* (dbl)</li>
					<li>STATION (Text, Default)</li>
					<li>Code (Text, 10)*</li>
	                                        * = New to 2017 toolbar                        				
	                           </ul>
	           </ul>
	<li>Check that the Stream_Features feature class is Z enabled.</li>
		<ul>
			<li>Add Stream_Features to the Control Panel</li>
			<li>Right Click the feature class and select <strong>Properties</strong>.</li>
			<li>On the <strong>Source</strong> tab, the Coordinates have Z Values: should be <strong>Yes</strong></li>
			<li>If this is not the case, Use the Copy Features tool under the Data Management Tools, Features Toolbox to create a new feature class.</li>
				<ul>
					<li>Input Features: Stream_Features</li>
					<li>Output Feature Class: Stream_Features_new</li>
					<li>Environments: Z Values</li>
					<li>Output has Z Values: Enabled</li>
					<li>Click OK</li>
				</ul>
			<li>Rename Stream_Features to Stream_Features_orig.</li>
			<li>Rename Stream_Features_new to Stream_Features.</li>
		</ul>
</ul>

<hr>

<h3>Channel Features</h3>

<p>Now that Survey Features and Surfaces have been reviewed for accuracy, Channel Features may be reviewed, created, or recreated in order using the Survey Manager (to view) and the CHaMP Toolbar.</p>

<h3>Thalweg</h3>
<ul>
	<li>Create if missing.</li>
	    <li>Recreate if the DEM was recreated or edits were made to the Topo "in"/"out" points.</li>
	<li>Sometimes an error message will appear in the Validate Data window that "thalweg was flipped during validation." Usually this error will correct itself if you move on.</li>
	    <li>The red vertex (point) on the Thalweg line should be on the in point. If this is not the case, contact GIS Support staff.</li>
	    <li>If you receive the message: "The start of the thalweg is more than the allowed horizontal distance from the inflow topo point," this should resolve itself if you recreate the Thalweg.</li>
	    <li>If you receive the message: "The elevation at start of Thalweg is not the required elevation," and you have already verified that the "in" and "out" flow Topo Points are designated and on the correct ends of the survey extent, recreate the Thalweg.</li>
</ul>

<p><strong>When to Update</strong></p>
<ul>
	<li>The Thalweg passes outside the WaterExtent or off the WSEDEM. This can happen if:</li>
	    <ul>
	             <li>There is a sharp bend in the channel,</li>
	             <li>It passes over an island, or</li>
	             <li>It passes over a gap in the WaterExtent because of a Dam or a high spot in the DEM.</li>
	    </ul>
	    <li>If the reason is one the first two, you can edit the Thalweg so it falls inside the channel or goes around the island.</li>
	    <li>If the WaterExtent has a gap because of a dam and you cannot move the line around it, you can add a small polygon over the area where the Thalweg crosses the gap in both the WaterExtent and Bankfull features. This is a last resort only and should be discussed with your supervisor or CHaMP GIS support staff.</li>
</ul>


<h3>Wetted Extent</h3>
<ul>
	<li>Open the Survey Project Layer Manager and add Wetted Extent, Edge of Water Points, and Bankfull Extent to the Table of Contents.</li>
	    <li>If either the Wetted or Bankfull feature classes are disconnected or do not extend the length of the DEM, Please stop editing and contact CHaMP GIS Support staff.</li>
</ul>

<p><strong>Recreating the Wetted Extent</strong></p>
<ul>
        <li>If the Wetted Extent was obviously not created using the Slider tool (is snapped to the Edge of Water Points at each vertex, rather than following a smooth path shaped by the DEM) or would require more than a few edits to fall fully within the Bankfull polygon, recreate it.</li>
       		<ul>
    		<li>Rename Wetted Extent feature class to maintain the original crew interpretation.</li>
                        <li>Do this by first clearing the ToC using the "Unselect all layers in the tree below" option in the Layer Manager.</li>
    		<li>Rename the file by going to Add Data: Topography > TIN0001 > Stages > Wetted and changing "WExtent.shp" to "WExtent_orig.shp"</li>
                        <li>Run the Create Wetted Extent tool.</li>
                        <li>Edit using the Slider tool to find an average water height that most aligns to the Edge of Water Points. Save the polygon using the tool.</li>
               </ul>
         <li>After creating the polygon, if there are small polygons "islands" of water disconnected from the main channel, those can be removed using an Editor session. The Wetted Extent should consist of only one polygon.</li>
         <li>Remove any tiny triangles in either the Water or Bankfull Extent features using the Editor. These tiny donuts are not real and are usually less than 10 cm across.</li>
         <li><strong>Caution!</strong> If you recreate the WaterExtent and it no longer extends the length of the DEM, delete the feature class you just created and rename WExtent_orig to WaterExtent. This is due to an insufficient number of left and right wetted edge of water points, which will not allow the Create Wetted Extent tool to work properly. Note this in the ReadME document and work with the original extent as best you can.</li>		
</ul>

<p><strong>Editing an Existing Wetted Extent/Bankfull Extent</strong></p>
<ul>	
        <li>If the Wetted Extent appears to have been created with the Slider tool and looks good, you can also choose to keep it.</li>
        <li><strong>FIRST</strong>, you will have to use the Copy Features tool under the Data Management Tools > Features Toolbox to recreate the WExtent as a new feature class with the M and Z values disabled. Call it "WExtent" and save the old WExtent as "WExtent_ZM" or similar. This is an artifact of when the data was formatted inside a survey geodatase.</li>
    <li>Check to make sure it is NOT a multi-part feature (one record for multiple polygons) and explode if necessary.</li>
    <li>If after exploding, you get very small polygons outside the primary polygon. These may be artifacts of the survey point density and are not real. Based on your review of the DEM, you can remove them.</li>
    <li>Check Attribute Table for the ExtentType field (this is added automatically if you recreate the Wetted Extent).</li>
    	<ul>
    		<li>Add field: <strong>ExtentType</strong> (Text, 10) to existing feature classes.</li>
    		<li>Add value "Channel" to the field for the primary channel. Leave any other records (other polygons outside the main channel) blank.</li>
    	</ul>
    <li>If you receive the <strong>Error message</strong>: "One or more water extent polygons are not within a bankfull polygon," edit the Bankfull Extent feature minimally at the edges, until the Wetted Extent is fully inside it.</li>
    	<ul>
    		<li>Surveys initially processed using CHaMP Toolbar version 6.0.19.0 or newer will not have this issue.</li>
                        <li>If the Wetted Extent has been created using the Slider tool, this issue can also be resolved by recreating the Bankfull Extent polygon using the Toolbar.</li>
    		<li>Once WaterExtent is fully within Bankfull, the error message will disappear from the Validate Data window.</li>
    	</ul>
    <li>Remove any tiny triangles in either the Water or Bankfull Extent features using the Editor. These tiny donuts are not real and are usually less than 10 cm across.</li>
</ul>

<p><strong>Affected Layers</strong></p>
<ul>
        <li>If you recreate or edit the geometry of a Wetted Extent polygon:</li>
        <ul>
                <li>Recreate Wetted Centerline and Islands.</li>
                <li>Recreate Wetted Cross Sections.</li>
                <li>Recreate or reshape (and clip) Channel Unit polygons to the Wetted Extent.</li>
                <li>Recreate Stream Surface TIN, DEM, and Water Depth rasters.</li>
        </ul>
</ul>

<h3>Wetted Centerline & Islands</h3>
<ul>
        <li>Open the Survey Project Layer Manager and add (if present) Edge of Water Points, Wetted Centerline, Wetted Extent, and Wetted Extent Islands to the Table of Contents.</li>
        <li>The Centerline is calculated based on the presence or absence of islands, so the Islands must be created before the Centerline.</li>
        <li>If either the Islands layer or Centerline layer do not meet all of the criteria above and you need to recreate either feature, run the tool to regenerate both Islands and Centerline features.</li>
</ul>

<p><strong>Verify Qualifying Islands and a Correct Centerline</strong></p>
<ul>
        <li><strong>Qualifying Islands</strong></li>
        <ul>
                <li><strong>Surveys from 2014 and later</strong>: Islands are indicated with Edge of Water Points with Code "mw" and Bars with "br". Verify that only islands (not bars) are marked as Islands.
                <li><strong>Surveys before 2014</strong>: Crews did not distinguish islands and bars, so if any gaps exist in the Wetted Extent, you must go to champmonitoring.org or the CHaMP workbench to determine if there were islands.</li>
                <ul>
                           <li>From the CHaMP Workbench, you can select the Visit ID then right-click to view "Visit Properties."</li>
                           <li>Open the Tab "Channel Units."</li>
                           <li>Each Channel Unit (designated under "Unit Number") has a "Segment Number."
                           <li>A "Segment Number" value of '1' means there were no islands; a value of '2' would indicate that the unit was split into multiple segments due to the presence of an island.
                           <li>Use this information to find any islands, if present. You can add the Channel Units and Channel Unit Markers to the ToC if you are having difficulty locating which gap in the Extent polygon is a qualifying island.</li>
                </ul>
        </ul>
        <li><strong>Correct Centerline</strong></li>
        <ul>
                <li>If islands are present, Centerlines should have blue side channel line segments that loop around any qualifying islands, in addition to a red main channel segment that follows the middle of the main channel. If they are missing when they should be present, recreate the Centerline.</li>
                <li>Another issue that is less apparent is that old versions of the tool route Centerlines around small gaps in the Wetted Extent polygon. Unless a small gap constitutes an island, Centerlines should cross over them or ignore their presence.</li>
        </ul>
</ul>

<p><strong>Editing Existing Islands and Centerlines</strong></p>
<ul>
        <li>The fastest way to ensure the Islands and Centerline layers meet the necessary criteria is to simply recreate both features after verifying whether there are any qualifying islands. However, if there is no need to recreate the features, and you wish to keep the original features, the only check is to ensure they have the following attribute fields.</li>
        <li><strong>Centerline</strong></li>
        <ul>
                <li>Open Attribute Table and check for the field: Channel.</li>
    	<li>Add the field: <strong>Channel</strong> (Text, 10).</li>
    	<li>Add value "Main" or "Side" to the Channel field for line segments as appropriate.</li>
    </ul> 
        <li><strong>Islands</strong></li>
        <ul>
                <li>Open Attribute Table.</li>
            <li>Add fields: <strong>Qualifying</strong> (Numeric, Short) and <strong>IsValid</strong> (Numeric, Short).</li>
       </ul>
</ul>	

<p><strong>Straighten Ends of Centerline</strong></p>
<ul>
        <li>In the case of either recreation, or editing an existing Centerline, the main edit needed is to straighten the Centerline at both the top and bottom of the survey, as naturally the Centerline can curve at the ends. This will help ensure that Cross Sections start perpendicular to the Centerline and main channel at each end, to capture the most data.</li>
</ul>

<p><strong>Affected Layers</strong></p>
<ul>
        <li>If you regenerate the Islands and Centerline, or edit the geometry of the Centerline</li>
        <ul>
                 <li>Recreate the Wetted Cross Sections</li>
        </ul>
</ul>

<h3>Wetted Cross Sections</h3>
<ul>
	<li>Create if missing from geodatabase or you recreated the Centerline and Islands.</li>
	    <li>Use the Selection tool to mark sections either "Valid" or "Invalid."</li>
	<li>Review Cross Sections to verify that they meet the following criteria:</li>
		<ul>
			<li>Cross sections at the top and bottom should be perpendicular to the WaterExtent polygon.</li>
			<li>Cross sections should span the whole channel. If a cross section spans less than the full channel because of the angle of the extent polygon, mark it as Invalid.</li>
			<li>Cross sections should not parallel the Centerline because of bends in the Centerline. Mark as Invalid.</li>
	                    <li>Cross Sections that cross over 2 channels in the presence of an island should be marked Invalid (the tool usually captures most of these).</li>
	                    <li>Cross Sections with a large degree of overlap should be marked Invalid so that Cross Sections for the most part represent a unique area.</li>
	                    <li>Cross Sections that do not overall represent the main channel (ie. An arm of a side channel was partially surveyed but cut off by the survey extent edges) should be deleted.</li>
		</ul>
</ul>

<h3>Channel Units</h3>
<ul>
        <li>Channel units should be reviewed for all surveys.</li>
        <li>You must resolve the messages: "Channel unit polygons extend outside the wetted extent main channel" and "Overlapping channel unit polygons encountered" if they are displayed in the Validate Data window, using the methods below.</li>
        <li>Use the Layer Manager to add the Channel Units, Channel Unit Markers, and Wetted Extent to the ToC.</li>
        <li>Use Add Data to add the Channel_Units and the Channel_Units_Field feature classes to the ToC (in Topography >
 TIN0001).</li>
</ul>

<p><strong>Qualifying Channel Unit Polygons</strong></p>
<ul>
        <li>Channel Unit polygons should not overlap.</li>
        <li>Channel Unit polygons should not have small gaps.</li>
        <li>Channel Unit polygons should start and stop based on the Channel Unit Markers, and have vertices snapped to the markers.</li>
        <li>You will see a warning in the Validation window if overlapping occurs. The warning denotes which channel unit polygons overlap by number. The other 2 issues must be checked visually and repaired in an Editor session.</li>
</ul>

<p><strong>Recreating Channel Units</strong></p>
<ul>
        <li>In most cases, this is the easiest way to repair channel unit polygons that need major reshaping to fit a new Wetted Extent or were not clipped to the original Wetted Extent.</li>
        <li>If the fields Tier1, Tier2, GS_GT256, GS_65_255, GS_17_64, GS_3_16, GS_006_2, GS_LT006 are not present in the Channel_Units_Field feature class, they must either be added manually or will be automatically added in the Channel_Units_Field is recreated from the Channel_Units feature class. The Verify and Clip tool will not work without these fields added.</li>
        <li>To recreate the channel unit polygons, you must remove the original Channel Units, Channel_Units, and Channel_Units_Field from the ToC first.</li>
        <li>Run <strong>Digitize Channel Unit Polygons</strong> tool and check the box next to "Create new channel unit feature class".</li>
        <li>If the Channel Units Field layer shows that there are already channel unit polygons, double-click on the layer, go to the Source tab, and change the source to the newly generated Channel_Units_Field feature class, using "Set Data Source" if it is set to Channel_Units (this is a bug in the tool that is currently being repaired).</li>
        <li>Now you can use Editor and the Create Features editing window to easily create new color-coded channel unit polygons. Remember to snap to channel unit markers and to pull the polygons outside the Wetted Extent polygon.</li>
        <li>When you are finished, close the Editor session and run the <strong>Verify and Clip Channel Units</strong> tool to clip the polygons to the Wetted Extent.</li>
</ul>

<p><strong>Editing Existing Channel Units</strong></p>
<ul>
        <li>If the channel unit polygons only need a small amount of editing and are mostly clipped to the Wetted Extent, as in the case of overlapping channel units, editing can be done by hand.</li>
        <li>If the fields Tier1, Tier2, GS_GT256, GS_65_255, GS_17_64, GS_3_16, GS_006_2, GS_LT006 are not present in the Channel_Units_Field feature class, they must be added manually. The Verify and Clip tool will not work without these fields added.</li>
        <li>The polygons can be re-shaped and re-clipped by opening an Editor session (verify it is for the Channel_Units_Field feature class with the added fields listed above) and using the Reshape Feature Tool to edit the polygon(s) until outside the Wetted Extent or snapped to it. Run the <strong>Verify and Clip Channel Units</strong>
 tool to clip to the Wetted Extent when complete.</li>
</ul>

<h3>Stream Surfaces (TIN, DEM, Water Depth)</h3>
<ul>
	<li>Run this tool if at least one of the following is true:</li>
	    <ul>
	            <li>Water Depth raster is missing.</li>
	        <li>You recreated the DEM.</li>
	            <li>You recreated the Wetted Extent.</li>
	            <li>Any of these features are missing (verify in Validate Data or Layer Manager).</li>
	    </ul>
	<li>If you receive an error while trying to run this tool, please contact CHaMP GIS support staff.</li>
	    <li>These can each be QC-ed by checking that the color schema makes sense and that there are no “peaks” in the TIN.</li>
	    <li>If you run into a survey that has a disconnected Water Depth raster, these are labeled Broken and can't be fixed at this time.</li>
</ul>

<h3>Bankfull Extent</h3>
<ul>
	<li>Follows the same protocol as above under "<u>Wetted Extent</u>", except the polygon should follow the Topo Points labelled "bf" rather than the Edge of Water Points.</li>
	    <li>Recreate if it does not appear to have been created using the Slider tool.</li>
	    <li>Recreate if you recreated the Wetted Extent.</li>
</ul>

<p><strong>Affected Layers</strong></p>
<ul>
        <li>If you recreate or edit the geometry of a Bankfull polygon:</li>
        <ul>
                <li>Recreate Bankfull Centerline and Islands.</li>
                <li>Recreate Bankfull Cross Sections.</li>
        </ul>
</ul>

<h3>Bankfull Centerline & Islands</h3>
<ul>
	<li>Create if missing from geodatabase.</li>
	<li>Follow the same protocol as for "<u>Wetted Centerline & Islands</u>" when creating, recreating, or editing.</li>
</ul>

<p><strong>Affected Layers</strong></p>
<ul>
        <li>If you regenerate the Islands and Centerline, or edit the geometry of the Centerline</li>
        <ul>
                 <li>Recreate the Bankfull Cross Sections</li>
        </ul>
</ul>

<h3>Bankfull Cross Sections</h3>
<ul>
	<li>Create if feature is missing from geodatabase or you recreated the Centerline and Islands.</li>
	<li>Follow the same protocol as for "<u>Wetted Cross Sections</u>".</li>
</ul>

<h3>Survey Evaluation Rasters</h3>
<ul>
	<li>Run each tool in order to create the rasters.</li>
	<li><strong>If you have a survey from 2011-2013</strong>, surveys conducted pre-2014 will not be able to run the Create 3D Point Quality Raster so skip that one.</li>
</ul>

<hr>

<h3>Other Common Errors or Warnings based on Validate Data tool</h3>

<h4>Current Warnings to ignore. These cannot currently be repaired</h4>
<ul>
	<li>The Assoc3DPQ raster is missing. Only for pre-2014 surveys.</li>
	<li>The desired number of bankfull points (20) has not been met.</li>
	    <li>Load Survey Data to Geodatabase shows a red 'x' or warning '!' next to the tool in the Workflow Manager. Only for 2011 surveys.</li>
</ul>

<hr>

<h3>Reload Updated Survey Data</h3>
<ul>
	<li>Once the survey is repaired, Run the <strong>Publish Final Geodatabase</strong> tool.</li>
	<li>Go to the <strong>Geooptix Field Data Explorer</strong> website at:</li>
	    <ul>
	             <li>https://broker.champmonitoring.org</li>
	    </ul>
	    <li>Navigate to the correct Visit ID by navigating to the Watershed and Site ID.</li>
	    <li>Click on the Visit ID number.</li>
	    <li>Scroll down to "Upload" and use the drop-down menu to select "Topographic Data".</li>
	    <li>Click "Select Files" and navigate to the folder with your repaired TopoData folder in it.</li>
	    <li>Inside the TopoData folder, send the contents of the TopoData folder to a zipped folder and name it "TopoData.zip" so that the structure is TopoData.zip > Topo folders, project.rs.xml, etc.</li>
	    <li>Once you select the zipped TopoData folder, finish the upload by clicking the green "Upload" button, and then the Progress bar should show when it has finished loading to the Field Data Explorer. This will replace the old TopoData.zip folder on the website with your new, repaired version.</li>
