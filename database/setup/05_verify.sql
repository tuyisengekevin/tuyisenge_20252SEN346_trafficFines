-- ============================================================
-- File: 05_verify.sql
-- Student: TUYISENGE Kevin
-- Student ID: 20252SEN346
-- Group: I
-- Project: Parking Violations Analytics and Fine Management System
-- Phase: III - Database (PDB) Creation
-- Description: Run final checks for the PDB, administrator, tablespaces, archive logging and PDB HTTPS port.
-- ============================================================

-- Run as SYSDBA. Begin in CDB$ROOT for CDB-level checks.

SHOW CON_NAME;

SELECT NAME, LOG_MODE
FROM V$DATABASE;

-- Verify the project PDB is open and its state is saved.
SELECT NAME, OPEN_MODE
FROM V$PDBS
WHERE NAME = 'I_20252SEN346_KEVIN_PARK_DB';

SELECT CON_NAME, STATE
FROM DBA_PDB_SAVED_STATES
WHERE CON_NAME = 'I_20252SEN346_KEVIN_PARK_DB';

-- Switch into the project PDB for PDB-level checks.
ALTER SESSION SET CONTAINER = I_20252SEN346_KEVIN_PARK_DB;

SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS CONTAINER_NAME
FROM DUAL;

SELECT USERNAME, ACCOUNT_STATUS, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'KEVIN_ADMIN';

SELECT GRANTEE, GRANTED_ROLE
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'KEVIN_ADMIN'
  AND GRANTED_ROLE = 'DBA';

-- Verify the PDB-specific EM Express HTTPS port.
SELECT DBMS_XDB_CONFIG.GETHTTPSPORT() AS PDB_HTTPS_PORT
FROM DUAL;

-- Verify permanent data and index tablespaces.
SELECT TABLESPACE_NAME,
       ROUND(BYTES / 1024 / 1024) AS SIZE_MB,
       AUTOEXTENSIBLE,
       ROUND(MAXBYTES / 1024 / 1024) AS MAX_SIZE_MB
FROM DBA_DATA_FILES
WHERE TABLESPACE_NAME IN ('PARK_DATA', 'PARK_IDX')
ORDER BY TABLESPACE_NAME;

-- Verify the temporary tablespace.
SELECT TABLESPACE_NAME,
       ROUND(BYTES / 1024 / 1024) AS SIZE_MB,
       AUTOEXTENSIBLE,
       ROUND(MAXBYTES / 1024 / 1024) AS MAX_SIZE_MB
FROM DBA_TEMP_FILES
WHERE TABLESPACE_NAME = 'PARK_TEMP';

-- Verify the administrator's quotas.
SELECT TABLESPACE_NAME, USERNAME, MAX_BYTES
FROM DBA_TS_QUOTAS
WHERE USERNAME = 'KEVIN_ADMIN'
  AND TABLESPACE_NAME IN ('PARK_DATA', 'PARK_IDX')
ORDER BY TABLESPACE_NAME;

-- Expected configuration:
-- PDB: I_20252SEN346_KEVIN_PARK_DB, READ WRITE, saved state OPEN
-- User: KEVIN_ADMIN; default PARK_DATA; temporary PARK_TEMP; DBA role
-- PARK_DATA: 100 MB initial; autoextend ON; maximum 1024 MB
-- PARK_IDX: 50 MB initial; autoextend ON; maximum 500 MB
-- PARK_TEMP: 50 MB initial; autoextend ON; maximum 500 MB
-- CDB log mode: ARCHIVELOG
-- PDB HTTPS port: 5546 (student ID 20252SEN346 ends in 46)
