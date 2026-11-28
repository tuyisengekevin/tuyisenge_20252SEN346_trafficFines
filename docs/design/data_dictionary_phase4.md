# Phase IV Data Dictionary — Oracle Implementation

**Project:** Parking Violations Analytics and Fine Management System  
**Schema:** KEVIN_ADMIN  
**PDB:** I_20252SEN346_KEVIN_PARK_DB  
**Source:** District of Columbia parking violations, September 2026  
**Model:** Seven-table normalized design (3NF)

This implementation dictionary supplements the logical dictionary in `data_dictionary.md`. It records Oracle column types, nullability, constraints and implementation rationale based on `database/setup/07_create_tables.sql`. It describes the schema as currently created; planned referential actions are identified separately and are not claimed active until implemented and tested.

## 1. ISSUING_AGENCY

Purpose: lookup table for the agency that issued each citation.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| AGENCY_CODE | NUMBER(5) | No | PK_ISSUING_AGENCY | Source agency identifier; primary key. |
| AGENCY_NAME | VARCHAR2(150) | No | — | Required agency name; sized for descriptive text. |
| AGENCY_SHORT | VARCHAR2(20) | No | UQ_AGENCY_SHORT | Required abbreviation; unique alternate key. |

## 2. VIOLATION_TYPE

Purpose: preserves the four source ticket-category codes.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| VIOLATION_TYPE_DESC | VARCHAR2(1) | No | PK_VIOLATION_TYPE; CK_VIOLATION_TYPE_CODE | Single-character source code; check restricts values to P, V, T or M. |

## 3. VIOLATION

Purpose: reference list of cited violation codes and optional procedural descriptions.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| VIOLATION_CODE | VARCHAR2(10) | No | PK_VIOLATION | Source code is an identifier and is stored as text to preserve formatting. |
| VIOLATION_PROC_DESC | VARCHAR2(500) | Yes | — | Optional description; source contains missing descriptions. |

## 4. DISPOSITION

Purpose: lookup of recorded ticket disposition/outcome codes.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| DISPOSITION_CODE | NUMBER(5) | No | PK_DISPOSITION | Source disposition identifier. |
| DISPOSITION_TYPE | VARCHAR2(30) | No | — | Required short classification. |
| DISPOSITION_DESC | VARCHAR2(500) | Yes | — | Optional detail; many source rows lack a description. |

## 5. LOCATION

Purpose: stores each distinct exact source location string once, with optional address/geospatial attributes.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| LOCATION_ID | NUMBER (identity) | No | PK_LOCATION | Generated surrogate key; source has no dependable location key. |
| LOCATION_TEXT | VARCHAR2(300) | No | UQ_LOCATION_TEXT | Exact source location; unique to support deduplication and lookup. |
| MAR_ID | NUMBER(12) | Yes | — | Optional DC address repository identifier; not unique in source. |
| XCOORD | NUMBER(15,3) | Yes | — | Optional projected X coordinate; decimal precision preserves source values. |
| YCOORD | NUMBER(15,3) | Yes | — | Optional projected Y coordinate. |
| LATITUDE | NUMBER(10,7) | Yes | CK_LOCATION_LATITUDE | Optional latitude; check allows NULL or values from -90 to 90. |
| LONGITUDE | NUMBER(11,7) | Yes | CK_LOCATION_LONGITUDE | Optional longitude; check allows NULL or values from -180 to 180. |

## 6. PARKING_TICKET

