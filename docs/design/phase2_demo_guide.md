# Phase II — Five-Minute Demonstration Guide

**Project:** Parking Violations Analytics and Fine Management System  
**Student:** TUYISENGE Kevin — 20252SEN346

## 1. Show the original data (about 45 seconds)

Open data/raw/parking_violations.csv. Explain that it is the original, unedited DDOT/DC GIS CSV. It contains 89,078 ticket records and 31 columns. One row represents one issued parking citation. The dataset card records the source, CC BY 4.0 licence, file size, row grain and measured quality results.

## 2. Explain the normalization (about 60 seconds)

- **UNF:** the original wide CSV stores five penalty-stage columns (PENALTY_1 to PENALTY_5) in each ticket row.
- **1NF:** convert those repeated penalty columns into individual rows in TICKET_PENALTY, identified by (TICKET_NUMBER, PENALTY_STAGE).
- **2NF:** keep ticket-level attributes in PARKING_TICKET; keep PENALTY_AMOUNT in the child table because it depends on both ticket and stage.
- **3NF:** move agency, violation, disposition and location descriptions into reference tables. Store the four-value violation category in VIOLATION_TYPE separately because the same VIOLATION_CODE can appear with more than one category value in the extract.

## 3. Trace one real source record (about 2 minutes)

Use ticket 276947020 from the raw CSV:

| Source value | Destination in the 3NF design |
|---|---|
| TICKET_NUMBER = 276947020 | PARKING_TICKET.TICKET_NUMBER (primary key) |
| OBJECTID = 85839625 | PARKING_TICKET.SOURCE_OBJECT_ID |
| VIOLATION_TYPE_DESC = P | VIOLATION_TYPE reference row P; ticket FK VIOLATION_TYPE_DESC |
| ISSUING_AGENCY_CODE = 51 | ISSUING_AGENCY row 51; ticket FK AGENCY_CODE |
| VIOLATION_CODE = P344 | VIOLATION row P344; ticket FK VIOLATION_CODE |
| LOCATION = 1300 BLK D ST | LOCATION row with generated key LOC-003; ticket FK LOCATION_ID |
| DISPOSITION_CODE = 0 | DISPOSITION row 0 (Other); ticket FK DISPOSITION_CODE |
| ISSUE_DATE and ISSUE_TIME | PARKING_TICKET.ISSUE_DATE and PARKING_TICKET.ISSUE_TIME |
| FINE_AMOUNT = 250; TOTAL_PAID = 0 | PARKING_TICKET.FINE_AMOUNT and PARKING_TICKET.TOTAL_PAID |
| PENALTY_1 = 250; PENALTY_2–PENALTY_5 = 0 | Five TICKET_PENALTY rows, one per stage |
| LATITUDE = 38.895; LONGITUDE = -76.987; MAR_ID = 810239 | LOCATION row LOC-003 |

LOC-003 is an illustrative generated key for the logical explanation. The actual surrogate key will be assigned during Phase IV.

## 4. Show the design files (about 45 seconds)

Open docs/design/erd.png and identify the seven tables, primary keys, foreign keys and crow's-foot relationships. Then open docs/design/data_dictionary.md to show column meanings, required/unique rules and the mapping of all 31 raw fields.

## 5. Close with the Phase IV boundary (about 30 seconds)

Explain that Phase II defines the logical model. The raw CSV has not been cleaned or modified. Oracle data types, column sizes, staging, cleaning, table creation and data loading will be handled in Phase IV.
