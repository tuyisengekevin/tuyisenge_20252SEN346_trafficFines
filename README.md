# Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## 1. Project overview

The Parking Violations Analytics and Fine Management System is an academic database project that will organize and analyze public parking-violation records using Oracle Database and PL/SQL. It will support structured storage, data validation, analytical queries and interactive reporting.

This is an academic prototype. It is not an official government ticketing or adjudication service and will not collect or process real payments. Any payment-related demonstration will be clearly identified as simulated and kept separate from the source records.

## 2. Problem statement

Parking-violation records contain information that can be analyzed to identify patterns by violation category, date, issuing agency and location. When records are not organized for analysis, it can be difficult to summarize violation activity and examine recorded fine and payment amounts.

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
- [Raw CSV uploaded to this repository](data/raw/parking_violations.csv)
- **Geographical scope:** Washington, DC, USA.
- **Inspected file:** `data/raw/parking_violations.csv`
- **Inspected size:** 89,078 records and 31 columns.
- **Date coverage:** September 1–30, 2026.
- **Duplicate checks:** No completely duplicated rows, duplicate ticket numbers or duplicate OBJECTIDs were found in the inspected file.
- **Licence:** The dataset catalogue identifies the data as Creative Commons Attribution 4.0 International (CC BY 4.0). Credit the District Department of Transportation and link to the source when reusing it.

### Data limitations and handling

The inspection found that `VEHICLE_TYPE` is entirely empty. `PLATE_STATE`, `DISPOSITION_DESC` and `DISPOSITION_DATE` have very high levels of missing data. Several location-coordinate fields also contain some missing values. These fields must be excluded from analysis or handled as optional where their completeness is insufficient; missing values must not be invented.

The downloaded CSV contains ticket-level records and fields such as `TICKET_NUMBER`, while the public catalogue description describes a summarized Vision Zero dataset. This difference in granularity is documented in the research log and will be considered when finalizing the database design.

The CSV contains citation identifiers. Treat these identifiers carefully and avoid displaying them in public screenshots or dashboard demonstrations unless there is a justified need. Review the dataset terms and privacy implications before redistributing the raw file. The `FINE_AMOUNT` and `TOTAL_PAID` columns are recorded amount fields; they do not establish a complete payment transaction history.

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

The dashboard is intended to let a user interact with reports based on data stored in Oracle. The connection and working demonstration will be developed and verified during implementation. A static screenshot alone will not be treated as proof of a working integration.

## 7. Phase I - Business Process Modeling

**Business process:** Parking Violation Data Processing, Fine Monitoring and Analytics Process.

- **Modeling tool:** diagrams.net (draw.io).
- **Published editable/viewer diagram:** [View the published business process diagram](https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#G1rNOUvbag9rQvy3-lv7Qx8h3gcq7LJOoo).
- **Access verification:** The published viewer link was tested in a Chrome Incognito window and the diagram opened without signing in.
- **Diagram PDF:** [business_process_diagram.pdf](docs/business%20process/business_process_diagram.pdf).
- **Business process explanation:** [business_process_explanation.pdf](docs/business%20process/business_process_explanation.pdf).

## 8. Project documents and dataset

| Item | Repository location |
|---|---|
| Project proposal (PDF) | [docs/proposal/project_proposal.pdf](docs/proposal/project_proposal.pdf) |
| Project presentation (PowerPoint) | [docs/presentation/project_presentation.pptx](docs/presentation/project_presentation.pptx) |
| Research log | [docs/research/research_log.md](docs/research/research_log.md) |
| Raw dataset CSV | [data/raw/parking_violations.csv](data/raw/parking_violations.csv) |
| Business-process diagram (PDF) | [docs/business process/business_process_diagram.pdf](docs/business%20process/business_process_diagram.pdf) |
| Business-process explanation (PDF) | [docs/business process/business_process_explanation.pdf](docs/business%20process/business_process_explanation.pdf) |

## 9. Repository structure

```text
tuyisenge_20252SEN346_trafficFines/
├── README.md
├── data/
│   └── raw/
│       └── parking_violations.csv
└── docs/
    ├── proposal/
    │   └── project_proposal.pdf
    ├── presentation/
    │   └── project_presentation.pptx
    ├── research/
    │   └── research_log.md
    └── business process/
        ├── business_process_diagram.pdf
        └── business_process_explanation.pdf
```

## 10. References

The research sources, dataset references, data-quality checks and research notes are recorded in the [Research Log](docs/research/research_log.md).
