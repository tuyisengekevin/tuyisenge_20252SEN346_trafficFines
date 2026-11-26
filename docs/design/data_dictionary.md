# Data Dictionary — Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Logical design:** Third Normal Form (3NF)

This is a logical data dictionary. Oracle data types and column sizes are intentionally omitted in Phase II; they will be selected during Phase IV.

## 1. ISSUING_AGENCY

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| AGENCY_CODE (PK) | Source code identifying the issuing agency | Yes | Yes — primary key |
| AGENCY_NAME | Full name of the issuing agency | Yes | No |
| AGENCY_SHORT | Agency abbreviation | Yes | Yes — alternate unique key |

## 2. VIOLATION_TYPE

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| VIOLATION_TYPE_DESC (PK) | Source category code for the ticket type (P, V, T or M) | Yes | Yes — primary key |

The source field name contains DESC, but the observed values are short category codes, not full descriptive text. Preserve the four values exactly; do not infer expanded meanings.

## 3. VIOLATION

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| VIOLATION_CODE (PK) | Code identifying the cited violation | Yes | Yes — primary key |
| VIOLATION_PROC_DESC | Procedural description of the violation | No | No |

The description is optional because 1,605 source rows have no value. VIOLATION_CODE does not determine VIOLATION_TYPE_DESC for every record, so category is a separate ticket foreign key.

## 4. DISPOSITION

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| DISPOSITION_CODE (PK) | Code representing the recorded ticket outcome/disposition | Yes | Yes — primary key |
| DISPOSITION_TYPE | General type of disposition | Yes | No |
| DISPOSITION_DESC | Detailed description of the disposition | No | No |

DISPOSITION_DESC is optional because 86,245 source rows have no description. A missing description does not by itself mean the ticket has no disposition.

## 5. LOCATION

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| LOCATION_ID (PK) | Generated identifier for a distinct exact source location string | Yes | Yes — primary key |
| LOCATION_TEXT | Original block/street location text | Yes | Yes — alternate unique key |
| MAR_ID | DC Master Address Repository identifier | No | No |
| XCOORD | Source X coordinate in Maryland State Plane meters | No | No |
| YCOORD | Source Y coordinate in Maryland State Plane meters | No | No |
| LATITUDE | Geographic latitude in decimal degrees | No | No |
| LONGITUDE | Geographic longitude in decimal degrees | No | No |

LOCATION_ID is generated during implementation. Exact source location text is the alternate key. MAR_ID is not the primary key because it can correspond to multiple location strings. A location string can exist when geocoding values are NULL. Three ticket rows have no LOCATION text and therefore no location FK.

## 6. PARKING_TICKET

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| TICKET_NUMBER (PK) | Identifier of the issued parking ticket | Yes | Yes — primary key |
| SOURCE_OBJECT_ID | Original source OBJECTID value | Yes | Yes — alternate unique key |
| VIOLATION_TYPE_DESC (FK) | Source category code for the ticket (P, V, T or M) | Yes | No |
| ISSUE_DATE | Source date/timestamp when the ticket was issued | Yes | No |
| ISSUE_TIME | Local issue time represented by source HHMM integer | Yes | No |
| AGENCY_CODE (FK) | Agency that issued the ticket | Yes | No |
| VIOLATION_CODE (FK) | Violation cited on the ticket | Yes | No |
| LOCATION_ID (FK) | Location associated with the ticket | No | No |
| PLATE_STATE | State where the cited vehicle is registered | No | No |
| VEHICLE_TYPE | Vehicle type from the source | No | No |
| MULTI_OWNER_NUMBER | Fleet, government or rental vehicle number when supplied; source uses 0 for no supplied number | Yes | No |
| DISPOSITION_CODE (FK) | Recorded disposition code for the ticket | Yes | No |
| DISPOSITION_DATE | Date/time the disposition occurred | No | No |
| FINE_AMOUNT | Fine amount recorded for the citation | Yes | No |
| TOTAL_PAID | Total amount recorded as paid against the citation | Yes | No |
| GIS_LAST_MOD_DTTM | Last-modified timestamp from the source GIS record | Yes | No |

TICKET_NUMBER and MULTI_OWNER_NUMBER are identifiers, not quantities. MULTI_OWNER_NUMBER has no NULLs; 84,295 rows contain the zero sentinel. LOCATION_ID is nullable because three source rows have no LOCATION text. VEHICLE_TYPE is optional because all 89,078 values are missing. PLATE_STATE is optional because 88,625 values are missing.

## 7. TICKET_PENALTY

| Column | Meaning | Required? | Unique? |
|---|---|---|---|
| TICKET_NUMBER (PK, FK) | Ticket to which the penalty stage belongs | Yes | Part of composite primary key |
| PENALTY_STAGE (PK) | Stage number from 1 to 5 | Yes | Part of composite primary key |
| PENALTY_AMOUNT | Amount recorded for this penalty stage | Yes | No |

