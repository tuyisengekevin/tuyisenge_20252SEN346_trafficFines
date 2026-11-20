# Normalization — Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Source:** data/raw/parking_violations.csv  
**Target:** Third Normal Form (3NF)

## 1. Source grain and rules

The original CSV contains 89,078 ticket records and 31 columns. One row represents one issued parking citation. TICKET_NUMBER and OBJECTID are each unique. The raw CSV remains unchanged; cleaning, type conversion and loading are Phase IV tasks.

The final logical design has seven related tables: ISSUING_AGENCY, VIOLATION_TYPE, VIOLATION, DISPOSITION, LOCATION, PARKING_TICKET and TICKET_PENALTY. No many-to-many relationship is present, so no junction table is required.

## 2. UNF — Unnormalized Form

The original wide CSV is the unnormalized source relation. It stores five similarly structured penalty columns in one ticket row:

- PENALTY_1: late penalty
- PENALTY_2: not currently used (all zero in this extract)
- PENALTY_3: collection fees
- PENALTY_4: appeals fees
- PENALTY_5: transcript fees

These five numbered attributes form a repeating group.

### Three real rows from the raw CSV

| TICKET_NUMBER | ISSUE_DATE | AGENCY_CODE | VIOLATION_CODE | LOCATION | FINE_AMOUNT | PENALTY_1 | PENALTY_2 | PENALTY_3 | PENALTY_4 | PENALTY_5 |
|---:|---|---:|---|---|---:|---:|---:|---:|---:|---:|
| 271253522 | 2026/09/12 04:00:00+00 | 22 | P093 | 17TH ST/ L ST | 50 | 0 | 0 | 0 | 0 | 0 |
| 276427174 | 2026/09/06 04:00:00+00 | 43 | P055 | FRONT 4TH ST | 30 | 0 | 0 | 0 | 0 | 0 |
| 276947020 | 2026/09/07 04:00:00+00 | 51 | P344 | 1300 BLK D ST | 250 | 250 | 0 | 0 | 0 | 0 |

**UNF issue:** five penalty-stage values are stored as repeated numbered columns in one ticket row.

## 3. 1NF — First Normal Form

Keep values atomic and convert the repeating penalty group into a child relation. Each row in TICKET_PENALTY represents one ticket-stage combination. Its composite primary key is (TICKET_NUMBER, PENALTY_STAGE).

### Three real penalty-stage rows

| TICKET_NUMBER | PENALTY_STAGE | PENALTY_AMOUNT |
|---:|---:|---:|
| 271253522 | 1 | 0 |
| 271253522 | 2 | 0 |
| 276947020 | 1 | 250 |

Zero remains zero, not NULL. The complete unpivot creates five stage rows for each ticket, including zero values.

**Repeating group removed:** penalty stages are separate rows in TICKET_PENALTY, not five repeated columns.

## 4. 2NF — Second Normal Form

The penalty relation has composite key (TICKET_NUMBER, PENALTY_STAGE). Ticket date, time, agency, category, violation, location, disposition, fine and paid attributes depend on TICKET_NUMBER alone, not the complete composite key. They belong in PARKING_TICKET. PENALTY_AMOUNT depends on both ticket and stage and remains in TICKET_PENALTY.

### PARKING_TICKET — three real rows

| TICKET_NUMBER (PK) | SOURCE_OBJECT_ID (UQ) | AGENCY_CODE (FK) | TYPE (FK) | VIOLATION_CODE (FK) | DISPOSITION_CODE (FK) | FINE_AMOUNT | TOTAL_PAID |
|---:|---:|---:|---|---|---:|---:|---:|
| 271253522 | 85839612 | 22 | P | P093 | 134 | 50 | 0 |
| 276427174 | 85839613 | 43 | P | P055 | 106 | 30 | 0 |
| 276947020 | 85839625 | 51 | P | P344 | 0 | 250 | 0 |

### TICKET_PENALTY — three real rows

| TICKET_NUMBER (PK, FK) | PENALTY_STAGE (PK) | PENALTY_AMOUNT |
|---:|---:|---:|
| 271253522 | 1 | 0 |
| 271253522 | 2 | 0 |
| 276947020 | 1 | 250 |

**Partial dependency removed:** ticket attributes depending only on TICKET_NUMBER are separated from the composite-key penalty relation. PENALTY_AMOUNT depends on the full ticket-and-stage key.

## 5. 3NF — Third Normal Form

Descriptive attributes are moved to reference tables when they depend on their own identifier rather than the ticket key. Dependencies checked against this extract:

- AGENCY_CODE → AGENCY_NAME, AGENCY_SHORT (29 codes; each maps to one name and short name).
- VIOLATION_CODE → VIOLATION_PROC_DESC (122 codes; at most one non-null description per code).
- DISPOSITION_CODE → DISPOSITION_TYPE, DISPOSITION_DESC (29 codes; one type and at most one non-null description per code).
- LOCATION_TEXT → MAR_ID, XCOORD, YCOORD, LATITUDE, LONGITUDE for exact non-null location strings; non-null mapped values are consistent.
- VIOLATION_TYPE_DESC has four values (P, V, T, M). It is stored as a separate reference domain. It is not determined by VIOLATION_CODE for every row: three violation codes occur with multiple category values. The ticket therefore references category and violation code independently.

### 5.1 ISSUING_AGENCY

