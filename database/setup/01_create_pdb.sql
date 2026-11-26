-- ============================================================
-- File: 01_create_pdb.sql
-- Student: TUYISENGE Kevin
-- Student ID: 20252SEN346
-- Group: I
-- Project: Parking Violations Analytics and Fine Management System
-- Phase: III - Database (PDB) Creation
-- Description: Create and open the project pluggable database.
-- ============================================================

-- Run once as SYSDBA from CDB$ROOT in SQL Developer Run Script mode.
-- Oracle stores unquoted identifiers in uppercase; the lowercase
-- spelling below follows the lecturer's required naming convention.
-- PDB name: i_20252sen346_kevin_park_db (27 characters).
--
-- Do not store the administrator password in a tracked SQL file.
-- SQL*Plus/SQL Developer prompts for it without echoing the input.

ACCEPT pdb_admin_password CHAR PROMPT 'Enter a password for KEVIN_ADMIN: ' HIDE

CREATE PLUGGABLE DATABASE i_20252sen346_kevin_park_db
  ADMIN USER kevin_admin
  IDENTIFIED BY "&pdb_admin_password";

UNDEFINE pdb_admin_password;

ALTER PLUGGABLE DATABASE i_20252sen346_kevin_park_db
  OPEN READ WRITE;

ALTER PLUGGABLE DATABASE i_20252sen346_kevin_park_db
  SAVE STATE;

-- Verify that the PDB is open and its state is saved.
SELECT NAME, OPEN_MODE
FROM V$PDBS
WHERE NAME = 'I_20252SEN346_KEVIN_PARK_DB';

SELECT CON_NAME, STATE
FROM DBA_PDB_SAVED_STATES
WHERE CON_NAME = 'I_20252SEN346_KEVIN_PARK_DB';
