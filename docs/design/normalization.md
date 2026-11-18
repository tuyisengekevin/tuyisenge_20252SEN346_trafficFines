# Normalization — Parking Violation Analytics System

**Project:** Parking Violation Analytics System  
**Student ID:** 20252SEN346  
**Source:** `data/raw/parking_violations.csv`  
**Target:** Third Normal Form (3NF)

## 1. Source grain and assumptions

The CSV contains 89,078 ticket records and 31 columns. Each row represents one issued parking citation. `TICKET_NUMBER` is unique in this extract. The raw CSV remains unchanged; cleaning, type conversion, and import validation are Phase IV activities.

The design uses six relations: `ISSUING_AGENCY`, `VIOLATION`, `DISPOSITION`, `LOCATION`, `PARKING_TICKET`, and `TICKET_PENALTY`.

## 2. UNF — Unnormalized Form

The original wide CSV is treated as the UNF source relation. It stores ticket details and five similarly structured penalty columns in one row:

- `PENALTY_1`: Late penalty
- `PENALTY_2`: Not being used currently
- `PENALTY_3`: Collection fees
- `PENALTY_4`: Appeals fees
- `PENALTY_5`: Transcript fees

The five numbered penalty attributes form a repeating group. A ticket may have a value for each of five penalty stages, so the design should store stage number and amount as rows rather than as five separate columns.

### Three source examples

| TICKET_NUMBER | ISSUE_DATE | ISSUING_AGENCY_CODE | VIOLATION_CODE | LOCATION | FINE_AMOUNT | PENALTY_1 | PENALTY_2 |
|---|---|---:|---|---|---:|---:|---:|
| 271253522 | 2026/09/12 04:00:00+00 | 22 | P093 | 17TH ST/ L ST | 50 | 0 | 0 |
| 276427174 | 2026/09/06 04:00:00+00 | 43 | P055 | FRONT 4TH ST | 30 | 0 | 0 |
| 276947020 | 2026/09/07 04:00:00+00 | 51 | P344 | 1300 BLK D ST | 250 | 250 | 0 |

**UNF issue:** the five penalty-stage values are represented by repeated numbered columns.

## 3. 1NF — First Normal Form

To reach 1NF, keep values atomic and replace the five penalty columns with a child relation containing one row per ticket and stage. The child relation uses the composite primary key `(TICKET_NUMBER, PENALTY_STAGE)`.

### Example penalty rows

| TICKET_NUMBER | PENALTY_STAGE | PENALTY_AMOUNT |
|---|---:|---:|
| 271253522 | 1 | 0 |
| 271253522 | 2 | 0 |
| 276947020 | 1 | 250 |

These values are copied from the corresponding source penalty columns. Zero is retained as zero; it is not changed to NULL. The full transformation creates stages 1 through 5 for each ticket, including zero amounts.

**Dependency/repeating-group removed:** penalty stages are stored as individual rows in `TICKET_PENALTY`, not as a repeating group of columns.

## 4. 2NF — Second Normal Form

The penalty relation has a composite key: `(TICKET_NUMBER, PENALTY_STAGE)`. Ticket date, time, agency, violation, location, disposition, and fine attributes depend on `TICKET_NUMBER` alone, not on the complete composite key. These attributes belong in `PARKING_TICKET`. `PENALTY_AMOUNT` depends on both the ticket and stage and remains in `TICKET_PENALTY`.

### PARKING_TICKET examples

| TICKET_NUMBER (PK) | SOURCE_OBJECT_ID (UQ) | AGENCY_CODE (FK) | VIOLATION_CODE (FK) | DISPOSITION_CODE (FK) | FINE_AMOUNT | TOTAL_PAID |
|---|---:|---:|---|---:|---:|---:|
| 271253522 | 85839612 | 22 | P093 | 134 | 50 | 0 |
| 276427174 | 85839613 | 43 | P055 | 106 | 30 | 0 |
| 276947020 | 85839625 | 51 | P344 | 0 | 250 | 0 |

**Partial dependency removed:** ticket-level attributes are separated from the composite-key penalty relation.

## 5. 3NF — Third Normal Form

Descriptive attributes are moved to lookup relations because they depend on their own code or location key, rather than transitively on the ticket key.

Functional dependencies observed in this extract:

- `AGENCY_CODE → AGENCY_NAME, AGENCY_SHORT` (29 agency codes; each code maps to one name and short name).
- `VIOLATION_CODE → VIOLATION_PROC_DESC` (122 codes; at most one non-null description per code; some descriptions are missing).
- `DISPOSITION_CODE → DISPOSITION_TYPE, DISPOSITION_DESC` (29 codes; each code maps to one type and at most one non-null description).
- `LOCATION_TEXT → MAR_ID, XCOORD, YCOORD, LATITUDE, LONGITUDE` for each exact non-null location string; geocoding attributes may be NULL even when location text is present.

### 5.1 ISSUING_AGENCY

| AGENCY_CODE (PK) | AGENCY_NAME | AGENCY_SHORT |
|---:|---|---|
| 22 | UNITED STATES PARK POLICE | USPP |
| 43 | FBI | FBI |
| 51 | PROTECTIVE SERVICES DEPT (DC GOVT) | PSD |

