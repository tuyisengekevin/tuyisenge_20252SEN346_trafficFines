# Public Traffic Fines Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Academic Year:** 2026–2027, Semester I

## 1. Project overview
The Public Traffic Fines Management System is an academic Oracle database project that organizes traffic violation records, fine assessments and payment transactions. It will help an administrator review violation patterns, track assessed fines, monitor paid and outstanding balances, and generate summary reports.

This is a prototype for academic demonstration. It is not an official government payment service and will not process real payments.

## 2. Problem statement
Traffic enforcement produces large volumes of violation records. When violation information, fine assessments and payment status are difficult to review together, administrators may struggle to summarize violations, identify common violation patterns, and monitor outstanding balances. The project will build a structured Oracle database and PL/SQL routines to manage these records and provide clear reporting.

## 3. Objectives
**Main objective:** To design and implement an Oracle database application for recording and analyzing traffic violations, fine assessments and payment status.

**Specific objectives**
1. Import and clean a real, anonymized public traffic-violations dataset.
2. Normalize the data into relational tables up to Third Normal Form (3NF).
3. Develop PL/SQL procedures, functions, cursors, packages and triggers for core operations and validation.
4. Record and monitor fine assessments and payment transactions, using clearly labelled simulated payment data where the public dataset has no payment information.
5. Connect Power BI to the Oracle database to present interactive traffic and fine-management indicators.

## 4. Data source and scope
**Primary dataset:** Montgomery County, Maryland – Traffic Violations (official public open-data dataset).  
**Dataset page:** https://catalog.data.gov/dataset/traffic-violations  
**Direct CSV export:** https://data.montgomerycountymd.gov/api/v3/views/4mse-ku6q/export.csv?accessType=DOWNLOAD

The official catalogue describes the dataset as electronic traffic violations issued in Montgomery County, updated daily, and states that identifying information about vehicles, vehicle owners and officers is not published. The FY2026 county open-data report describes it as containing over two million rows.

For a manageable academic implementation, a documented subset of the public records will be loaded. Fine assessments and payment transactions will be simulated for demonstration because the selected public violation dataset does not itself provide actual payment transactions. Simulated values will never be presented as official records.

## 5. Planned database tables
- **VIOLATION_TYPE** – violation categories and descriptions.
- **LOCATION** – recorded violation locations or areas.
- **TRAFFIC_VIOLATION** – date, time, violation type, location and available source attributes.
- **FINE_ASSESSMENT** – assessed amount, assessment date, due date and status; demonstration data.
- **PAYMENT** – payment amount, date, method and reference; simulated demonstration data.

Primary and foreign keys will enforce relationships. The final design will be refined during Phase II after inspecting the actual dataset columns and normalization dependencies.

## 6. Planned PL/SQL features
- Procedures to insert and update violation and fine records.
- A procedure to record a payment and update the related fine balance/status.
- Functions to calculate outstanding balances and summarize fines.
- Explicit or parameterized cursors to produce violation and payment reports.
- Packages to group related fine-management operations.
- Triggers to validate transactions and maintain audit information.
- Exception handling for invalid IDs, invalid amounts, duplicate records and overpayments.

Business rules will remain in PL/SQL; the dashboard will display and interact with database results.

## 7. Innovation
**Selected option:** Analytics dashboard.  
**Tool:** Microsoft Power BI connected to the Oracle database.

The dashboard will provide interactive KPI cards, filters and charts for violation counts, violation categories, time/location patterns, assessed fines, payments and outstanding balances. It will use data from the project Oracle database rather than static mock-ups. Payment-related indicators will be based on clearly identified simulated payment records.

## 8. Expected results
A normalized Oracle database, validated sample data, reusable PL/SQL program units, audit/validation rules, and a working Power BI dashboard connected to Oracle.

## 9. Limitations
The dataset represents Montgomery County, Maryland, not Rwanda. It is used because it is a real public dataset with a large number of records and no published identifying vehicle/owner/officer information. The prototype does not claim to represent Rwandan traffic law, fine amounts or payment operations. Any fine and payment data created for the prototype are simulated.

## 10. References
See [Research Log](docs/research/research_log.md) for the research sources and findings.
