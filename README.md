# Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 — Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## Project overview

This academic project organizes and analyzes public parking-violation records using Oracle Database and PL/SQL. It supports structured storage, validation, analytical queries and reporting. It is not an official government ticketing/adjudication service and does not process real payments.

## Dataset

**Dataset:** District of Columbia — Parking Violations Issued in September 2026.

- [DC Open Data dataset page](https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026)
- [Data.gov catalogue](https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026)
- [Raw CSV](data/raw/parking_violations.csv)
- **Verified size:** 89,078 records and 31 columns.
- **Period:** 1–30 September 2026.
- **Licence:** CC BY 4.0.
- **Dataset card:** [data/dataset_card.md](data/dataset_card.md)

The raw CSV is retained unchanged. It has no duplicate rows, duplicate ticket numbers or duplicate OBJECTID values. VEHICLE_TYPE is entirely empty; PLATE_STATE and disposition descriptions/dates have high missingness. Fine and total-paid values are source summary fields, not a full payment transaction history.

## Phase II — Data sourcing and normalization

Phase II deliverables:

- [Dataset card](data/dataset_card.md)
- [Normalization UNF → 1NF → 2NF → 3NF](docs/design/normalization.md)
- [Logical ERD (PNG)](docs/design/erd.png)
- [Data dictionary and 31-field mapping](docs/design/data_dictionary.md)
- [Five-minute demonstration guide](docs/design/phase2_demo_guide.md)

The logical model contains seven tables: ISSUING_AGENCY, VIOLATION_TYPE, VIOLATION, DISPOSITION, LOCATION, PARKING_TICKET and TICKET_PENALTY. Oracle types, table creation, cleaning and data loading belong to Phase IV.

## Phase I — Business Process Modeling

**Business process:** Parking Violation Data Processing, Fine Monitoring and Analytics Process.

- [Business-process diagram (PDF)](docs/business%20process/business_process_diagram.pdf)
- [Business-process explanation (PDF)](docs/business%20process/business_process_explanation.pdf)

## Innovation

**Planned tool:** Microsoft Power BI connected to Oracle Database. The dashboard must use live database data during demonstration; a static mock-up is not sufficient.

## Repository structure

- data/raw/ — original CSV
- data/dataset_card.md — source and quality documentation
- docs/design/ — normalization, ERD, data dictionary and demonstration guide
- docs/research/ — research log
- docs/business process/ — Phase I diagram and explanation
- docs/proposal/ and docs/presentation/ — Phase 0 proposal and presentation

## Scope and limitations

The dataset represents Washington, DC, USA, not Rwanda. Fine/payment summary fields are used only as provided by the source. No simulated payments are presented as real transactions, and the project is not an official government service.
