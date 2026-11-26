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
- [Dataset card](data/dataset_card.md)

The raw CSV is retained unchanged. It has no duplicate rows, duplicate ticket numbers or duplicate OBJECTID values. VEHICLE_TYPE is entirely empty; PLATE_STATE and disposition descriptions/dates have high missingness. Fine and total-paid values are source summary fields, not a full payment transaction history.

## Phase 0 — Research and proposal

- [Research log](docs/research/research_log.md)
- [Project proposal PDF](docs/proposal/project_proposal.pdf)
- [Project presentation PowerPoint](docs/presentation/project_presentation.pptx)

## Phase I — Business Process Modeling

**Business process:** Parking Violation Data Processing, Fine Monitoring and Analytics Process.

- [Business-process diagram (PDF)](docs/business%20process/business_process_diagram.pdf)
- [Business-process explanation (PDF)](docs/business%20process/business_process_explanation.pdf)

## Phase II — Data sourcing and normalization

- [Normalization UNF → 1NF → 2NF → 3NF](docs/design/normalization.md)
- [Logical ERD (PNG)](docs/design/erd.png)
- [Data dictionary and 31-field mapping](docs/design/data_dictionary.md)
- [Five-minute demonstration guide](docs/design/phase2_demo_guide.md)

The logical model contains seven tables: ISSUING_AGENCY, VIOLATION_TYPE, VIOLATION, DISPOSITION, LOCATION, PARKING_TICKET and TICKET_PENALTY. Oracle types, table creation, cleaning and data loading belong to Phase IV.

## Phase III — Oracle database configuration

The project PDB, administrator, tablespaces, quotas and CDB ARCHIVELOG mode have been configured and verified. The [Phase III guide](docs/phase3/README.md) and [evidence summary](docs/evidence/phase3/README.md) document the setup.

**Port exception:** The assignment-required PDB HTTPS port is 5546. Oracle returned ORA-44718 (XDB port conflict); the existing port 5547 was retained to avoid changing another container's configuration. This is a documented deviation, not a claim that 5546 was configured.

- [Phase III SQL scripts](database/setup/)
- [Phase III screenshots](screenshots/phase3/)

## Phase IV — Database implementation

[The seven-table creation script](database/setup/07_create_tables.sql) defines the normalized schema, constraints, indexes and table comments. It creates structure only; staging, cleaning, loading and validation are separate implementation tasks.

## Innovation

**Planned tool:** Microsoft Power BI connected to Oracle Database. The dashboard must use live database data during demonstration; a static mock-up is not sufficient.

## Repository structure

- `data/raw/` — original CSV
- `database/setup/` — Oracle setup, verification and table scripts
- `docs/design/` — normalization, ERD, data dictionary and demonstration guide
- `docs/research/` — research log
- `docs/business process/` — Phase I diagram and explanation
- `docs/proposal/` and `docs/presentation/` — Phase 0 proposal and presentation
- `screenshots/phase3/` — Phase III evidence screenshots

## Scope and limitations

The dataset represents Washington, DC, USA, not Rwanda. Fine/payment summary fields are used only as provided by the source. No simulated payments are presented as real transactions, and the project is not an official government service.
