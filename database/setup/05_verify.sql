-- ============================================================
-- File: 05_verify.sql
-- Project: Parking Violations Analytics and Fine Management System
-- Student: TUYISENGE Kevin | ID: 20252SEN346 | Group: I | Course: SEN346
-- Description: Final verification of Phase III database setup.
-- Run as SYSDBA so the required DBA views are accessible.
-- ============================================================

-- A. CDB-level checks: run while connected to CDB$ROOT.
SHOW CON_NAME;

SELECT NAME, LOG_MODE
FROM V$DATABASE;

SELECT DBMS_XDB_CONFIG.GETHTTPSPORT() AS HTTPS_PORT
FROM DUAL;

-- B. Verify the project PDB is open and its state is saved.
SELECT NAME, OPEN_MODE
FROM V$PDBS
WHERE NAME = 'I_20252SEN346_KEVIN_PARK_DB';

SELECT CON_NAME, STATE
FROM DBA_PDB_SAVED_STATES
WHERE CON_NAME = 'I_20252SEN346_KEVIN_PARK_DB';

-- C. Switch into the project PDB for user and tablespace checks.
ALTER SESSION SET CONTAINER = I_20252SEN346_KEVIN_PARK_DB;

SELECT USERNAME, ACCOUNT_STATUS, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'KEVIN_ADMIN';

SELECT GRANTEE, GRANTED_ROLE
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'KEVIN_ADMIN'
  AND GRANTED_ROLE = 'DBA';

-- D. Verify permanent data and index tablespaces.
SELECT TABLESPACE_NAME,
       ROUND(BYTES / 1024 / 1024) AS SIZE_MB,
       AUTOEXTENSIBLE,
       ROUND(MAXBYTES / 1024 / 1024) AS MAX_SIZE_MB
FROM DBA_DATA_FILES
WHERE TABLESPACE_NAME IN ('PARK_DATA', 'PARK_IDX')
ORDER BY TABLESPACE_NAME;

-- E. Verify the temporary tablespace.
SELECT TABLESPACE_NAME,
       ROUND(BYTES / 1024 / 1024) AS SIZE_MB,
       AUTOEXTENSIBLE,
       ROUND(MAXBYTES / 1024 / 1024) AS MAX_SIZE_MB
FROM DBA_TEMP_FILES
WHERE TABLESPACE_NAME = 'PARK_TEMP';

-- F. Verify the administrator's quotas.
SELECT TABLESPACE_NAME, USERNAME, MAX_BYTES
FROM DBA_TS_QUOTAS
WHERE USERNAME = 'KEVIN_ADMIN'
  AND TABLESPACE_NAME IN ('PARK_DATA', 'PARK_IDX')
ORDER BY TABLESPACE_NAME;

-- Expected key results:
-- PDB: I_20252SEN346_KEVIN_PARK_DB, READ WRITE, saved state OPEN
-- User: KEVIN_ADMIN; default PARK_DATA; temporary PARK_TEMP
-- Granted role: DBA
-- PARK_DATA: 100 MB initial; autoextend YES; maximum 1024 MB
-- PARK_IDX: 50 MB initial; autoextend YES; maximum 500 MB
-- PARK_TEMP: 50 MB initial; autoextend YES; maximum 500 MB
-- CDB log mode: ARCHIVELOG
-- HTTPS port configured in CDB$ROOT: 5546
