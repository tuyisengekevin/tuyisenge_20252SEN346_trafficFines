-- ============================================================
-- File: 04_archive_log.sql
-- Project: Parking Violations Analytics and Fine Management System
-- Student: TUYISENGE Kevin | ID: 20252SEN346 | Group: I | Course: SEN346
-- Description: Check and document ARCHIVELOG configuration.
-- Run the verification query as SYSDBA in CDB$ROOT.
-- ============================================================

-- ARCHIVELOG is a CDB-wide setting and affects every PDB in this CDB.
-- It was enabled on the student's own local Oracle installation.
-- Do not change this setting on a shared university/lab server
-- without explicit authorization.

-- Check the current archive log mode.
SELECT NAME, LOG_MODE
FROM V$DATABASE;

-- Verified result for this installation:
-- NAME   LOG_MODE
-- ORACLE ARCHIVELOG

-- If another local installation reports NOARCHIVELOG, consult the
-- instructor/database administrator before changing the CDB mode.
-- Enabling ARCHIVELOG requires a controlled database restart in
-- MOUNT mode, changing the database log mode, and reopening the CDB.
-- These administrative restart steps are intentionally not executed
-- by this verification script.

-- Explanation:
-- ARCHIVELOG mode preserves archived redo log files after log switches.
-- Archived redo logs can be used with backups to recover database changes.
-- This improves recovery options after a database or storage failure.
-- ARCHIVELOG is configured for the whole CDB, not just this project PDB.
