# Data Dictionary — Parking Violation Analytics System

**Project:** Parking Violation Analytics System  
**Student ID:** 20252SEN346  
**Logical design:** Third Normal Form (3NF)

This is a logical data dictionary. Oracle data types and column sizes are intentionally omitted in Phase II; they will be selected during Phase IV.

## 1. ISSUING_AGENCY

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| `AGENCY_CODE` (PK) | Source code identifying the issuing agency | Yes | Yes — primary key |
| `AGENCY_NAME` | Full name of the issuing agency | Yes | No |
| `AGENCY_SHORT` | Agency abbreviation | Yes | Yes — alternate unique key |

## 2. VIOLATION

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| `VIOLATION_CODE` (PK) | Code identifying the cited violation | Yes | Yes — primary key |
| `VIOLATION_PROC_DESC` | Procedural description of the violation | No | No |

The description is optional because 1,605 source records have a missing `VIOLATION_PROC_DESC`.

## 3. DISPOSITION

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| `DISPOSITION_CODE` (PK) | Code representing the final settlement/outcome | Yes | Yes — primary key |
| `DISPOSITION_TYPE` | General type of final settlement | Yes | No |
| `DISPOSITION_DESC` | Detailed description of the final settlement | No | No |

The description is optional because 86,245 source records have a missing `DISPOSITION_DESC`.

## 4. LOCATION

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| `LOCATION_ID` (PK) | Generated identifier for a distinct exact source location string | Yes | Yes — primary key |
| `LOCATION_TEXT` | Original block/street location text | Yes | Yes — alternate unique key |
| `MAR_ID` | DC Master Address Repository identifier | No | No |
| `XCOORD` | Source X coordinate in Maryland State Plane meters | No | No |
| `YCOORD` | Source Y coordinate in Maryland State Plane meters | No | No |
| `LATITUDE` | Geographic latitude in decimal degrees | No | No |
| `LONGITUDE` | Geographic longitude in decimal degrees | No | No |

`LOCATION_ID` is generated during implementation. The exact source location string is the alternate key. `MAR_ID` is not the primary key because it can correspond to more than one location string in this extract. A location string can exist even when all geocoding fields are NULL.

## 5. PARKING_TICKET

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| `TICKET_NUMBER` (PK) | Identifier of the issued ticket | Yes | Yes — primary key |
| `SOURCE_OBJECT_ID` | Original source `OBJECTID` value | Yes | Yes — alternate unique key |
| `VIOLATION_TYPE_DESC` | Source category/code for violation type | Yes | No |
| `ISSUE_DATE` | Date/time when the ticket was issued | Yes | No |
| `ISSUE_TIME` | Time of issue in source HHMM format | Yes | No |
| `AGENCY_CODE` (FK) | Agency that issued the ticket | Yes | No |
| `VIOLATION_CODE` (FK) | Violation cited on the ticket | Yes | No |
| `LOCATION_ID` (FK) | Location associated with the ticket | No | No |
| `PLATE_STATE` | State where the cited vehicle is registered | No | No |
| `VEHICLE_TYPE` | Type of vehicle | No | No |
| `MULTI_OWNER_NUMBER` | Fleet, government, or rental vehicle number when supplied | No — source has no NULLs; 0 is used for no supplied number | No |
| `DISPOSITION_CODE` (FK) | Final disposition code for the ticket | Yes | No |
| `DISPOSITION_DATE` | Date/time the final disposition occurred | No | No |
| `FINE_AMOUNT` | Fine amount assigned to the citation | Yes | No |
| `TOTAL_PAID` | Total amount paid against the citation | Yes | No |
| `GIS_LAST_MOD_DTTM` | Last-modified timestamp from the source GIS record | Yes | No |

`MULTI_OWNER_NUMBER` is preserved as an identifier/string, not used in arithmetic. The source contains no NULLs in this field; 84,295 rows contain `0`, interpreted as the source sentinel for no supplied fleet/government/rental number. `LOCATION_ID` is nullable because three source rows have no `LOCATION` text.

## 6. TICKET_PENALTY

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| `TICKET_NUMBER` (PK, FK) | Ticket to which the penalty stage belongs | Yes | Part of composite primary key |
| `PENALTY_STAGE` (PK) | Stage number from 1 to 5 | Yes | Part of composite primary key |
| `PENALTY_AMOUNT` | Amount recorded for this penalty stage | Yes | No |

**Composite primary key:** (`TICKET_NUMBER`, `PENALTY_STAGE`).  
**Foreign key:** `TICKET_NUMBER` references `PARKING_TICKET.TICKET_NUMBER`.

Penalty stage meanings from source metadata: 1 — Late penalty; 2 — Not being used currently; 3 — Collection fees; 4 — Appeals fees; 5 — Transcript fees.

## 7. Relationships

