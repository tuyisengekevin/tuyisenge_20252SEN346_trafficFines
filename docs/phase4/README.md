# Phase IV — Tables, Data Loading and Validation

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Group:** I  
**Project:** Parking Violations Analytics and Fine Management System

## Assignment checklist

Phase IV requires:

1. Final crow's-foot ERD matching the Oracle schema, including PK, FK, UQ, CK, cardinality, optionality and delete rules.
2. Expanded data dictionary with purpose and design justification for every table, and data type, size, nullability, constraints and reason for every column.
3. Named, enabled and validated constraints, plus rejected-row tests for constraint types.
4. A documented foreign-key decision table and demonstrations of ON DELETE CASCADE, ON DELETE SET NULL and default NO ACTION.
5. Foreign-key and useful query indexes, including a composite index and a unique or function-based index; execution-plan comparison.
6. At least three views: joined reporting, GROUP BY summary, and protected read-only or check-option view.
7. Text-only staging table and raw CSV import.
8. Documented cleaning and conversion with row counts for each change.
9. Parent-first load into the normalized tables.
10. Row-count reconciliation, orphan checks, constraint status checks and sample joins, GROUP BY and subqueries.

## Progress

- [x] Phase III PDB, administrator, tablespaces and ARCHIVELOG configured; evidence and port deviation documented in `../phase3/README.md`.
- [x] Seven-table logical design and existing Oracle table-creation script are in the repository.
- [x] Existing seven-table script was run successfully in the project PDB (reported by the student).
- [x] Phase III screenshots verified in the GitHub repository.
- [ ] Final ERD updated to exactly match the Oracle schema and delete rules.
- [ ] Complete Phase IV data dictionary.
- [ ] Required DDL scripts separated into the assignment's `database/ddl/` deliverables.
- [ ] Staging, cleaning, parent-first load and validation scripts.
- [ ] Constraint, referential-action, index and view tests with authentic Oracle output screenshots.

## Important: do not recreate existing tables

The already-executed script is `database/setup/07_create_tables.sql`. It creates the seven tables, inline constraints and several FK indexes. Do not run it again in the existing schema; it will fail because the tables already exist. The Phase IV deliverable scripts will be prepared to document and complete the existing implementation safely, with separate clean-install instructions where appropriate.

## Work folders

- `database/ddl/` — table definitions, constraints, indexes and views
- `database/dml/` — staging, cleaning and final loading
- `database/tests/` — constraint, referential-action and data validation tests
- `queries/` — demonstration queries
- `screenshots/phase4/` — authentic evidence from SQL Developer showing the project PDB

The raw CSV in `data/raw/parking_violations.csv` must remain unchanged. Keep all staging columns as text, as required by the assignment, and record any cleaning rather than silently altering source data.
