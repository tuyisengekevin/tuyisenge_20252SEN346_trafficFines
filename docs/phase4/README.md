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
- [x] Final ERD source and rendered outputs are in `docs/design/`: `erd.dot`, `erd_phase4.svg` and `erd.png`.
- [x] Relationship cardinality, optionality and selected delete rules documented in the ERD and data dictionary.
- [x] Phase IV Oracle implementation data dictionary added: [data_dictionary_phase4.md](../design/data_dictionary_phase4.md). The original [logical dictionary and raw-field mapping](../design/data_dictionary.md) are retained.
- [x] Constraints/delete-rule script prepared: [01_constraints_and_delete_rules.sql](../../database/ddl/01_constraints_and_delete_rules.sql). **Not yet run in Oracle.**
- [x] Referential-action test script prepared: [02_test_referential_actions.sql](../../database/tests/02_test_referential_actions.sql). **Tests are not yet executed; do not mark the delete rules verified until the Oracle output is captured.**
- [ ] Apply the planned `ON DELETE SET NULL` and `ON DELETE CASCADE` rules in Oracle and verify with tests.
- [x] Phase IV index script prepared: [02_phase4_indexes.sql](../../database/ddl/02_phase4_indexes.sql) (composite and function-based indexes; not yet run).
- [x] Three reporting/protected views prepared: [03_phase4_views.sql](../../database/ddl/03_phase4_views.sql) (not yet created in Oracle).
- [x] Text-only staging table script prepared: [01_create_staging_table.sql](../../database/dml/01_create_staging_table.sql); the CSV import is not yet done.
- [x] Staging/import and parent-first load workflow documented: [staging_import_and_load_plan.md](staging_import_and_load_plan.md).
- [x] Data validation/reconciliation queries prepared: [03_phase4_data_validation.sql](../../database/tests/03_phase4_data_validation.sql) (not yet executed).
- [ ] Cleaning/conversion and parent-first load SQL; constraint rejection tests; query-plan comparison; authentic Oracle output screenshots.

## Important: do not recreate existing tables

The already-executed script is `database/setup/07_create_tables.sql`. It creates the seven tables, inline constraints and several FK indexes. Do not run it again in the existing schema; it will fail because the tables already exist. Phase IV deliverable scripts are being prepared to complete the existing implementation safely, without dropping or recreating the tables.

## Work folders

- `database/ddl/` — table/constraint/index/view scripts
- `database/dml/` — staging, cleaning and final loading
- `database/tests/` — constraint, referential-action and data validation tests
- `queries/` — demonstration queries
- `screenshots/phase4/` — authentic evidence from SQL Developer showing the project PDB

The raw CSV in `data/raw/parking_violations.csv` must remain unchanged. Keep all staging columns as text, as required by the assignment, and record any cleaning rather than silently altering source data.