**Composite primary key:** (TICKET_NUMBER, PENALTY_STAGE).  
**Foreign key:** TICKET_NUMBER references PARKING_TICKET.TICKET_NUMBER.

Source metadata describes stages as: 1 late penalty; 2 not currently used; 3 collection fees; 4 appeals fees; 5 transcript fees. Stages 2–5 are all zero in this extract but remain represented for traceability.

## 8. Final Phase IV relationships, cardinality, optionality and delete rules

The final Phase IV ERD is maintained in [final ERD (SVG)](erd_phase4.svg) and its [editable Graphviz source](erd.dot). It reflects the seven-table Oracle schema created by `database/setup/07_create_tables.sql`, with the following referential actions selected for the Phase IV implementation.

| FK constraint | Parent table | Child table | Child FK nullable? | Cardinality / optionality | Delete rule | Reason |
|---|---|---|---|---|---|---|
| FK_TICKET_AGENCY | ISSUING_AGENCY | PARKING_TICKET | No | Agency 0..N tickets; each ticket exactly 1 agency | NO ACTION (Oracle default) | Retain agency reference while tickets exist; reject deleting a referenced agency. |
| FK_TICKET_VIOLATION_TYPE | VIOLATION_TYPE | PARKING_TICKET | No | Category 0..N tickets; each ticket exactly 1 category | NO ACTION | Preserve category integrity and reject deletion while referenced. |
| FK_TICKET_VIOLATION | VIOLATION | PARKING_TICKET | No | Violation code 0..N tickets; each ticket exactly 1 code | NO ACTION | Keep ticket citation history intact. |
| FK_TICKET_DISPOSITION | DISPOSITION | PARKING_TICKET | No | Disposition 0..N tickets; each ticket exactly 1 disposition code | NO ACTION | Do not delete a disposition code used by ticket history. |
| FK_TICKET_LOCATION | LOCATION | PARKING_TICKET | Yes | Location 0..N tickets; each ticket 0..1 location | ON DELETE SET NULL | A location can be removed while preserving the ticket; ticket LOCATION_ID becomes NULL. |
| FK_PENALTY_TICKET | PARKING_TICKET | TICKET_PENALTY | No | Ticket 0..5 penalty stage rows; each stage exactly 1 ticket | ON DELETE CASCADE | Penalty-stage rows are dependent details and should not remain without their ticket. |

**Implementation status:** The existing table-creation script currently defines foreign keys with Oracle's default NO ACTION. The SET NULL and CASCADE actions above are the selected Phase IV target rules and must be applied by the dedicated constraints script (drop/recreate only the relevant foreign keys) and verified with the referential-action tests. Do not claim those two actions are active until the script has been run successfully.

Oracle does not support `ON UPDATE CASCADE`. Primary/foreign key updates should normally be avoided for these stable identifiers. If a key correction is necessary, update child keys and parent key in a controlled transaction with constraints handled safely, or use a stable surrogate key and update descriptive/business attributes instead.

## 8.1 Constraint inventory from the existing table script

The following named constraints are declared in `database/setup/07_create_tables.sql`:

- Primary keys: `PK_ISSUING_AGENCY`, `PK_VIOLATION_TYPE`, `PK_VIOLATION`, `PK_DISPOSITION`, `PK_LOCATION`, `PK_PARKING_TICKET`, `PK_TICKET_PENALTY`.
- Unique constraints: `UQ_AGENCY_SHORT`, `UQ_LOCATION_TEXT`, `UQ_TICKET_SOURCE_OBJECT`.
- Foreign keys: `FK_TICKET_VIOLATION_TYPE`, `FK_TICKET_AGENCY`, `FK_TICKET_VIOLATION`, `FK_TICKET_LOCATION`, `FK_TICKET_DISPOSITION`, `FK_PENALTY_TICKET`.
- Check constraints: `CK_VIOLATION_TYPE_CODE`, `CK_LOCATION_LATITUDE`, `CK_LOCATION_LONGITUDE`, `CK_TICKET_ISSUE_TIME`, `CK_TICKET_FINE_AMOUNT`, `CK_TICKET_TOTAL_PAID`, `CK_PENALTY_STAGE`, `CK_PENALTY_AMOUNT`.
- NOT NULL constraints are declared on every required column in the table definitions. Oracle may generate system names for these column-level NOT NULL constraints; Phase IV will explicitly review naming and the data dictionary status as required by the assignment.

## 9. Raw-field mapping and Phase IV conversion checklist

Every one of the 31 source CSV fields is mapped below. No field is silently discarded.

