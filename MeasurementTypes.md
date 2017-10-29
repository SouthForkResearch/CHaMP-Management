# CHaMP Measurement Types

Measurement Types describe groups of Measurement Data that are captured during the field survey and usually have different data structures.  *Note: Measurement Types not listed are not utilized by CHaMP Protocols.*

#### Survey Setup

- <u>Visit Information:</u>  Includes date/time of sampling, UTM coordinates, GPS information and summarized measurement metrics.
- <u>Crew:</u>  Includes individual crew names and roles.
- <u>Visit Overview:</u> 
- <u>Supplementary Photo:</u> Includes notes and link to photos not required by the protocol.  Often include scenery, gear, crew, and points of interest.

#### Layout

- <u>Monument:</u> Monuments are markers used to refind sites and benchmarks.  Includes numbers, UTM coordinates, GPS accuracy,  bank positions, photos and notes of monuments.
- <u>Benchmark:</u> Benchmarks are survey markers used to tie spatial coordinates to on-the-ground locations.  The types, status (active/retired), coordinates, install year, and orientation to monuments are included.  Monument Number is a foreign key to the Monument table. 
- <u>Site Marker:</u> Site Markers are used to identify the top/bottom of a site.  UTM coordinates and accuracy, and directional information to re-locate transects.
- <u>Mid Channel Bottom of Site:</u>  Coordinates and accuracy of the mid-channel bottom of site.
- <u>Bankfull Width:</u> Includes bankfull width measurements used to determine site length.
- <u>Control Point:</u> Includes control locations, status, and coordinates used by topographic surveyors.   

#### Site Attributes

- <u>Stream Temperature Logger</u>: Includes coordinates, photos, attachment types, and install information of stream temperature loggers. 
- <u>Stream Temperature Logger Maintenance</u>: Contains records of stream temperature logger condition, water flow, and action performed during the visit (e.g. removed, replaced).  Logger ID attribute links to Stream Temperature Logger table.
- <u>Air Temperature Logger:</u> Contains records of air temperature logger location, monument orientation, and install information.
- <u>Water Chemistry:</u> Contains alkalinity, conductivity and instantaneous temperature measurements.
- <u>Cross-section:</u>  Cross section inventory for each visit, including total discharge and count of discharge stations along the cross-section.
- <u>Discharge:</u> Cross section station measurements of velocity and depths for discharge. Cross Section ID links to the Cross-section table.

#### Channel Units

- <u>Pebble:</u> Contains individual pebble measurements (Substrate Size Class or Substrate Measurement (2011 only)) and embeddedness for Cobbles (Percent Buried and Percent Fines).  
- <u>Channel Segment:</u> Added in 2014 to describe features of side channels (e.g. type, length, percent wetted, width).  
- <u>Channel Unit:</u> Contains channel unit types (Tier 1/Tier 2).  Segment Number links to Channel Segment table.  
- Pebble Cross-Section: 
- Fish Cover
- Substrate Cover
- Large Woody Piece
- Pool Tail Fines
- Undercut Banks

#### Transects

- Transect Photos
- Riparian Structure
- Canopy Cover
- Solar Pathfinder

#### Invertebrates

- <u>Drift Invertebrate Sample:</u> Includes drift sampling net placement, depths, velocities and deployment times. 
- <u>Drift Invertebrate Sample Results</u>: Includes sample sorting metadata, such as jar counts, sorting time and personnel.
- <u>Taxon By Size Class Counts:</u> Contains invertebrate taxon, lifestage, size class, count and quality of all invertebrates in the sorted sample. 
- <u>Sample Biomasses:</u> Contains dry mass of pooled fractions of sample (Aquatic, Terrestrial and Aquatic Terrestrial).  Aquatics are invertebrates with aquatic larval stages, Terrestrial are invertebrates with terrestrial larval stages, and Aquatic_Terrestrial are the adult life stages of aquatics that have a terrestrial form. 

