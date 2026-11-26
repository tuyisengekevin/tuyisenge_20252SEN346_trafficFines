# Phase III — Database Creation and Configuration Evidence

Project: Parking Violations Analytics and Fine Management System  
Database: Oracle 21c  
Project PDB: `I_20252SEN346_KEVIN_PARK_DB`

## Verified configuration

| Requirement | Verified result | Status |
|---|---|---|
| Project PDB | `I_20252SEN346_KEVIN_PARK_DB` — `READ WRITE` | Verified |
| Saved PDB state | `OPEN` | Verified |
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

The table-creation script `07_create_tables.sql` is the Phase IV implementation script, separate from Phase III configuration.

## Screenshot evidence

All seven screenshot files are present in [screenshots/phase3](../../screenshots/phase3/):

- `01_pdb_status.png`
- `02_admin_user.png`
- `03_dba_privilege.png`
- `04_tablespaces.png`
- `05_archive_log.png`
- `06_em_express.png`
- `07_sql_developer_dba_panel.png`

The SQL Developer DBA panel screenshot is included as the assignment-permitted alternative evidence. A port query does not establish that the EM Express browser interface opened successfully.

## Exception to record in the submission

The required port is 5546. Oracle returned ORA-44718 when it was configured, so the existing PDB port 5547 was retained to avoid changing another container's XDB configuration. The project does not claim to have met the exact port requirement; this is a transparent documented deviation.

Phase III evidence files and the port exception are documented. See [Phase III guide](../../docs/phase3/README.md) and [screenshot notes](../../screenshots/phase3/README.md).
