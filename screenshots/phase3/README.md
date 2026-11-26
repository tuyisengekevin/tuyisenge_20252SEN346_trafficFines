# Phase III Screenshots

Genuine Oracle screenshots uploaded to this folder:

1. `01_pdb_status.png` — PDB name and READ WRITE status
2. `02_admin_user.png` — administrator account and tablespace defaults
3. `03_dba_privilege.png` — DBA role grant
4. `04_tablespaces.png` — PARK_DATA, PARK_IDX and PARK_TEMP configuration
5. `05_archive_log.png` — CDB ARCHIVELOG mode
6. `06_em_express.png` — configured HTTPS port evidence
7. `07_sql_developer_dba_panel.png` — SQL Developer DBA panel, used as the assignment-permitted alternative to EM Express UI evidence

All seven image files have been verified in the repository tree. Use the screenshots as evidence of the configuration shown; they do not imply that the EM Express browser page itself was successfully opened.

## HTTPS port exception

The assignment-derived port is 5546 (student ID ends in 46). Oracle rejected 5546 with ORA-44718 (XDB port conflict), so the project's existing HTTPS port 5547 was retained rather than changing another container's XDB configuration. This deviation is documented in [Phase III notes](../../docs/phase3/README.md).

Only use authentic screenshots from the student's Oracle environment. Include date/time where visible and do not fabricate or edit query results.