Purpose: central fact table with one row per parking citation and references to its agency, category, violation, disposition and optional location.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| TICKET_NUMBER | NUMBER(12) | No | PK_PARKING_TICKET | Citation identifier; primary key. |
| SOURCE_OBJECT_ID | NUMBER(12) | No | UQ_TICKET_SOURCE_OBJECT | Preserve unique source OBJECTID as alternate key for reconciliation. |
| VIOLATION_TYPE_DESC | VARCHAR2(1) | No | FK_TICKET_VIOLATION_TYPE | Required category lookup reference. |
| ISSUE_DATE | TIMESTAMP WITH TIME ZONE | No | — | Keeps source date/time and timezone information. |
| ISSUE_TIME | NUMBER(4) | No | CK_TICKET_ISSUE_TIME | Source HHMM value; check permits 0–2359. |
| AGENCY_CODE | NUMBER(5) | No | FK_TICKET_AGENCY | Each ticket must reference one issuing agency. |
| VIOLATION_CODE | VARCHAR2(10) | No | FK_TICKET_VIOLATION | Each ticket must reference a known violation code. |
| LOCATION_ID | NUMBER(12) | Yes | FK_TICKET_LOCATION | Optional because some source tickets have no location string. |
| PLATE_STATE | VARCHAR2(10) | Yes | — | Optional source field with high missingness. |
| VEHICLE_TYPE | VARCHAR2(50) | Yes | — | Optional source field; empty in this extract but retained for fidelity. |
| MULTI_OWNER_NUMBER | VARCHAR2(30) | No | — | Identifier, not a quantity; text avoids numeric formatting/leading-zero loss. Source 0 sentinel is preserved. |
| DISPOSITION_CODE | NUMBER(5) | No | FK_TICKET_DISPOSITION | Each ticket references a disposition code. |
| DISPOSITION_DATE | TIMESTAMP WITH TIME ZONE | Yes | — | Optional because disposition may not have a recorded date. |
| FINE_AMOUNT | NUMBER(10,2) | No | CK_TICKET_FINE_AMOUNT | Monetary value with cents; check prevents negative amounts. |
| TOTAL_PAID | NUMBER(10,2) | No | CK_TICKET_TOTAL_PAID | Source-reported paid total; check prevents negative values. This is not a payment ledger. |
| GIS_LAST_MOD_DTTM | TIMESTAMP WITH TIME ZONE | No | — | Preserves source GIS modification timestamp and timezone. |

## 7. TICKET_PENALTY

Purpose: stores the five repeating penalty-stage values in normalized child rows.

| Column | Oracle type | Null? | Constraint | Reason |
|---|---|---:|---|---|
| TICKET_NUMBER | NUMBER(12) | No | PK_TICKET_PENALTY (composite); FK_PENALTY_TICKET | Parent ticket reference; part of composite primary key. |
| PENALTY_STAGE | NUMBER(1) | No | PK_TICKET_PENALTY (composite); CK_PENALTY_STAGE | Stage number; check restricts it to 1–5. |
| PENALTY_AMOUNT | NUMBER(10,2) | No | CK_PENALTY_AMOUNT | Monetary amount with cents; check prevents negative values. |

Composite primary key: `(TICKET_NUMBER, PENALTY_STAGE)`. This prevents duplicate stage rows for the same ticket.

## Constraint and index notes

- Primary keys: one for each of the seven tables; `PK_TICKET_PENALTY` is composite.
- Unique constraints: `UQ_AGENCY_SHORT`, `UQ_LOCATION_TEXT`, `UQ_TICKET_SOURCE_OBJECT`.
- Check constraints: category code, latitude, longitude, issue-time range, nonnegative fine/paid/penalty amounts, and penalty-stage range.
- Foreign keys: five ticket-to-reference relationships plus penalty-to-ticket.
- Existing indexes: PK/UQ indexes are placed in `PARK_IDX`; separate indexes cover ticket agency, category, violation, location and disposition FKs.
- Tables are assigned to `PARK_DATA`; indexes are assigned to `PARK_IDX`.

## Referential-action status

The current creation script defines foreign keys with Oracle's default NO ACTION behavior. The design target is:

| Constraint | Target action | Rationale |
|---|---|---|
| FK_TICKET_AGENCY | NO ACTION | Prevent deletion of an agency referenced by historical tickets. |
| FK_TICKET_VIOLATION_TYPE | NO ACTION | Preserve category integrity. |
| FK_TICKET_VIOLATION | NO ACTION | Preserve cited violation history. |
| FK_TICKET_DISPOSITION | NO ACTION | Preserve disposition history. |
| FK_TICKET_LOCATION | ON DELETE SET NULL | Keep ticket when its optional location is deleted. |
| FK_PENALTY_TICKET | ON DELETE CASCADE | Penalty rows are dependent details of a ticket. |

The SET NULL and CASCADE actions are **planned**, not active, until the dedicated constraints script is applied and the delete tests pass.

## Design decisions

1. Source identifiers are preserved as identifiers; numeric appearance does not make them measurements.
2. Exact source location text is the alternate location key. MAR_ID is not unique and is not used as the primary key.
3. NULL is preserved for missing information; source sentinel zero is not silently converted to NULL.
4. The raw CSV remains unchanged. All data cleansing and conversions are documented in the staging/load process.
5. The existing logical dictionary and its 31-field source mapping remain in `data_dictionary.md`.
