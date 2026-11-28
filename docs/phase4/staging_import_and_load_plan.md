# Phase IV — Staging Import and Loading Plan

This guide complements the SQL scripts. It does not claim the import or normalized load has been performed.

## A. Create the text staging table

1. Open SQL Developer and connect as `KEVIN_ADMIN` to the project PDB.
2. Open and run `database/dml/01_create_staging_table.sql` once.
3. Confirm `PARKING_TICKET_STAGE` appears under Tables.

The staging table has all 31 source columns as `VARCHAR2(4000)`. This preserves the raw text while allowing later validation and conversion.

## B. Import the original CSV

1. In SQL Developer, right-click `PARKING_TICKET_STAGE` → **Import Data**.
2. Select the repository's original `data/raw/parking_violations.csv`.
3. Choose CSV, confirm the first row contains column headers, and verify the column mapping matches the source order.
4. Use comma as delimiter and double quote as text qualifier if prompted.
5. Import all rows; do not filter or transform them during this step.
6. Run `SELECT COUNT(*) FROM PARKING_TICKET_STAGE;` — expected count is 89,078.
7. Save a screenshot showing the count and successful import.

Keep the original CSV unchanged. If SQL Developer reports rejected rows, save the error details and resolve the import issue before continuing.

## C. Clean and convert

Run the checks in `database/tests/03_phase4_data_validation.sql` before inserting into normalized tables. The raw-field mapping and documented missing-value counts are in `docs/design/data_dictionary.md` and `data/dataset_card.md`.

- Convert blank text to NULL only where the target column is optional.
- Preserve source sentinel `MULTI_OWNER_NUMBER = 0` as text; do not treat it as a missing value.
- Validate numeric identifiers, money, HHMM values and coordinates before conversion.
- Parse timestamp fields using the actual CSV timestamp pattern and timezone.
- Deduplicate exact location strings and create LOCATION rows before ticket rows.
- Preserve all five penalty columns by inserting stage rows 1 through 5.

Document each cleaning rule and the before/after row count in the Phase IV research log.

## D. Parent-first load order

1. VIOLATION_TYPE
2. ISSUING_AGENCY
3. VIOLATION
4. DISPOSITION
5. LOCATION
6. PARKING_TICKET
7. TICKET_PENALTY

The load SQL must use explicit column lists, validate foreign keys, and avoid deleting or recreating the existing tables.

## E. Evidence still required

- Staging table created and CSV row count verified.
- Import success and rejected-row count.
- Cleaning decisions and row counts.
- Final table counts and orphan checks.
- Valid constraint status and referential-action test output.
- View/index status and query plan comparison.
