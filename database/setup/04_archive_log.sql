-- ============================================================
-- File: 04_archive_log.sql
-- Student: TUYISENGE Kevin
-- Student ID: 20252SEN346
-- Group: I
-- Project: Parking Violations Analytics and Fine Management System
-- Phase: III - Database (PDB) Creation
-- Description: Verify CDB ARCHIVELOG mode and document the local-only activation procedure.
-- ============================================================

-- Run the verification query as SYSDBA in CDB$ROOT.
-- ARCHIVELOG is a CDB-wide setting, not a setting for one PDB.
-- All PDBs share the CDB redo-log infrastructure, so one PDB cannot
-- independently enable or disable archive logging.
-- Enabling it requires SYSDBA access and a controlled restart of the whole CDB.
-- Never change this setting on a shared university/lab server.

SELECT NAME, LOG_MODE
FROM V$DATABASE;

-- This installation was verified in ARCHIVELOG mode.
-- The following steps are included for documentation only.
-- They are for the student's own local installation and must NOT
-- be run on a shared lab server. They are not needed when LOG_MODE
-- already reports ARCHIVELOG.
--
-- SHUTDOWN IMMEDIATE;
-- STARTUP MOUNT;
-- ALTER DATABASE ARCHIVELOG;
-- ALTER DATABASE OPEN;
--
-- After restarting, reconnect as SYSDBA in CDB$ROOT and verify:
-- SELECT NAME, LOG_MODE FROM V$DATABASE;
