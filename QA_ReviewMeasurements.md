# Step 4: Review Measurements and Set QA Status



1. Review Quality Assurance Calculations displayed on the Auxillariy Data Grits of the Measurements Tab:   

   - Count of LWD
   - Count of Pebbles
   - Count of Discharge Stations
   - Count of Benchmarks
   - Count of Aux Photos

 ![Measurement Review Counts](https://southforkresearch.github.io/CHaMP-Management/images/MeasurementReview_Counts.png)

   Visits with exceptional values or subject to non-repairable data loss should be noted in the [QA Notes](QA_QAStatus.md) tab. 

2. Review graphs of key [Measurement Type](MeasurementTypes.md) values listed below.  These checks target metadata and values not captured in Metric Review.

| [Measurement Type](MeasurementTypes.md) | X                      | Y                       |                Color By                | Notes        |
| --------------------------------------- | ---------------------- | ----------------------- | :------------------------------------: | ------------ |
| Bankfull Width                          | Site Length            | Average BF Width        |              Data Quality              |              |
| Visit Information                       | Site Length            | Count of LWD            |              Data Quality              |              |
| Site Marker                             | Elevation              | Elevation               |              Data Quality              | Review Nulls |
| Monument                                | Elevation              | Elevation               |              Data Quality              | Review Nulls |
| Benchmark                               | Elevation              | Elevation               |              Data Quality              | Review Nulls |
| Control Point                           | Elevation              | Elevation               |              Data Quality              |              |
| Cross-section                           | Average Bankfull Width | Total Discharge         | Data Quality;  Bankfull Width Category |              |
| Discharge                               | Depth                  | Velocity                |              Data Quality              |              |
| Discharge                               | Depth                  | Station Discharge       |              Data Quality              |              |
| Channel Segment                         | Average Bankfull Width | Side Channel Length     | Data Quality; Bankfull Width Category  |              |
| Channel Segment                         | Average Bankfull Width | Side Channel Width      | Data Quality; Bankfull Width Category  |              |
| Channel Segment                         | Average Bankfull Width | Percent Wetted          | Data Quality; Bankfull Width Category  |              |
| Fish Cover                              | Average Bankfull Width | Total No Fish Cover     | Data Quality; Bankfull Width Category  |              |
| Pebbles                                 | Measurement ID         | Cobble Percent Buried   |      Data Quality; Strahler Order      |              |
| Pebbles                                 | Measurement ID         | Cobble Percent Fines    |      Data Quality; Strahler Order      |              |
| Undercut Banks                          | Average Bankfull Width | Estimated Undercut Area |      Data Quality; Strahler Order      |              |
| Undercut Banks                          | Average Bankfull Width | Average Width           |      Data Quality; Strahler Order      |              |

*NOTE: Point colors are only used to highlight potential issues.  There may be issues with ‘green’ (good)*
*colored data and some red or orange colored points may be fine.  There are no restrictions or flags tracked in the data that relate to point color.*


[Return to QA HOME](QAMain.md)