| Raw CSV field | Target table.column | Mapping / Phase IV handling |
|---|---|---|
| OBJECTID | PARKING_TICKET.SOURCE_OBJECT_ID | Preserve as unique source identifier; validate uniqueness. |
| TICKET_NUMBER | PARKING_TICKET.TICKET_NUMBER | Business primary key; store as identifier, not numeric measure. |
| VIOLATION_TYPE_DESC | VIOLATION_TYPE.VIOLATION_TYPE_DESC; PARKING_TICKET.VIOLATION_TYPE_DESC | Category lookup and ticket FK; four values P, V, T, M. |
| ISSUE_DATE | PARKING_TICKET.ISSUE_DATE | Convert timestamp text with timezone suffix in Phase IV. |
| ISSUE_TIME | PARKING_TICKET.ISSUE_TIME | Source HHMM integer; convert or format as time after validation. |
| ISSUING_AGENCY_CODE | ISSUING_AGENCY.AGENCY_CODE; PARKING_TICKET.AGENCY_CODE | Agency key and ticket FK. |
| ISSUING_AGENCY_NAME | ISSUING_AGENCY.AGENCY_NAME | Agency descriptive attribute. |
| ISSUING_AGENCY_SHORT | ISSUING_AGENCY.AGENCY_SHORT | Agency abbreviation; alternate unique key. |
| VIOLATION_CODE | VIOLATION.VIOLATION_CODE; PARKING_TICKET.VIOLATION_CODE | Violation lookup key and ticket FK. |
| VIOLATION_PROC_DESC | VIOLATION.VIOLATION_PROC_DESC | Optional description; preserve missing values. |
| LOCATION | LOCATION.LOCATION_TEXT; PARKING_TICKET.LOCATION_ID | One location row per distinct non-null exact string; three ticket rows have no location text. |
| PLATE_STATE | PARKING_TICKET.PLATE_STATE | Optional text; 88,625 missing values. |
| VEHICLE_TYPE | PARKING_TICKET.VEHICLE_TYPE | Optional source field; all 89,078 values are missing. |
| MULTI_OWNER_NUMBER | PARKING_TICKET.MULTI_OWNER_NUMBER | Preserve as identifier; 0 is a source sentinel, not a measured count. |
| DISPOSITION_CODE | DISPOSITION.DISPOSITION_CODE; PARKING_TICKET.DISPOSITION_CODE | Disposition lookup key and ticket FK. |
| DISPOSITION_TYPE | DISPOSITION.DISPOSITION_TYPE | Disposition descriptive attribute. |
| DISPOSITION_DESC | DISPOSITION.DISPOSITION_DESC | Optional description; preserve missing values. |
| DISPOSITION_DATE | PARKING_TICKET.DISPOSITION_DATE | Optional ticket-level timestamp; convert in Phase IV. |
| FINE_AMOUNT | PARKING_TICKET.FINE_AMOUNT | Numeric monetary amount; source values are non-negative. |
| TOTAL_PAID | PARKING_TICKET.TOTAL_PAID | Numeric recorded paid amount; not a payment transaction history. |
| PENALTY_1 | TICKET_PENALTY.PENALTY_AMOUNT, stage 1 | Unpivot to one child row per ticket and stage. |
| PENALTY_2 | TICKET_PENALTY.PENALTY_AMOUNT, stage 2 | Unpivot; all source values are zero. |
| PENALTY_3 | TICKET_PENALTY.PENALTY_AMOUNT, stage 3 | Unpivot; all source values are zero. |
| PENALTY_4 | TICKET_PENALTY.PENALTY_AMOUNT, stage 4 | Unpivot; all source values are zero. |
| PENALTY_5 | TICKET_PENALTY.PENALTY_AMOUNT, stage 5 | Unpivot; all source values are zero. |
| XCOORD | LOCATION.XCOORD | Optional numeric coordinate. |
| YCOORD | LOCATION.YCOORD | Optional numeric coordinate. |
| LATITUDE | LOCATION.LATITUDE | Optional decimal-degree coordinate. |
| LONGITUDE | LOCATION.LONGITUDE | Optional decimal-degree coordinate. |
| MAR_ID | LOCATION.MAR_ID | Optional address identifier; not unique and not the PK. |
| GIS_LAST_MOD_DTTM | PARKING_TICKET.GIS_LAST_MOD_DTTM | Convert timestamp text in Phase IV; one distinct value occurs in this extract. |

### Phase IV implementation checklist

- Preserve the original CSV unchanged and load it first into a staging table.
- Convert date/timestamp strings using the actual source format and timezone suffix.
- Keep ticket and fleet/government/rental identifiers as identifiers, not quantities.
- Generate LOCATION_ID values for distinct non-null exact location strings; do not use MAR_ID as the PK.
- Populate reference tables and validate every ticket foreign key.
- Preserve NULL and zero as different values until documented cleaning rules are approved.
- Do not interpret TOTAL_PAID as a full payment ledger; it is only the total amount reported by the source record.