| AGENCY_CODE (PK) | AGENCY_NAME | AGENCY_SHORT |
|---:|---|---|
| 22 | UNITED STATES PARK POLICE | USPP |
| 43 | FBI | FBI |
| 51 | PROTECTIVE SERVICES DEPT (DC GOVT) | PSD |

### 5.2 VIOLATION_TYPE

| VIOLATION_TYPE_DESC (PK) |
|---|
| P |
| V |
| T |
| M |

These are the exact source category codes; expanded labels are not invented.

### 5.3 VIOLATION

| VIOLATION_CODE (PK) | VIOLATION_PROC_DESC |
|---|---|
| P093 | OBSTRUCTED TAGS. |
| P055 | NO PARKING ANYTIME |
| P344 | VEHICLE ON PRIVATE/PUBLIC PROPERTY WITHOUT CONSENT |

VIOLATION_PROC_DESC is optional because 1,605 source rows have no description.

### 5.4 DISPOSITION

| DISPOSITION_CODE (PK) | DISPOSITION_TYPE | DISPOSITION_DESC |
|---:|---|---|
| 134 | Dismissed | DISM MAKE MISMATCH |
| 106 | Dismissed | DISM NOI SUBM LATE |
| 0 | Other | NULL |

DISPOSITION_DESC is optional because 86,245 source rows have no description. DISPOSITION_DATE remains ticket-level.

### 5.5 LOCATION

LOCATION_ID values below are illustrative generated surrogate keys, not source IDs.

| LOCATION_ID (PK) | LOCATION_TEXT (UQ) | MAR_ID | LATITUDE | LONGITUDE |
|---|---|---:|---:|---:|
| LOC-001 | 17TH ST/ L ST | NULL | NULL | NULL |
| LOC-002 | FRONT 4TH ST | NULL | NULL | NULL |
| LOC-003 | 1300 BLK D ST | 810239 | 38.895 | -76.987 |

A non-empty location string can have NULL geocoding attributes. Only three source rows have no LOCATION text and therefore no location FK. MAR_ID is not unique across location strings.

### 5.6 PARKING_TICKET

| TICKET_NUMBER (PK) | SOURCE_OBJECT_ID (UQ) | AGENCY_CODE (FK) | TYPE (FK) | VIOLATION_CODE (FK) | LOCATION_ID (FK, nullable) | DISPOSITION_CODE (FK) | FINE_AMOUNT | TOTAL_PAID |
|---:|---:|---:|---|---|---|---:|---:|---:|
| 271253522 | 85839612 | 22 | P | P093 | LOC-001 | 134 | 50 | 0 |
| 276427174 | 85839613 | 43 | P | P055 | LOC-002 | 106 | 30 | 0 |
| 276947020 | 85839625 | 51 | P | P344 | LOC-003 | 0 | 250 | 0 |

The complete ticket table also retains ISSUE_DATE, ISSUE_TIME, PLATE_STATE, VEHICLE_TYPE, MULTI_OWNER_NUMBER, DISPOSITION_DATE and GIS_LAST_MOD_DTTM.

### 5.7 TICKET_PENALTY

| TICKET_NUMBER (PK, FK) | PENALTY_STAGE (PK) | PENALTY_AMOUNT |
|---:|---:|---:|
| 271253522 | 1 | 0 |
| 271253522 | 2 | 0 |
| 276947020 | 1 | 250 |

The composite primary key is (TICKET_NUMBER, PENALTY_STAGE). Each of the five source penalty columns maps to one stage row. Stages 2–5 are retained although their values are zero throughout this extract.

## 6. Relationships, cardinality and optionality

| Parent | Child | Cardinality | Optionality |
|---|---|---|---|
| ISSUING_AGENCY | PARKING_TICKET | 1 to many | Each ticket must reference exactly one agency; an agency may have zero or many tickets. |
| VIOLATION_TYPE | PARKING_TICKET | 1 to many | Each ticket must reference exactly one category; a category may be used by zero or many tickets. |
| VIOLATION | PARKING_TICKET | 1 to many | Each ticket must reference exactly one violation code; a code may appear on zero or many tickets. |
| DISPOSITION | PARKING_TICKET | 1 to many | Each ticket references one disposition code in this extract; a code may apply to zero or many tickets. |
| LOCATION | PARKING_TICKET | 1 to many | A ticket may reference zero or one location; a location may be referenced by zero or many tickets. |
| PARKING_TICKET | TICKET_PENALTY | 1 to 5 | Each ticket has five stage rows; each stage row belongs to exactly one ticket. |

## 7. Design notes and limitations

1. TICKET_NUMBER is the business primary key because it is unique in this extract; store it as an identifier, not a quantity.
2. OBJECTID is retained as unique SOURCE_OBJECT_ID, not the business primary key.
3. LOCATION_ID is generated; exact location text is its unique alternate key.
4. VEHICLE_TYPE is 100% missing and remains optional for traceability.
5. PLATE_STATE is 99.49% missing and remains optional.
6. MULTI_OWNER_NUMBER has no NULLs; 84,295 values are 0. Preserve it as an identifier; zero is a source sentinel, not a count.
7. No full plate number, person's name or phone number is present.
8. ISSUE_DATE includes a UTC timestamp suffix and ISSUE_TIME separately stores HHMM; preserve both and document conversion in Phase IV.
9. PENALTY_2–PENALTY_5 are all zero but remain mapped for traceability.
10. Keep the raw CSV unchanged. Cleaning, NULL handling, type conversion and import validation belong to Phase IV.
