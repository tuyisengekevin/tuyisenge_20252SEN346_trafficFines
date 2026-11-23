-- ============================================================
-- File: 03_tablespaces.sql
-- Project: Parking Violations Analytics and Fine Management System
-- Description: Create project tablespaces and configure user quotas.
-- Run as SYSDBA inside I_20252SEN346_KEVIN_PARK_DB.
-- Initial-setup script: do not rerun CREATE statements if the
-- tablespaces already exist.
-- ============================================================

ALTER SESSION SET CONTAINER = I_20252SEN346_KEVIN_PARK_DB;

-- Main data tablespace: 100 MB initial, 10 MB growth, 1 GB maximum.
CREATE TABLESPACE park_data
  DATAFILE SIZE 100M
  AUTOEXTEND ON NEXT 10M
  MAXSIZE 1G;

-- Index tablespace: 50 MB initial, 10 MB growth, 500 MB maximum.
CREATE TABLESPACE park_idx
  DATAFILE SIZE 50M
  AUTOEXTEND ON NEXT 10M
  MAXSIZE 500M;

-- Temporary tablespace: 50 MB initial, 10 MB growth, 500 MB maximum.
CREATE TEMPORARY TABLESPACE park_temp
  TEMPFILE SIZE 50M
  AUTOEXTEND ON NEXT 10M
  MAXSIZE 500M;

-- Assign the administrator's default and temporary tablespaces.
ALTER USER kevin_admin
  DEFAULT TABLESPACE park_data
  TEMPORARY TABLESPACE park_temp;

-- Grant unlimited quota on the two permanent project tablespaces.
ALTER USER kevin_admin QUOTA UNLIMITED ON park_data;
ALTER USER kevin_admin QUOTA UNLIMITED ON park_idx;

-- Verify user defaults.
SELECT USERNAME, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'KEVIN_ADMIN';

-- Verify permanent tablespace size and autoextend settings.
SELECT TABLESPACE_NAME,
       ROUND(BYTES / 1024 / 1024) AS SIZE_MB,
       AUTOEXTENSIBLE,
       ROUND(MAXBYTES / 1024 / 1024) AS MAX_SIZE_MB
FROM DBA_DATA_FILES
WHERE TABLESPACE_NAME IN ('PARK_DATA', 'PARK_IDX');

-- Verify temporary tablespace size and autoextend settings.
SELECT TABLESPACE_NAME,
       ROUND(BYTES / 1024 / 1024) AS SIZE_MB,
       AUTOEXTENSIBLE,
       ROUND(MAXBYTES / 1024 / 1024) AS MAX_SIZE_MB
FROM DBA_TEMP_FILES
WHERE TABLESPACE_NAME = 'PARK_TEMP';

-- Verify the administrator's tablespace quotas.
SELECT TABLESPACE_NAME, USERNAME, MAX_BYTES
FROM DBA_TS_QUOTAS
WHERE USERNAME = 'KEVIN_ADMIN'
  AND TABLESPACE_NAME IN ('PARK_DATA', 'PARK_IDX');
