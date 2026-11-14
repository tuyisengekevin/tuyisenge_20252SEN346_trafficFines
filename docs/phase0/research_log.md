# Research Log – Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL

> **Status:** Working research log. The September 2026 Washington, DC parking-violations CSV has now been inspected. The downloaded file contains 89,078 records and 31 columns, with a unique ticket number in every row. Important limitations and a discrepancy between the public catalogue description and the downloaded CSV are documented below. The research references still need to be checked individually before final submission.

| # | Source (APA) | Type | Link | Key finding | Gap it shows |
|---|---|---|---|---|---|
| 1 | Mishra, R., Kumaraguru, P., Shah, R. R., Sadaria, A., Srikanth, S., Gupta, K., Bhatia, H., & Jain, P. (2020). *Analyzing traffic violations through e-challan system in metropolitan cities* [Workshop paper]. | Research paper | https://cdn.iiit.ac.in/cdn/precog.iiit.ac.in/pubs/2020_Aug_traffic_violations.pdf | This paper studies electronic traffic-challan records and analyzes violation patterns. | Large violation datasets can support analysis, but a database project still needs a normalized structure and clearly defined operational rules. |
| 2 | Dušek, L., Pardo, N., & Traxler, C. (2022). Salience and timely compliance: Evidence from speeding tickets. *Journal of Policy Analysis and Management, 41*(2), 426–449. https://doi.org/10.1002/pam.22387 | Research paper | https://onlinelibrary.wiley.com/doi/full/10.1002/pam.22387 | The study examines how payment notices and penalty information affect timely payment of speeding tickets. | Due dates, payment status and follow-up are useful concepts for a fine-management database, but the project's source dataset may not contain full payment transaction details. |
| 3 | District Department of Transportation. (2026). *Parking violations issued in September 2026* [Dataset]. DC Open Data. | Dataset | https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026 | The official catalogue identifies the dataset as public, published by the District Department of Transportation, and licensed under Creative Commons Attribution 4.0 (CC BY 4.0). The CSV downloaded for this project was inspected: it contains 89,078 rows and 31 columns. Each row has a unique TICKET_NUMBER, so the downloaded file is at ticket-record level. The ISSUE_DATE values cover September 1–30, 2026. | The catalogue description says the Vision Zero data are summarized ticket counts by time of day, week of year, year and violation category, geocoded to street segments. This differs from the downloaded CSV, which contains ticket-level fields. The discrepancy must be disclosed and clarified with the publisher if necessary. The CSV contains fine and total-paid amount fields, but these do not by themselves establish a full payment transaction history. |
| 4 | District of Columbia Department of Public Works. (2025). *FY 2025 Performance Accountability Report*. | Government report/statistic | https://oca.dc.gov/sites/default/files/dc/sites/oca/FY25%20PAR%20-%20DPW.pdf | Reports annual parking enforcement measures, including 1,311,978 parking tickets issued in FY2023 and 1,223,590 in FY2022, plus FY2025 quarterly enforcement measures. | The report gives official enforcement context, but annual/quarterly totals do not provide the detailed records needed for relational analysis; the project dataset must be examined separately. |
| 5 | Maryland Judiciary, District Court. (n.d.). *Traffic citation information*. | Existing system | https://www.mdcourts.gov/district/selfhelp/traffic | Describes public processes for accessing citation information, paying payable citations, and requesting payment plans or hearings. | Existing citation services demonstrate the real-world workflow; this academic prototype is limited to data organization, analysis and database demonstrations. |
| 6 | Oracle. (2024). *Oracle Database PL/SQL Language Reference* (21c). | Technical source | https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/overview.html | Oracle PL/SQL provides procedural programming features such as subprograms, control flow and exception handling. | PL/SQL can implement reusable business rules, validation and reporting inside Oracle. |
| 7 | Microsoft. (n.d.). *Connect to an Oracle database with Power BI Desktop*. Microsoft Learn. | Technical source | https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-connect-oracle-database | Power BI Desktop documents supported methods for connecting to Oracle databases. | The project can build an interactive reporting layer connected to the Oracle database rather than relying on static charts. |

## Dataset verification record

**File inspected:** `Parking_Violations_Issued_in_September_2026.csv`  
**Inspection date:** November 14, 2026  
**Source location:** The downloaded CSV supplied for project analysis. Its presence in the GitHub repository's `data/raw/` folder has not yet been confirmed.

### File structure and record checks

- Total records: **89,078**.
- Total columns: **31**.
- Duplicate complete rows: **0**.
- Duplicate TICKET_NUMBER values: **0**.
- Duplicate OBJECTID values: **0**.
- Distinct issuing-agency names: **29**.
- ISSUE_DATE values were successfully parsed and range from **September 1 to September 30, 2026**.

### Actual columns found

