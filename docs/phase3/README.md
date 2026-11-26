# Phase III — Oracle PDB Creation and Configuration

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Group:** I  
**Course:** INSY 8311 — Database Development with PL/SQL  
**Project:** Parking Violations Analytics and Fine Management System  
**PDB:** `I_20252SEN346_KEVIN_PARK_DB`

## Purpose

Phase III creates and configures the Oracle Pluggable Database (PDB) that will host the capstone project. It covers the PDB, administrator account, tablespaces, archive logging, Enterprise Manager Express (EM Express), and verification evidence.

## Required setup scripts

Run the scripts in `database/setup/` in the appropriate Oracle container and with the privileges stated in each script.

| Script | Purpose | Execution context |
|---|---|---|
| `01_create_pdb.sql` | Create, open and save the project PDB state | SYSDBA in CDB$ROOT; initial setup only |
| `02_create_user.sql` | Grant DBA to the PDB administrator | SYSDBA, switching into the project PDB |
| `03_tablespaces.sql` | Create data, index and temporary tablespaces; set defaults and quotas | SYSDBA inside the project PDB; initial setup only |
| `04_archive_log.sql` | Show CDB archive log mode and explain its scope | SYSDBA in CDB$ROOT |
| `05_verify.sql` | Verify PDB, administrator, tablespaces, quotas, archive mode and HTTPS port | SYSDBA; starts in CDB$ROOT |
| `06_configure_em_express.sql` | Configure the PDB HTTPS port | SYSDBA inside the project PDB |

**Important:** The five numbered scripts 01–05 are the required Phase III submission scripts. Script 06 is an additional configuration helper for the EM Express requirement. Do not rerun PDB or tablespace CREATE statements on an installation where those objects already exist.

## Required configuration

| Item | Required project setting |
|---|---|
| PDB | `I_20252SEN346_KEVIN_PARK_DB` |
| PDB state | Open READ WRITE and saved to reopen after restart |
| Administrator | `KEVIN_ADMIN` |
| Administrator role | `DBA` |
| Default tablespace | `PARK_DATA` |
| Temporary tablespace | `PARK_TEMP` |
| Data tablespace | 100 MB initial; AUTOEXTEND ON NEXT 10 MB; MAXSIZE 1 GB |
| Index tablespace | 50 MB initial; AUTOEXTEND ON NEXT 10 MB; MAXSIZE 500 MB |
| Temporary tablespace | 50 MB initial; AUTOEXTEND ON NEXT 10 MB; MAXSIZE 500 MB |
| Quotas | Unlimited on PARK_DATA and PARK_IDX |
| Archive logging | Check and document the CDB's current mode |
| EM Express HTTPS port | Requested: 5546 (student ID ends in 46); actual project PDB port: 5547 due to ORA-44718 conflict |

## Archive logging explanation

ARCHIVELOG is configured at the Container Database (CDB) level, not independently for each Pluggable Database (PDB). PDBs share the CDB's redo-log infrastructure. Therefore, a single PDB cannot independently enable or disable ARCHIVELOG mode. Changing the mode requires SYSDBA privileges and a controlled restart of the entire CDB. The activation commands in the SQL script are documentation for a student's own local installation only; do not run them on a shared university server.

## Evidence to capture

Save genuine screenshots in `screenshots/phase3/`. Use SQL Developer query results or EM Express/SQL Developer DBA panel evidence as permitted by the assignment.

| Suggested filename | What the screenshot must demonstrate |
|---|---|
| `01_pdb_status.png` | Project PDB name and READ WRITE status; show saved state where possible |
| `02_admin_user.png` | KEVIN_ADMIN account, account status, default and temporary tablespaces |
| `03_dba_privilege.png` | DBA role granted to KEVIN_ADMIN |
| `04_tablespaces.png` | PARK_DATA, PARK_IDX and PARK_TEMP sizes, autoextend and maximum sizes |
| `05_archive_log.png` | CDB name and ARCHIVELOG mode |
| `06_em_express.png` | EM Express login/session and tablespaces page, showing PDB and username; or the SQL Developer DBA panel alternative if EM Express is unavailable |

Include the date and time in the evidence where possible. Do not create illustrative or fabricated screenshots.

## Completion status

The repository contains the setup scripts and this documentation. The configuration has been checked during project work, but Phase III evidence is not considered complete until the required screenshots/query outputs have actually been captured and uploaded.

## Related files

- SQL scripts: `database/setup/`
- Screenshot upload folder: `screenshots/phase3/`
- Detailed evidence notes: `docs/evidence/phase3/README.md`

## Next phase

Phase IV covers the logical model implementation: final ERD and data dictionary alignment, table creation, constraints, indexes, views, staging, data cleaning, loading and validation. The project table-creation script is kept separate from the Phase III PDB setup scripts.


## HTTPS port exception (verified 2026-11-26)

The assignment-derived HTTPS port is **5546**. When setting the project PDB port to 5546, Oracle returned **ORA-44718: Port conflict in XDB Configuration file**. The project PDB's existing HTTPS port **5547** was retained to avoid changing another container's XDB configuration. The port was re-queried and returned 5547. This is a documented deviation from the requested port, not a claim that 5546 was configured.

The screenshot named `06_em_express.png` records the configured port. A port query alone does not prove that the EM Express web interface is accessible; if EM Express is unavailable, capture the assignment-permitted SQL Developer DBA panel evidence and include it with the submission.
