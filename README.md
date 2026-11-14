# Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## 1. Project overview

The Parking Violations Analytics and Fine Management System is an academic database project that will organize and analyze public parking-violation records using Oracle Database and PL/SQL. It will support structured storage, data validation, analytical queries and interactive reporting.

This project is an academic prototype. It is not an official government ticketing or adjudication service and will not collect or process real payments. Any payment-related demonstration will be clearly identified as simulated and will not be presented as an actual transaction.

## 2. Problem statement

Parking-violation records contain information that can be analyzed to identify patterns by violation category, date, issuing agency and location. When the records are not organized for analysis, it can be difficult to summarize violation activity and examine recorded fine and payment amounts.

This project will design a relational database and reporting solution based on the fields that are actually available and sufficiently complete in the selected public dataset.

## 3. Project objectives

1. Inspect and document a public parking-violations dataset, including its source, structure, record count, data quality and licence.
2. Design normalized relational tables that reflect the verified data.
3. Implement database operations and business rules using Oracle PL/SQL.
4. Produce reports about violation categories, issuing agencies, dates, locations and recorded fine/payment amounts where the data supports them.
5. Develop an interactive analytics dashboard using Microsoft Power BI connected to Oracle Database.

## 4. Dataset and data quality

**Dataset:** District of Columbia – Parking Violations Issued in September 2026.

- [DC Open Data dataset page](https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026)
- [Data.gov catalogue entry](https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026)
- **Geographical scope:** Washington, DC, USA.
- **Inspected CSV:** `Parking_Violations_Issued_in_September_2026.csv`
- **Inspected size:** 89,078 records and 31 columns.
- **Date coverage:** 1–30 September 2026.
- **Duplicate checks:** No completely duplicated rows, duplicate ticket numbers or duplicate OBJECTIDs were found in the inspected file.

### Data limitations

The inspection found that `VEHICLE_TYPE` is entirely empty. `PLATE_STATE`, `DISPOSITION_DESC` and `DISPOSITION_DATE` have very high levels of missing data. Several location-coordinate fields also contain some missing values. These fields will be excluded from analysis or handled carefully where their completeness is insufficient.

The downloaded CSV contains ticket-level records and fields such as `TICKET_NUMBER`, while the Data.gov catalogue description describes a summarized Vision Zero dataset. This difference in granularity will be documented and considered when finalizing the database design.

The dataset contains ticket identifiers. A reviewed/anonymized working copy must be used for public repository uploads and demonstrations; do not publish unnecessary ticket-level identifiers. The dataset's fine and total-paid fields are recorded amounts, not a complete payment transaction history.

## 5. Planned database and PL/SQL implementation

The final tables and relationships will be designed after the dataset review and normalization analysis. The design will use only attributes supported by the source data. Potential subject areas include violation records, violation categories, issuing agencies and recorded fine/disposition information, subject to the final schema.

Planned PL/SQL techniques include:

- Procedures and functions for reusable database operations and calculations.
- Cursors for processing and reporting on selected records.
- Packages to group related program units.
- Triggers for appropriate validation, auditing or business rules.
- Exception handling for invalid operations and unexpected conditions.
- SQL queries and views for analytical reporting.

These are planned features; their implementation and testing will be documented as the project progresses.

## 6. Innovation

**Innovation option:** Interactive analytics dashboard.  
**Planned tool:** Microsoft Power BI connected to Oracle Database.

The dashboard is intended to let a user interact with reports based on the data stored in Oracle. The connection and working demonstration will be developed and verified during implementation. A static screenshot alone will not be treated as proof of a working integration.

## 7. Project documentation

| Document | Location |
|---|---|
| Research log | [`docs/research/research_log.md`](docs/research/research_log.md) |
| Project proposal | `docs/proposal/project_proposal.pdf` |
| Project presentation | `docs/presentation/project_presentation.pdf` |
| Innovation documentation | `innovation/` |
| Reviewed dataset copy | `data/raw/` |
| Phase I business-process materials | [`docs/business process/`](docs/business%20process/) |

The proposal, presentation and reviewed dataset will be added when they are finalized. The `.gitkeep` files currently preserve the empty upload folders.

## 8. Repository structure

```text
tuyisenge_20252SEN346_trafficFines/
├── README.md
├── docs/
│   ├── research/
│   │   └── research_log.md
│   ├── proposal/
│   │   └── .gitkeep
│   ├── presentation/
│   │   └── .gitkeep
│   ├── business process/
│   │   └── existing Phase I materials
│   └── phase0/
│       └── existing folder notes
├── data/
│   └── raw/
│       ├── .gitkeep
│       └── README.md
└── innovation/
    └── .gitkeep
```

## 9. References

The research sources, dataset references and research notes are recorded in the [Phase 0 Research Log](docs/research/research_log.md).
