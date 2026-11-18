# Dataset Card — Parking Violations Issued in September 2026

**Project:** Parking Violation Analytics System  
**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 — Database Development with PL/SQL

## 1. Dataset identification

| Item | Details |
|---|---|
| Dataset title | Parking Violations Issued in September 2026 |
| Publisher | District Department of Transportation (DDOT), District of Columbia |
| Data.gov catalogue | https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026 |
| Official CSV resource | https://opendata.dc.gov/api/download/v1/items/52bcc739569546a7a6cea61ff7373831/csv?layers=8 |
| ArcGIS layer | https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Violations_Parking_2026/MapServer/8 |
| Licence | Creative Commons Attribution 4.0 International (CC BY 4.0) — https://creativecommons.org/licenses/by/4.0/ |
| Access / format | Public / CSV |
| Repository file | `data/raw/parking_violations.csv` |
| File size | 22,119,094 bytes (about 21.09 MiB) |
| Dataset period | 1–30 September 2026 |
| Original download date | Not recorded. The local project copy was first uploaded to the workspace on 14 November 2026; that is an upload date, not a verified collection/download date. |

## 2. What one record represents

Each row represents one issued parking citation/ticket. The CSV contains **89,078 rows and 31 columns**. `TICKET_NUMBER` is unique in this extract (89,078 distinct values).

Although the catalogue description uses general wording about summarized parking-citation locations, the downloaded CSV is ticket-level: it includes `TICKET_NUMBER`, and the DC GIS metadata describes the source as a running list of parking-violation citations. The logical database design therefore follows the actual downloaded file's row grain.

## 3. Dataset size and structure

| Measure | Observed result |
|---|---:|
| Data rows (excluding header) | 89,078 |
| Columns | 31 |
| Distinct ticket numbers | 89,078 |
| Distinct OBJECTID values | 89,078 |
| Distinct issuing agency codes | 29 |
| Distinct violation codes | 122 |
| Distinct disposition codes | 29 |
| Distinct non-null location text values | 11,923 |
| Complete duplicate rows | 0 |

## 4. Data quality assessment before cleaning

Counts were measured directly from the downloaded CSV. No values have been corrected, deleted, or imputed in Phase II; cleaning is reserved for Phase IV.

| Field | Missing values | Missing % |
|---|---:|---:|
| `VEHICLE_TYPE` | 89,078 | 100.00% |
| `PLATE_STATE` | 88,625 | 99.49% |
| `DISPOSITION_DESC` | 86,245 | 96.82% |
| `DISPOSITION_DATE` | 86,233 | 96.81% |
| `VIOLATION_PROC_DESC` | 1,605 | 1.80% |
| `XCOORD` | 735 | 0.83% |
| `YCOORD` | 735 | 0.83% |
| `LATITUDE` | 735 | 0.83% |
| `LONGITUDE` | 735 | 0.83% |
| `MAR_ID` | 735 | 0.83% |
| `LOCATION` | 3 | 0.003% |

All other columns have zero missing values in this local CSV.

### Additional quality checks

- Complete duplicate rows: **0**.
- Duplicate `OBJECTID` values: **0**.
- Duplicate `TICKET_NUMBER` values: **0**.
- Invalid `ISSUE_DATE` values under date parsing: **0**.
- `ISSUE_TIME` values outside valid HHMM clock ranges: **0**.
- Negative values in `FINE_AMOUNT`, `TOTAL_PAID`, or `PENALTY_1`–`PENALTY_5`: **0**.
- `VEHICLE_TYPE` is entirely empty in this extract.
- `PENALTY_2` is zero throughout; DC metadata says this penalty field is not currently being used.
- `MULTI_OWNER_NUMBER` has no NULLs; 84,295 rows contain `0`. DC metadata describes it as a fleet, government, or rental vehicle number when one exists. Preserve it as an identifier/string; do not treat zero as a measured quantity.
- `GIS_LAST_MOD_DTTM` has one distinct timestamp across all 89,078 rows in this extract. This is a source-snapshot characteristic, not evidence of 89,078 individual update events.
- The file contains no person's name, phone number, or full vehicle plate number.

High missingness in disposition details must not be interpreted as proof that a ticket has no outcome. The source contains many `DISPOSITION_TYPE = Other` rows while disposition descriptions and dates are often blank. Preserve those blanks in Phase II and document any later handling rules in Phase IV.

## 5. Main subject areas and logical model

The 31 source fields describe ticket identity and issue time; issuing agency; violation; location and geographic coordinates; vehicle attributes; disposition; fine and paid amounts; penalty stages; and source GIS modification time.

The proposed normalized logical model contains six related tables: `PARKING_TICKET`, `ISSUING_AGENCY`, `VIOLATION`, `DISPOSITION`, `LOCATION`, and `TICKET_PENALTY`.

## 6. Source references and attribution

1. District Department of Transportation. (2026). *Parking Violations Issued in September 2026*. Data.gov. https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026
2. DC Open Data. (2026). *Parking Violations — September 2026* [CSV]. https://opendata.dc.gov/api/download/v1/items/52bcc739569546a7a6cea61ff7373831/csv?layers=8
3. DC GIS. (2026). *Parking Violations — September 2026* [ArcGIS REST layer]. https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Violations_Parking_2026/MapServer/8
4. Creative Commons. (2013). *Attribution 4.0 International (CC BY 4.0)*. https://creativecommons.org/licenses/by/4.0/

**Attribution:** Contains data provided by the District Department of Transportation / DC GIS, licensed under CC BY 4.0.