| Parent table | Child table | Relationship | Optionality |
|---|---|---|---|
| `ISSUING_AGENCY` | `PARKING_TICKET` | One-to-many | Each ticket must reference one agency; an agency may have many tickets |
| `VIOLATION` | `PARKING_TICKET` | One-to-many | Each ticket must reference one violation; a violation may appear on many tickets |
| `DISPOSITION` | `PARKING_TICKET` | One-to-many | Each ticket references one disposition code in this extract; a code may appear on many tickets |
| `LOCATION` | `PARKING_TICKET` | One-to-many | A ticket may have no location; a location may be referenced by many tickets |
| `PARKING_TICKET` | `TICKET_PENALTY` | One-to-five | Each ticket has five stage rows when all five source penalty columns are retained |

## 8. Raw-field mapping

Every source CSV field is mapped below. No raw field is silently discarded.

| Raw CSV field | Target table.column | Mapping / handling |
|---|---|---|
| `OBJECTID` | `PARKING_TICKET.SOURCE_OBJECT_ID` | Preserve as unique source identifier |
| `TICKET_NUMBER` | `PARKING_TICKET.TICKET_NUMBER` | Business primary key |
| `VIOLATION_TYPE_DESC` | `PARKING_TICKET.VIOLATION_TYPE_DESC` | Preserve source category/code |
| `ISSUE_DATE` | `PARKING_TICKET.ISSUE_DATE` | Convert timestamp in Phase IV |
| `ISSUE_TIME` | `PARKING_TICKET.ISSUE_TIME` | Preserve HHMM source value |
| `ISSUING_AGENCY_CODE` | `ISSUING_AGENCY.AGENCY_CODE`; `PARKING_TICKET.AGENCY_CODE` | Lookup key and ticket FK |
| `ISSUING_AGENCY_NAME` | `ISSUING_AGENCY.AGENCY_NAME` | Agency descriptive attribute |
| `ISSUING_AGENCY_SHORT` | `ISSUING_AGENCY.AGENCY_SHORT` | Agency alternate unique key |
| `VIOLATION_CODE` | `VIOLATION.VIOLATION_CODE`; `PARKING_TICKET.VIOLATION_CODE` | Lookup key and ticket FK |
| `VIOLATION_PROC_DESC` | `VIOLATION.VIOLATION_PROC_DESC` | Optional description; preserve missing values |
| `LOCATION` | `LOCATION.LOCATION_TEXT`; `PARKING_TICKET.LOCATION_ID` | One location row per distinct non-null exact text; three source rows are missing it |
| `PLATE_STATE` | `PARKING_TICKET.PLATE_STATE` | Optional; 88,625 missing values |
| `VEHICLE_TYPE` | `PARKING_TICKET.VEHICLE_TYPE` | Optional; all 89,078 values are missing |
| `MULTI_OWNER_NUMBER` | `PARKING_TICKET.MULTI_OWNER_NUMBER` | Preserve as identifier/string; zero sentinel means no supplied number |
| `DISPOSITION_CODE` | `DISPOSITION.DISPOSITION_CODE`; `PARKING_TICKET.DISPOSITION_CODE` | Lookup key and ticket FK |
| `DISPOSITION_TYPE` | `DISPOSITION.DISPOSITION_TYPE` | Disposition descriptive attribute |
| `DISPOSITION_DESC` | `DISPOSITION.DISPOSITION_DESC` | Optional description; preserve missing values |
| `DISPOSITION_DATE` | `PARKING_TICKET.DISPOSITION_DATE` | Optional ticket-level timestamp |
| `FINE_AMOUNT` | `PARKING_TICKET.FINE_AMOUNT` | Monetary value |
| `TOTAL_PAID` | `PARKING_TICKET.TOTAL_PAID` | Monetary value |
| `PENALTY_1` | `TICKET_PENALTY.PENALTY_AMOUNT` | Unpivot to stage 1 |
| `PENALTY_2` | `TICKET_PENALTY.PENALTY_AMOUNT` | Unpivot to stage 2; source metadata says not currently used |
| `PENALTY_3` | `TICKET_PENALTY.PENALTY_AMOUNT` | Unpivot to stage 3 |
| `PENALTY_4` | `TICKET_PENALTY.PENALTY_AMOUNT` | Unpivot to stage 4 |
| `PENALTY_5` | `TICKET_PENALTY.PENALTY_AMOUNT` | Unpivot to stage 5 |
| `XCOORD` | `LOCATION.XCOORD` | Optional numeric coordinate |
| `YCOORD` | `LOCATION.YCOORD` | Optional numeric coordinate |
| `LATITUDE` | `LOCATION.LATITUDE` | Optional decimal-degree coordinate |
| `LONGITUDE` | `LOCATION.LONGITUDE` | Optional decimal-degree coordinate |
| `MAR_ID` | `LOCATION.MAR_ID` | Optional address identifier; not a primary key |
| `GIS_LAST_MOD_DTTM` | `PARKING_TICKET.GIS_LAST_MOD_DTTM` | Convert source timestamp in Phase IV |

## 9. Phase IV implementation checklist

- Confirm Oracle date/time conversion using the exact source strings and timezone suffix.
- Keep ticket numbers and fleet/government/rental identifiers as identifiers, not numeric measures.
- Preserve the raw CSV unchanged; import into a staging table before cleaning.
- Validate foreign keys against agency, violation, disposition, and location lookup tables.
- Retain missing values and zero values distinctly until a documented cleaning rule is approved.
