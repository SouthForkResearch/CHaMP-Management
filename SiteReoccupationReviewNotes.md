## Site Reoccupation/Transformation
#### Scenarios


|   |Unprojected FDS/Folder Exists|GCD?|Notes|
|---|-----------------------------|---|------|
|New Visit|Yes|N/A|Normal|
Visit Reoccupied (missing 0-1 bm’s)|No|Yes|Normal|
|Crew Error|Yes|Maybe*|Crew used toolbar incorrectly|
|Out of Tolerance|Yes|Maybe*|Not occupied in field, in office used manual affine/rotation/elevation to best fit survey. Use previous hinge if at all possible.|
|Missing 2 benchmarks|Yes|Maybe*|in office used manual affine/rotation/elevation to best fit survey. Use previous hinge if at all possible.|
|Missing 3 Benchmarks|Yes|No|Control Network Reset. Occasionally use manual best fit to align with orientation of previous surveys, but elevation will not be the same.|
|LiDAR|“Transformation” FDS may exist (in custom folder for topo projects?)|Y|Previous surveys were re-transformed if control points  were captured for LiDAR control network.|
|RTK|No|Yes|It would be good to have a Point Quality or uncertainty for the benchmarks for these visits.|
*An expert’s assessment would be required to determine if GCD results are representative in these cases. Higher uncertainty should be used in these cases.*
## Ideal Assessment Procedure  
Capture the Timeline of the Control Network for a site.  
* Instances of Transformation Tool use (unexpected “Unprojected” instance)  
* Continuation of Benchmarks in each survey, verified by Benchmarks captured in Aux.  
* Assess the spatial agreement (delta xy) of Benchmarks between surveys, with attention to SP vs SS.
* Evaluate Elevation Agreement between benchmarks (delta Z), especially the designated Hinge point and OC points. (Though I don’t think we are able to reliably identify the hinge point used).  
* A Retransformation (say due to lidar) could retroactively reset the control network, however, all benchmarks/control network should still be in spatial agreement.  
* The goal is to identify  
  * A coherent timeline that shows each visit falls in place spatially, as represented by the benchmarks.    
  * Inconsistencies that could indicate visits could be misaligned between years.  
  * Valid reasons for miss-occupied visits exist, and these are important for explaining erroneous values in GCD  
This procedure would be a useful feature to add to the Site Properties tool, and ideally could be used build the new Control Network file for re-occupying a site.  
## In-Survey Drift  
* High Backsight Check Error values    
* Multiple Backsight checks or station setups between Side Shots.  
* Some uncertainty can be accounted for in point quality calculation.     
* Does this propagate through each station setup? I don’t think so.  
* Could affect benchmarks that were collected at different station setups.  
* 2011 - 2012 surveys could be more prone to drift (or unknown drift status)  
  * Green crews did not recognize when drift was occuring drift  
  * No procedures or little training to recognize and deal with drift.  
  * Initial visits to sites (no existing context)  
  * Nikon/Instrument differences/issues  
  * Proprietary software did not carry over backsight information to toolbar.  
* Check Reoccupation values, backsight checks for store points?  
* Strange or overlapping features within survey (LW on wrong side of TB, etc)  
* GCD Results could show drift over the longitudinal survey area.  
