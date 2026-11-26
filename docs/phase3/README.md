# Phase III — Oracle PDB Creation and Configuration

**Student:** TUYISENGE Kevin  
**Student ID:** 20252SEN346  
**Group:** I  
**Course:** INSY 8311 — Database Development with PL/SQL  
**Project:** Parking Violations Analytics and Fine Management System  
**PDB:** `I_20252SEN346_KEVIN_PARK_DB`

## Purpose

Phase III creates and configures the Oracle Pluggable Database (PDB) that hosts the capstone project. It covers the PDB, administrator account, tablespaces, archive logging, EM Express configuration and verification evidence.

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

**Important:** Scripts 01–05 are the required Phase III submission scripts. Script 06 is an additional EM Express configuration helper. Do not rerun PDB or tablespace CREATE statements on an installation where those objects already exist.

## Required configuration and observed result

| Item | Required setting | Observed result |
|---|---|---|
| PDB | `I_20252SEN346_KEVIN_PARK_DB` | READ WRITE; saved state OPEN |
| Administrator | `KEVIN_ADMIN` with DBA role | Verified |
| Default tablespace | `PARK_DATA` | Verified |
| Temporary tablespace | `PARK_TEMP` | Verified |
| Data tablespace | 100 MB; AUTOEXTEND ON NEXT 10 MB; MAXSIZE 1 GB | Verified |
| Index tablespace | 50 MB; AUTOEXTEND ON NEXT 10 MB; MAXSIZE 500 MB | Verified |
| Temporary tablespace | 50 MB; AUTOEXTEND ON NEXT 10 MB; MAXSIZE 500 MB | Verified |
| Quotas | Unlimited on PARK_DATA and PARK_IDX | Verified |
| Archive logging | CDB current mode | `ORCLE` is in ARCHIVELOG |
| EM Express HTTPS port | 5546 (ID ends in 46) | 5547 retained; see documented exception |

## Archive logging explanation

ARCHIVELOG is configured at the Container Database (CDB) level, not independently for each Pluggable Database (PDB). PDBs share the CDB's redo-log infrastructure. Therefore, a single PDB cannot independently enable or disable ARCHIVELOG mode. Changing the mode requires SYSDBA privileges and a controlled restart of the entire CDB. The activation commands in the SQL script are documentation for a student's own local installation only; do not run them on a shared university server.

## Screenshot evidence

All seven genuine screenshot files have been verified in `screenshots/phase3/`:

- `01_pdb_status.png`
- `02_admin_user.png`
- `03_dba_privilege.png`
- `04_tablespaces.png`
- `05_archive_log.png`
- `06_em_express.png` — port configuration evidence
- `07_sql_developer_dba_panel.png` — SQL Developer DBA panel alternative evidence

The DBA panel screenshot is the assignment-permitted alternative when EM Express is unavailable. The presence of a port query screenshot does not claim that the EM Express browser page was accessible.

## Phase III status

**Configuration and repository evidence are reviewed and documented, with one exception:** the assignment requires HTTPS port 5546. Oracle returned **ORA-44718: Port conflict in XDB Configuration file** when setting 5546. The project's existing port **5547** was retained to avoid changing another container's XDB configuration. The actual port was re-queried and returned 5547. This is a transparent deviation; the exact port requirement is not claimed as satisfied.

The seven screenshot files and supporting SQL scripts are present in the repository. See [evidence summary](../evidence/phase3/README.md).

## Next phase

Phase IV covers implementation of the logical model: final ERD and data dictionary alignment, table creation, constraints, indexes, staging, data cleaning, loading and validation. The project table-creation script is maintained separately from the Phase III PDB setup scripts.
