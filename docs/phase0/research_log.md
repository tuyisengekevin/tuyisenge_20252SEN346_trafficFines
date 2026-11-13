# Research Log – Parking Violations Analytics and Fine Management System

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Course:** INSY 8311 – Database Development with PL/SQL

> **Status:** Working research log. The Washington, DC dataset is a proposed replacement source. The downloaded CSV has not yet been inspected, so its row count, exact columns, aggregation level, privacy characteristics and suitability remain unverified. Confirm every source has actually been read before submitting this log, as required by the assignment.

| # | Source (APA) | Type | Link | Key finding | Gap it shows |
|---|---|---|---|---|---|
| 1 | Mishra, R., Kumaraguru, P., Shah, R. R., Sadaria, A., Srikanth, S., Gupta, K., Bhatia, H., & Jain, P. (2020). *Analyzing traffic violations through e-challan system in metropolitan cities* [Workshop paper]. | Research paper | https://cdn.iiit.ac.in/cdn/precog.iiit.ac.in/pubs/2020_Aug_traffic_violations.pdf | This paper studies electronic traffic-challan records and analyzes violation patterns. | Large violation datasets can support analysis, but a database project still needs a normalized structure and clearly defined operational rules. |
| 2 | Dušek, L., Pardo, N., & Traxler, C. (2022). Salience and timely compliance: Evidence from speeding tickets. *Journal of Policy Analysis and Management, 41*(2), 426–449. https://doi.org/10.1002/pam.22387 | Research paper | https://onlinelibrary.wiley.com/doi/full/10.1002/pam.22387 | The study examines how payment notices and penalty information affect timely payment of speeding tickets. | Due dates, payment status and follow-up are useful concepts for a fine-management database, but the project's source dataset may not contain these transaction details. |
| 3 | District Department of Transportation. (n.d.). *Parking violations issued in September 2026* [Dataset]. DC Open Data. | Dataset | https://opendata.dc.gov/datasets/DCGIS::parking-violations-issued-in-september-2026 | This is the proposed official Washington, DC dataset. Its public description characterizes the data as parking-violation information. The downloaded CSV must be inspected before stating the number of records, exact fields or whether observations are individual citations or aggregated counts. | If the data is aggregated, it cannot be treated as a register of individual summonses or used to claim that real payment transactions are present. The database scope must match the actual grain of the data. |
| 4 | District of Columbia Department of Public Works. (2025). *FY 2025 Performance Accountability Report*. | Government report/statistic | https://oca.dc.gov/sites/default/files/dc/sites/oca/FY25%20PAR%20-%20DPW.pdf | Reports annual parking enforcement measures, including 1,311,978 parking tickets issued in FY2023 and 1,223,590 in FY2022, plus FY2025 quarterly enforcement measures. | The report gives official enforcement context, but annual/quarterly totals do not provide the detailed records needed for relational analysis; the project dataset must be examined separately. |
| 5 | Maryland Judiciary, District Court. (n.d.). *Traffic citation information*. | Existing system | https://www.mdcourts.gov/district/selfhelp/traffic | Describes public processes for accessing citation information, paying payable citations, and requesting payment plans or hearings. | Existing citation services demonstrate the real-world workflow; this academic prototype is limited to data organization, analysis and database demonstrations. |
| 6 | Oracle. (2024). *Oracle Database PL/SQL Language Reference* (21c). | Technical source | https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/overview.html | Oracle PL/SQL provides procedural programming features such as subprograms, control flow and exception handling. | PL/SQL can implement reusable business rules, validation and reporting inside Oracle. |
| 7 | Microsoft. (n.d.). *Connect to an Oracle database with Power BI Desktop*. Microsoft Learn. | Technical source | https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-connect-oracle-database | Power BI Desktop documents supported methods for connecting to Oracle databases. | The project can build an interactive reporting layer connected to the Oracle database rather than relying on static charts. |

## Research conclusion
The research supports the value of organizing violation information and reporting on patterns, while digital citation workflows illustrate the importance of payment status and deadlines. The proposed DC dataset is intended to provide real public parking-violation data. However, the CSV has not yet been inspected, so the final data model and project scope must remain provisional. The database may include a clearly separated simulated fine/payment demonstration layer only if the instructor accepts that distinction and the source data does not provide those transactions.

## Data integrity and privacy note
Do not claim a record count, column list, licence, aggregation level or absence of personal information until verified from the official dataset documentation and downloaded file. Exclude any field that identifies a real person or vehicle if present. Never describe generated fine or payment examples as official government records.

## Remaining Phase 0 research checks
1. Inspect the downloaded CSV and document its actual row count, columns and sample records.
2. Verify the dataset's licence or terms explicitly permit educational use.
3. Confirm that the data contains no information identifying real people; remove identifying fields before use.
4. Confirm that the dataset's level of detail supports the proposed database entities and adjust the title/scope if it contains only aggregated counts.
5. Read and verify the research references before final submission; the assignment requires at least six credible sources, including two research papers, one report/statistic, one existing system, one dataset and one technical source.
