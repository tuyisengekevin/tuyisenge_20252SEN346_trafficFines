# Phase III — Database Creation and Configuration Evidence

Project: Parking Violations Analytics and Fine Management System  
Database: Oracle 21c  
Project PDB: `I_20252SEN346_KEVIN_PARK_DB`

## Verified configuration

| Requirement | Verified result | Status |
|---|---|---|
| Project PDB | `I_20252SEN346_KEVIN_PARK_DB` — `READ WRITE` | Verified |
| Administrator | `KEVIN_ADMIN` — `OPEN` | Verified |
| Administrator role | `KEVIN_ADMIN` granted `DBA` | Verified |
| Default tablespace | `PARK_DATA` | Verified |
| Temporary tablespace | `PARK_TEMP` | Verified |
| Data tablespace | 100 MB, autoextend YES, maximum 1024 MB | Verified |
| Index tablespace | 50 MB, autoextend YES, maximum 500 MB | Verified |
| Temporary tablespace file | 50 MB, autoextend YES, maximum 500 MB | Verified |
| Database logging | `ORCLE` in `ARCHIVELOG` mode | Verified |
| Project PDB HTTPS port | 5547; 5546 rejected with ORA-44718 port conflict | Verified; deviation documented |

## SQL setup scripts

The setup scripts are maintained in [database/setup](../../database/setup/):

1. `01_create_pdb.sql`
2. `02_create_user.sql`
3. `03_tablespaces.sql`
4. `04_archive_log.sql`
5. `05_verify.sql`
6. `06_configure_em_express.sql`

The table-creation script `07_create_tables.sql` belongs to the next implementation stage.

## Screenshot evidence checklist

Add screenshots of the actual SQL Developer query and result to this folder:

- [ ] `phase3_pdb_status.png` — PDB name and READ WRITE mode
- [ ] `phase3_admin_user.png` — administrator account status and tablespaces
- [ ] `phase3_tablespaces.png` — PARK_DATA, PARK_IDX and PARK_TEMP sizes and autoextend limits
- [ ] `phase3_archivelog.png` — ARCHIVELOG mode
- [ ] `phase3_dba_privilege.png` — DBA role grant to KEVIN_ADMIN

## Remaining work

- Confirm all six screenshot image files are present in `screenshots/phase3/` (the student reports capturing/uploading them).
- Capture the required EM Express UI evidence, or the assignment-permitted SQL Developer DBA panel evidence, if the current `06_em_express.png` only shows the HTTPS port query.
- Include the documented port deviation: requested 5546, retained 5547 because setting 5546 raised ORA-44718.

This file records verified configuration results; it does not claim that screenshot evidence has already been uploaded.
