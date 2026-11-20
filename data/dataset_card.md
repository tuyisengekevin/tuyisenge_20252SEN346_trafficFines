# Dataset Card — Parking Violations Issued in September 2026

**Project:** Parking Violations Analytics and Fine Management System  
**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 — Database Development with PL/SQL

## 1. Dataset identification

| Item | Details |
|---|---|
| Dataset title | Parking Violations Issued in September 2026 |
| Publisher | District Department of Transportation (DDOT), District of Columbia, USA |
| Data.gov catalogue | https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026 |
| Official CSV | https://opendata.dc.gov/api/download/v1/items/52bcc739569546a7a6cea61ff7373831/csv?layers=8 |
| ArcGIS layer | https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Violations_Parking_2026/MapServer/8 |
| Licence | Creative Commons Attribution 4.0 International (CC BY 4.0) — https://creativecommons.org/licenses/by/4.0/ |
| Access / format | Public / CSV, one header row |
| Repository file | data/raw/parking_violations.csv |
| File size | 22,119,094 bytes (about 21.09 MiB) |
| Dataset period | 1–30 September 2026 |
| Download date | Original download date was not recorded. The local copy was uploaded to the workspace on 14 November 2026; this is not claimed as the verified download date. |

## 2. What one record represents

Each data row represents one issued parking citation/ticket. The CSV contains **89,078 data rows and 31 columns**. TICKET_NUMBER is unique in this extract (89,078 distinct values).

The catalogue description uses general wording about summarized parking-citation locations, while the downloaded CSV is ticket-level: it includes TICKET_NUMBER and the DC GIS layer metadata describes a running list of parking-violation citations. The logical design follows the actual downloaded file's row grain.

## 3. Dataset size and structure

| Measure | Observed result |
|---|---:|
| Data rows (excluding header) | 89,078 |
| Columns | 31 |
| Distinct TICKET_NUMBER values | 89,078 |
| Distinct OBJECTID values | 89,078 |
| Distinct issuing agency codes | 29 |
| Distinct violation codes | 122 |
| Distinct VIOLATION_TYPE_DESC category values | 4 (P, V, T, M) |
| Distinct disposition codes | 29 |
| Distinct non-null location text values | 11,923 |
| Complete duplicate rows | 0 |
| Duplicate ticket numbers | 0 |
| Duplicate OBJECTID values | 0 |

## 4. Data quality assessment before cleaning

Counts were measured from the original CSV. **No source values have been corrected, deleted or imputed in Phase II.** Cleaning and loading belong to Phase IV.

| Field | Missing values | Missing % |
|---|---:|---:|
| VEHICLE_TYPE | 89,078 | 100.00% |
| PLATE_STATE | 88,625 | 99.49% |
| DISPOSITION_DESC | 86,245 | 96.82% |
| DISPOSITION_DATE | 86,233 | 96.81% |
| VIOLATION_PROC_DESC | 1,605 | 1.80% |
| XCOORD | 735 | 0.83% |
| YCOORD | 735 | 0.83% |
| LATITUDE | 735 | 0.83% |
| LONGITUDE | 735 | 0.83% |
| MAR_ID | 735 | 0.83% |
| LOCATION | 3 | 0.003% |

All other columns have zero missing values.

### Additional quality checks

- Invalid/unparseable ISSUE_DATE values: **0**.
- ISSUE_TIME values outside valid HHMM ranges: **0** (minimum 0000, maximum 2359).
- Negative values in FINE_AMOUNT, TOTAL_PAID or PENALTY_1–PENALTY_5: **0**.
- FINE_AMOUNT ranges from 0 to 1,000; TOTAL_PAID ranges from 0 to 500.
- PENALTY_1 is non-zero in 18,561 rows. PENALTY_2, PENALTY_3, PENALTY_4 and PENALTY_5 are zero in all 89,078 rows. Source metadata describes stage 2 as not currently used; stages 3–5 are retained as supplied.
- MULTI_OWNER_NUMBER has no NULL values; 84,295 rows contain 0. DC GIS metadata describes it as a fleet, government or rental vehicle number when present. Preserve it as an identifier, not a quantity.
- GIS_LAST_MOD_DTTM has one distinct timestamp across all 89,078 rows; this is a snapshot characteristic.
- The file contains no person's name, phone number or full vehicle plate number. PLATE_STATE is a registration-state field and is mostly missing.
- For each exact non-null LOCATION string, non-null coordinate/address values are consistent. MAR_ID is not unique across location strings.
- VIOLATION_CODE does not determine VIOLATION_TYPE_DESC in every row: three codes have more than one category value. Category and violation code are therefore separate ticket references.

High missingness in disposition details does not prove a ticket has no outcome. Preserve blanks in Phase II and document handling in Phase IV.

## 5. Main subject areas and logical model

The 31 fields describe ticket identity and issue time; violation category and code; issuing agency; location and coordinates; vehicle attributes; disposition; fine and paid amounts; penalty stages; and the source GIS modification timestamp.

The Phase II model contains **seven related tables**: PARKING_TICKET, ISSUING_AGENCY, VIOLATION_TYPE, VIOLATION, DISPOSITION, LOCATION and TICKET_PENALTY. No many-to-many relationship requires a junction table.

## 6. Source references and attribution

1. District Department of Transportation. (2026). *Parking Violations Issued in September 2026* [Data set]. Data.gov. https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026
2. DC Open Data. (2026). *Parking Violations — September 2026* [CSV]. https://opendata.dc.gov/api/download/v1/items/52bcc739569546a7a6cea61ff7373831/csv?layers=8
3. DC GIS. (2026). *Parking Violations — September 2026* [ArcGIS REST layer]. https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Violations_Parking_2026/MapServer/8
4. Creative Commons. (2013). *Attribution 4.0 International (CC BY 4.0)*. https://creativecommons.org/licenses/by/4.0/

**Attribution:** Contains data provided by the District Department of Transportation / DC GIS, licensed under CC BY 4.0.
