# Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## 1. Project overview
The Parking Violations Analytics and Fine Management System is an academic Oracle database project. It will organize and analyze public parking-violation information and demonstrate how fine assessments and payment records can be managed in a relational database.

This is a prototype for academic demonstration. It is not an official government payment service and will not process real payments.

## 2. Problem statement
Parking enforcement produces records that can be analyzed to understand violation patterns by category, time and location. This project will build a structured Oracle database and PL/SQL routines to organize the available public violation data and demonstrate fine-management operations.

## 3. Objectives
**Main objective:** To design and implement an Oracle database application for organizing and analyzing parking-violation information, with a demonstration of fine and payment management.

**Specific objectives**
1. Obtain and inspect an official public parking-violations dataset.
2. Check the source fields, record count, licence/terms of use and privacy implications before importing data.
3. Normalize suitable data into relational tables up to Third Normal Form (3NF).
4. Develop PL/SQL procedures, functions, cursors, packages and triggers for core operations and validation.
5. Demonstrate fine assessments and payment transactions using clearly labelled simulated records if the public dataset does not contain those details.
6. Connect Power BI to the Oracle database for interactive reporting.

## 4. Data source and scope
**Proposed primary dataset:** District of Columbia – Parking Violations Issued (September 2026).

- **Official dataset page:** https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026
- **Government catalogue:** https://catalog.data.gov/dataset/parking-violations-issued-in-september-2026
- **CSV download:** https://opendata.dc.gov/api/download/v1/items/52bcc739569546a7a6cea61ff7373831/csv?layers=8

The dataset is described as aggregated parking-violation information. It is therefore intended to support analysis of violation patterns, not to serve as a complete register of individual summonses or real payment transactions. The downloaded CSV must be inspected before its exact columns, record count, coverage and suitability are confirmed.

The project will not claim that aggregate counts are individual fine records. Fine assessments and payment transactions will be simulated separately for database-operation demonstrations and clearly labelled as simulated. No simulated values will be presented as official government records.

## 5. Planned database tables
The final table design will be decided after inspecting the downloaded CSV and identifying its actual fields and relationships. Possible entities for the demonstration include:
- **VIOLATION_CATEGORY** – available violation categories.
- **LOCATION** – available geographic areas or locations, if provided.
- **VIOLATION_SUMMARY** – source counts and reporting period, if the dataset is aggregated.
- **FINE_ASSESSMENT** – demonstration fine amount, assessment date and status.
- **PAYMENT** – simulated payment amount, date, method and reference.

Primary and foreign keys will enforce relationships. The design will avoid inventing source attributes that are not present in the downloaded dataset.

## 6. Planned PL/SQL features
- Procedures to insert and update project records.
- A procedure to record a simulated payment and update the related demonstration fine balance/status.
- Functions to calculate outstanding balances and summarize fines.
- Cursors to produce violation and payment reports.
- Packages to group related fine-management operations.
- Triggers to validate transactions and maintain audit information.
- Exception handling for invalid IDs, invalid amounts, duplicate records and overpayments.

Business rules will remain in PL/SQL; the dashboard will display database results.

## 7. Innovation
**Selected option:** Analytics dashboard.  
**Tool:** Microsoft Power BI connected to the Oracle database.

The dashboard will provide interactive indicators and charts based on the fields confirmed in the source dataset. It may also display clearly separated demonstration indicators for simulated fine assessments and payments. It will not present simulated payment information as official source data.

## 8. Expected results
A normalized Oracle database, documented and validated source data, reusable PL/SQL program units, audit/validation rules, and a Power BI dashboard connected to Oracle.

## 9. Limitations
The proposed dataset represents Washington, DC, not Rwanda. It is a public dataset for academic analysis and does not establish Rwandan traffic or parking laws. Because the dataset is described as aggregated, it may not support individual-level fine processing. The actual CSV must be inspected before the final scope and database schema are approved. Any fine and payment records created for demonstrations will be simulated.

## 10. References
See [Research Log](docs/research/research_log.md) for the research sources and findings.
