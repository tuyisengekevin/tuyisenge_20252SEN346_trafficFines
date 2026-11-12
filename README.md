# Parking Violations Analytics System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## 1. Project overview
The Parking Violations Analytics System is an academic Oracle database project. It will organize and analyze public parking-violation summary data and provide reporting by violation category, time period and location, based on the fields available in the official source.

This is a prototype for academic demonstration. It is not an official government payment service and will not process real payments.

## 2. Problem statement
Parking enforcement produces records that can be analyzed to understand violation patterns by category, time and location. This project will build a structured Oracle database and PL/SQL routines to organize the available public violation data and demonstrate fine-management operations.

## 3. Objectives
**Main objective:** To design and implement an Oracle database application for storing, organizing and analyzing public parking-violation summary information.

**Specific objectives**
1. Obtain and inspect an official public parking-violations dataset.
2. Check the source fields, record count, licence/terms of use and privacy implications before importing data.
3. Normalize suitable data into relational tables up to Third Normal Form (3NF).
4. Develop PL/SQL procedures, functions, cursors, packages and triggers for core operations and validation.
5. Develop PL/SQL routines for data validation, summary queries and reporting.
6. Connect Power BI to the Oracle database for interactive reporting.

## 4. Data source and scope
**Proposed primary dataset:** District of Columbia – Parking Violations Issued (September 2026).

- **Official dataset page:** https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026
- **Government catalogue:** https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026
- **CSV download:** https://opendata.dc.gov/api/download/v1/items/52bcc739569546a7a6cea61ff7373831/csv?layers=8

The dataset is described as aggregated parking-violation information. It is therefore intended to support analysis of violation patterns, not to serve as a complete register of individual summonses or real payment transactions. The downloaded CSV must be inspected before its exact columns, record count, coverage and suitability are confirmed.

The project will not claim that aggregate counts are individual citations, fine assessments or payment transactions. The final database design will follow the actual granularity and columns confirmed in the CSV. If the dataset contains only aggregated counts, the system will focus on storing and analyzing those summaries.

## 5. Planned database tables
The final table design will be decided after inspecting the downloaded CSV and identifying its actual fields and relationships. Possible entities for the demonstration include:
- **VIOLATION_CATEGORY** – available violation categories.
- **LOCATION** – available geographic areas or locations, if provided.
- **VIOLATION_SUMMARY** – source counts and reporting period, if the dataset is aggregated.
- **VIOLATION_CATEGORY** – category lookup, if supported by the source fields.
- **LOCATION** – geographic area or street-segment information, if supported by the source fields.

Primary and foreign keys will enforce relationships. The design will avoid inventing source attributes that are not present in the downloaded dataset.

## 6. Planned PL/SQL features
- Procedures to insert and update project records.
- Procedures to load, validate and update project summary records.
- Functions to calculate violation totals and category/time-period summaries.
- Cursors to produce violation and location reports.
- Packages to group related fine-management operations.
- Triggers to validate transactions and maintain audit information.
- Exception handling for invalid IDs, invalid amounts, duplicate records and overpayments.

Business rules will remain in PL/SQL; the dashboard will display database results.

## 7. Innovation
**Selected option:** Analytics dashboard.  
**Tool:** Microsoft Power BI connected to the Oracle database.

The dashboard will provide interactive indicators and charts based only on the fields confirmed in the source dataset, such as violation counts by category, time period and location where those fields are available.

## 8. Expected results
A normalized Oracle database, documented and validated source data, reusable PL/SQL program units, audit/validation rules, and a Power BI dashboard connected to Oracle.

## 9. Limitations
The proposed dataset represents Washington, DC, not Rwanda. It is a public dataset for academic analysis and does not establish Rwandan traffic or parking laws. The official description says the parking-violation counts are summarized by time, week, year and violation category. Therefore, this source may not support individual-level fine processing. The actual CSV must be inspected before the final scope and database schema are approved.

## 10. References
See [Research Log](docs/research/research_log.md) for the research sources and findings.
