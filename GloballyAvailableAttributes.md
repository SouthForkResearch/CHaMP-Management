# Riverine Landscape Characteristics 



### Globally Available Attributes (GAAs)

A set of globally available attributes is available for the source Master Sample files that were used by the [Columbia Habitat Monitoring Program (CHaMP)](www.champmonitoring.org).  Attributes are sourced from publically available geospatial datasets. In some cases, datasets have been generated or compiled by South Fork Research.

GAA files are managed by South Fork Research and are available upon request at this time.  We do not anticipate additional file updates until the 1:24k NHD Plus (High Res) dataset is available for Region 17. 

[Attribute Metadata, 5/6/15](https://www.dropbox.com/s/eyk07of4dgx76rc/GAA_Metadata_20150506.xlsx?dl=0)

### File Versions:

* *November 2017*: Landscape Classification values updated to reflect NRCS HUC 6 boundaries instead of REO watershed boundaries. Landscape Classification PCA values for Disturbance Class were updated from integer to double values. Addition of solar, conductivity, and draft GPP values.  

### Notes:

* The broad spatial scale of these attributes requires spatial joins that may result in variable attribute accuracy across the scope of the spatial domain and GAA metrics.  We strongly recommend review of each GAA value of interest prior to extensive use. 
* Source datasets are managed by Source Organizations and current source file versions may differ from GAA file metric values.  



###GAA Source Data



| Dataset                                  | Description                              | Source Organization                      | Source Website                           |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| **Topographic Information**              |                                          |                                          |                                          |
| 10m DEM (NED)                            | Raster file for elevation                | USGS                                     | [LINK](http://viewer.nationalmap.gov/viewer/) |
| **Fish Populations**                     |                                          |                                          |                                          |
| Pacific Northwest salmon ESUs            | NRCS HUC (polygon) delineations of salmon ESU and populations | NOAA-Fisheries                           | [LINK](http://www.nwfsc.noaa.gov/trt/mapsdata.cfm) |
| Salmon distributions (linework)          | Extent of population distribution along hydrography | StreamNet                                | [LINK](http://www.streamnet.org)         |
| **Climate and Hydrology**                |                                          |                                          |                                          |
| NHDPlus V1 and V2, including VIC FLoWs model attributes | 1:100k Hydrography that includes NHD Plus attributes.  SFR has added VIC FLoW model attributes (available upon request) | USGS                                     | [LINK](http://www.horizon-systems.com/NHDPlus/NHDPlusV2_home.php) |
| Precipitation (annual)                   | Raster file of annual precipitation      | Oregon State University                  | [LINK](http://www.prism.oregonstate.edu) |
| Growing Degree Day                       | Raster file of GDD                       | Oregon State University                  | [LINK](http://www.prism.oregonstate.edu) |
| Temperature Range                        | Raster file of temperature ranges        | Oregon State University                  | [LINK](http://www.prism.oregonstate.edu) |
| Stream Temperature                       | 8 day stream temperature estimates (mean, min and max) by year from MODIS land surface temperature models | [South Fork Research (ISEMP)](www.southforkresearch.org) | [LINK](https://github.com/SouthForkResearch/StreamTemperature/wiki) |
| Solar Input to streams                   | ESRI-based solar insolation model run for 1km stream sections within a HUC4 watershed. | [South Fork Research (ISEMP)](www.southforkresearch.org) | [LINK](https://southforkresearch.github.io/mapbox/solar.html) |
| Stream Conductivity                      | Conductivity model run for 1km stream sections within a HUC4 watershed | [South Fork Research (ISEMP)](www.southforkresearch.org) | [LINK](https://southforkresearch.github.io/mapbox/conductivity.html) |
| **Ecoregions and Vegetation**            |                                          |                                          |                                          |
| Omernik Ecoregions                       | Omernik ecoregions (I-IV) for the western US. | EPA                                      | [LINK](http://www.epa.gov/wed/pages/ecoregions/na_eco.htm) |
| Landscape Classification (HUC6)          | Landscape classification of HUC6s based on topographic, climate, disturbance, and land use metrics. | [South Fork Research (ISEMP)](www.southforkresearch.org) |                                          |
| NLCD 2011 land use                       | Land use cover data used to calculate % of upstream catchments with variable LULC codes | USGS                                     | [LINK](http://www.mrlc.gov/)             |
| **Boundaries**                           |                                          |                                          |                                          |
| Counties                                 | County boundaries                        | USDA                                     | [LINK](https://gdg.sc.egov.usda.gov/GDGOrder.aspx) |
| States                                   | State boundaries                         | USDA                                     | [LINK](https://gdg.sc.egov.usda.gov/GDGOrder.aspx) |
| Land Ownership                           | Compiled state and BLM land ownership information, classified by public and private sector. | BLM and states                           | Available upon request                   |
| Interior Columbia River Basin inclusion  | NRCS HUCs within the Interior Columbia River Basin | [South Fork Research (ISEMP)](www.southforkresearch.org) | Available upon request                   |
| NRCS Hydrologic Unit Codes (HUCs)        | Polygon HUC boundaries.                  | NRCS                                     | [LINK](http://nhd.usgs.gov/wbd.html)     |
| **Geomorphic Features**                  |                                          |                                          |                                          |
| Geomorphic Attributes                    | Geomorphic attributes produced by network analysis tools, including channel sinuosity, confinement, threadedness, gradient, and planform | [South Fork Research (ISEMP)](www.southforkresearch.org) | [LINK](https://southforkresearch.github.io/mapbox/gnat.html) |
| Erodible geology                         | State-sourced surficial geology layers merged and re-classed based on grain size and potential for erosion. | [South Fork Research (ISEMP)](www.southforkresearch.org) | Available upon request                   |
|                                          |                                          |                                          |                                          |



