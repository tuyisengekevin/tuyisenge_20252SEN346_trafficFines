# Parking Violations Analytics System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## Project overview

The Parking Violations Analytics System is an academic Oracle database project for organizing and analyzing public parking-violation information. The final database design and analytics scope will follow the actual fields and level of detail in the downloaded source dataset.

This is an academic prototype. It is not an official government ticketing, adjudication or payment service and will not process real payments.

## Problem statement

Parking enforcement data can be organized and analyzed to understand violation patterns by category, reporting period and location where those attributes are available. This project will demonstrate relational database design, Oracle PL/SQL programming and reporting.

## Objectives

1. Obtain and inspect a public parking-violations dataset.
2. Verify its source, fields, record count, data granularity and terms of use.
3. Design normalized relational tables based on verified source data.
4. Develop PL/SQL procedures, functions, cursors, packages, triggers and exception handling.
5. Produce useful reports from the stored data.
6. Connect Microsoft Power BI to Oracle for interactive reporting.

## Data source

**Proposed dataset:** District of Columbia – Parking Violations Issued in September 2026.

- [DC Open Data dataset page](https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026)
- [Data.gov catalogue entry](https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026)

The CSV must be inspected before its exact columns, record count, aggregation level and suitability are confirmed. Do not interpret aggregated counts as individual citations or real payment transactions.

The original downloaded CSV belongs in `data/raw/` once it has been added to the repository.

## Planned database and PL/SQL work

The final entities and relationships will be determined from the verified CSV structure. Planned PL/SQL work includes data validation, procedures, functions, cursors, packages, triggers, exception handling and audit support where appropriate.

## Innovation

**Selected option:** Analytics dashboard.  
**Tool:** Microsoft Power BI connected to Oracle.

The dashboard will use only attributes confirmed in the dataset.

## Phase 0 – Research and Proposal

Phase 0 documents are organized in [docs/phase0/](docs/phase0/). The research log is available at [Research Log](docs/phase0/research_log.md).

Upload the approved proposal PDF and presentation PowerPoint into this folder.

## Phase I - Business Process Modeling

**Selected process:** To be documented for the Parking Violations Analytics System.  
**Modeling tool:** To be confirmed.  
**Published diagram link:** To be added after creating and publishing the diagram in draw.io, Lucidchart or Canva.  
**Supporting explanation:** [Business Process Explanation](docs/business%20process/business_process_explanation.pdf) (upload after completing the one-page explanation).  
**Diagram PDF:** [Business Process Diagram](docs/business%20process/business_process_diagram.pdf) (upload after exporting the diagram).

The original editable diagram must be retained in the selected modeling tool. The published diagram link and GitHub repository link are separate deliverables.

## Repository structure

- `docs/phase0/` – research log, proposal and presentation.
- `docs/business process/` – Phase I diagram export and one-page explanation.
- `data/raw/` – original downloaded dataset.

## References

See the [Research Log](docs/phase0/research_log.md) for the sources and research notes.