### 5.2 VIOLATION

| VIOLATION_CODE (PK) | VIOLATION_PROC_DESC |
|---|---|
| P093 | OBSTRUCTED TAGS. |
| P055 | NO PARKING ANYTIME |
| P344 | VEHICLE ON PRIVATE/PUBLIC PROPERTY WITHOUT CONSENT |

`VIOLATION_PROC_DESC` is optional because 1,605 source rows have no description.

### 5.3 DISPOSITION

| DISPOSITION_CODE (PK) | DISPOSITION_TYPE | DISPOSITION_DESC |
|---:|---|---|
| 134 | Dismissed | DISM MAKE MISMATCH |
| 106 | Dismissed | DISM NOI SUBM LATE |
| 0 | Other | NULL |

`DISPOSITION_DESC` is optional because 86,245 source rows have no description. `DISPOSITION_DATE` remains on the ticket because it records the date for an individual ticket.

### 5.4 LOCATION

The following are illustrative generated keys, not source-system IDs:

| LOCATION_ID (PK) | LOCATION_TEXT (UQ) | MAR_ID | LATITUDE | LONGITUDE |
|---|---|---:|---:|---:|
| LOC-001 | 17TH ST/ L ST | NULL | NULL | NULL |
| LOC-002 | FRONT 4TH ST | NULL | NULL | NULL |
| LOC-003 | 1300 BLK D ST | 810239 | 38.895 | -76.987 |

The first two tickets have non-empty location text but missing geocoding fields. They still receive location records and generated `LOCATION_ID` values. Only the three source rows whose `LOCATION` itself is missing have no location foreign key. `LOCATION_TEXT` is the alternate unique key. `MAR_ID` is not the primary key because it can correspond to more than one exact source location string.

### 5.5 PARKING_TICKET

| TICKET_NUMBER (PK) | SOURCE_OBJECT_ID (UQ) | AGENCY_CODE (FK) | VIOLATION_CODE (FK) | LOCATION_ID (FK, nullable) | DISPOSITION_CODE (FK) | FINE_AMOUNT | TOTAL_PAID |
|---:|---:|---:|---|---|---:|---:|---:|
| 271253522 | 85839612 | 22 | P093 | LOC-001 | 134 | 50 | 0 |
| 276427174 | 85839613 | 43 | P055 | LOC-002 | 106 | 30 | 0 |
| 276947020 | 85839625 | 51 | P344 | LOC-003 | 0 | 250 | 0 |

The complete `PARKING_TICKET` relation also retains every other ticket-level source attribute: `VIOLATION_TYPE_DESC`, `ISSUE_DATE`, `ISSUE_TIME`, `PLATE_STATE`, `VEHICLE_TYPE`, `MULTI_OWNER_NUMBER`, `DISPOSITION_DATE`, and `GIS_LAST_MOD_DTTM`.

### 5.6 TICKET_PENALTY

| TICKET_NUMBER (PK, FK) | PENALTY_STAGE (PK) | PENALTY_AMOUNT |
|---:|---:|---:|
| 271253522 | 1 | 0 |
| 271253522 | 2 | 0 |
| 276947020 | 1 | 250 |

The composite primary key is `(TICKET_NUMBER, PENALTY_STAGE)`. The five original penalty columns are unpivoted into stage rows. Stage 2 is retained as zero because source metadata says it is not currently used; no source value is silently deleted or changed.

## 6. Final relationships and cardinalities

| Parent | Child | Cardinality | Optionality |
|---|---|---|---|
| ISSUING_AGENCY | PARKING_TICKET | 1 to many | Each ticket references exactly one agency; an agency may have many tickets |
| VIOLATION | PARKING_TICKET | 1 to many | Each ticket references exactly one violation; a violation may appear on many tickets |
| DISPOSITION | PARKING_TICKET | 1 to many | Each ticket references one disposition code in this extract; a code may appear on many tickets |
| LOCATION | PARKING_TICKET | 1 to many | A ticket may have zero or one location; a location may be referenced by many tickets |
| PARKING_TICKET | TICKET_PENALTY | 1 to 5 | Each ticket has five stage rows when all five source penalty columns are retained |

## 7. Design notes and limitations

1. `TICKET_NUMBER` is the business primary key because it is unique in this 89,078-row extract and DC GIS metadata defines it as the issued ticket identifier.
2. `OBJECTID` is retained as a unique source identifier (`SOURCE_OBJECT_ID`), not used as the business primary key.
3. `LOCATION_ID` is a generated surrogate key; exact raw location text is retained as a unique alternate key.
4. `VEHICLE_TYPE` is 100% missing in this extract. It remains optional to preserve the source field; Phase IV may document whether to omit it from analytical views.
5. `PLATE_STATE` is 99.49% missing and remains optional.
6. `MULTI_OWNER_NUMBER` is retained as an identifier/string. The extract contains no NULLs and 84,295 values are `0`; this zero sentinel means no fleet number was supplied in those rows, not a numeric measure.
7. No full plate number, personal name, or phone number is present in this CSV.
8. The raw CSV must remain unchanged in `data/raw/`. All cleaning, null handling, date/time conversion, and import validation belong to Phase IV.