`OBJECTID`, `TICKET_NUMBER`, `VIOLATION_TYPE_DESC`, `ISSUE_DATE`, `ISSUE_TIME`, `ISSUING_AGENCY_CODE`, `ISSUING_AGENCY_NAME`, `ISSUING_AGENCY_SHORT`, `VIOLATION_CODE`, `VIOLATION_PROC_DESC`, `LOCATION`, `PLATE_STATE`, `VEHICLE_TYPE`, `MULTI_OWNER_NUMBER`, `DISPOSITION_CODE`, `DISPOSITION_TYPE`, `DISPOSITION_DESC`, `DISPOSITION_DATE`, `FINE_AMOUNT`, `TOTAL_PAID`, `PENALTY_1`, `PENALTY_2`, `PENALTY_3`, `PENALTY_4`, `PENALTY_5`, `XCOORD`, `YCOORD`, `LATITUDE`, `LONGITUDE`, `MAR_ID`, `GIS_LAST_MOD_DTTM`.

### Missing-value checks

| Column | Missing values | Approx. percentage |
|---|---:|---:|
| VEHICLE_TYPE | 89,078 | 100.00% |
| PLATE_STATE | 88,625 | 99.49% |
| DISPOSITION_DESC | 86,245 | 96.82% |
| DISPOSITION_DATE | 86,233 | 96.81% |
| VIOLATION_PROC_DESC | 1,605 | 1.80% |
| XCOORD, YCOORD, LATITUDE, LONGITUDE and MAR_ID | 735 each | 0.83% |
| LOCATION | 3 | 0.003% |

**Interpretation:** VEHICLE_TYPE cannot be used as a populated analytical attribute in this file. PLATE_STATE, DISPOSITION_DESC and DISPOSITION_DATE are also too incomplete to assume they are consistently available. Location coordinates are missing for a small portion of records. These gaps must be handled during data cleaning and database design; missing values must not be invented.

### Preliminary suitability and privacy assessment

The file contains fields that can support analysis of ticket records, violation categories, issuing agencies, issue dates and times, locations, fine amounts, and recorded total-paid amounts. It therefore provides useful material for a relational database and an analytics dashboard.

The file includes citation identifiers such as TICKET_NUMBER and MULTI_OWNER_NUMBER, as well as PLATE_STATE. The inspected column list does not include a vehicle plate-number or person's-name column. Nevertheless, citation-level identifiers should be treated carefully. Do not publish raw sample rows or expose identifiers in screenshots or dashboard demonstrations. Keep only fields needed for the academic project and review the dataset's terms and privacy implications before sharing the raw CSV publicly.

The values in FINE_AMOUNT and TOTAL_PAID are fields in the source file. They should be described as recorded amounts, not as proof that the dataset contains a complete payment history or individual payment transactions. Any additional payment workflow created for demonstration must be clearly labelled as simulated and kept separate from source records.

### Dataset source-description discrepancy

The Data.gov catalogue description states that the Vision Zero layer contains summarized ticket counts by time of day, week of year, year and violation category, with locations geocoded to street-segment centroids. However, the downloaded CSV has 31 fields including TICKET_NUMBER, ISSUE_DATE, ISSUE_TIME, FINE_AMOUNT and TOTAL_PAID, and its 89,078 TICKET_NUMBER values are unique.

The downloaded file therefore behaves as ticket-level data, while the public catalogue description describes aggregated data. This is an unresolved source-documentation discrepancy. The project will record exactly what was inspected and will not claim that the catalogue description and CSV structure are identical. If clarification is needed, contact the dataset publisher using the contact details on the official catalogue page.

### Dataset licence and geography

The Data.gov catalogue lists the dataset as public and gives the licence as **Creative Commons Attribution 4.0 International (CC BY 4.0)**. The dataset covers Washington, DC, USA; it is not a Rwanda dataset. Attribution to the District Department of Transportation and a link to the source must be retained when the data is reused.

## Research conclusion

The research supports the value of organizing violation information and reporting on patterns, while digital citation workflows illustrate the importance of payment status and deadlines. Inspection of the downloaded September 2026 CSV confirms that it contains 89,078 ticket-level records with 31 columns and unique ticket numbers. The fields support a project focused on analyzing parking-violation records by agency, category, date, time, location and recorded fine amounts.

The database design must account for substantial missing values and must not assume that every record has vehicle type, plate state, disposition description or disposition date. Although the CSV includes FINE_AMOUNT and TOTAL_PAID, it does not establish a complete payment transaction history. Any simulated payment-management features must be clearly separated from the source data and identified as simulated. The mismatch between the catalogue's aggregate-data description and the downloaded ticket-level CSV remains a documented limitation requiring clarification.

## Data integrity and privacy note

Use the inspected CSV values as the evidence for the file's structure and quality. Do not invent missing values or describe recorded amount fields as complete payment transactions. Treat ticket and multi-owner identifiers carefully; exclude them from public screenshots and dashboard displays unless there is a justified need. Retain source attribution and do not describe generated examples as official government records.

## Remaining Phase 0 research checks

1. Ask the dataset publisher to clarify why the catalogue describes summarized ticket counts while the downloaded CSV contains unique ticket-level records.
2. Confirm the final data-cleaning rules and which incomplete fields will be excluded or retained as optional.
3. Decide whether the original CSV should be committed to `data/raw/`; if it is shared, review identifier exposure and include source attribution.
4. Finalize the database scope and entities using the verified file structure. Do not claim a full payment-management workflow unless it is clearly separated as simulated or supported by additional verified data.
5. Read and verify the research references before final submission; the assignment requires at least six credible sources, including two research papers, one report/statistic, one existing system, one dataset and one technical source.
