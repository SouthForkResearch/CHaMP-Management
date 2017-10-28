# CHaMP Measurement Types

Measurement Types describe groups of Measurement Data that are captured during the field survey and usually have different data structures.  

#### Survey Setup

- <u>Visit Information:</u>  Includes date/time of sampling, UTM coordinates, GPS information and summarized measurement metrics.
- <u>Crew:</u>  Includes individual crew names and roles.
- <u>Visit Overview:</u> 
- <u>Supplementary Photo:</u> Includes notes and link to photos not required by the protocol.  Often include scenery, gear, crew, and points of interest.

#### Layout

- <u>Monument:</u> Monuments are markers used to refind sites and benchmarks.  Includes numbers, UTM coordinates, GPS accuracy,  bank positions, photos and notes of monuments.
- <u>Benchmark:</u> Benchmarks are survey markers used to tie spatial coordinates to on-the-ground locations.  The types, status (active/retired), coordinates, install year, and orientation to monuments are included.  Monument Number is a foreign key to the Monument table. 
- <u>Site Marker:</u> Site Markers are used to identify the top/bottom of a site.  UTM coordinates and accuracy, and directional information to re-locate transects.
- Mid Channel Bottom of Site
- Bankfull Width
- Control Point

#### Site Attributes

- Stream Temperature Logger
- Stream Temperature Logger Maintenance
- Air Temperature Logger
- Water Chemistry
- Cross-section
- Discharge
- Visit Pool Tail Fines

#### Channel Units

- Pebble
- Channel Segment
- Channel Unit
- Pebble Cross-Section
- Fish Cover
- Substrate Cover
- Large Woody Piece
- Pool Tail Fines
- Undercut Banks

#### Transects

- Transect Photos
- Riparian Sturcture
- Canopy Cover
- Solar Pathfinder

#### Invertebrates

- Drift Invertebrate Sample
- Drift Invertebrate Sample Results
- Taxon By Size Class Counts
- Sample Biomasses

