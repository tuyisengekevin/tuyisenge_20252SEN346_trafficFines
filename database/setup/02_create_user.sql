-- ============================================================
-- File: 02_create_user.sql
-- Student: TUYISENGE Kevin
-- Student ID: 20252SEN346
-- Group: I
-- Project: Parking Violations Analytics and Fine Management System
-- Phase: III - Database (PDB) Creation
-- Description: Grant the DBA role to the PDB administrator created during PDB setup.
-- ============================================================

-- Run as SYSDBA. The PDB administrator was created by 01_create_pdb.sql.
-- This script configures the existing account; it does not create a duplicate.

ALTER SESSION SET CONTAINER = I_20252SEN346_KEVIN_PARK_DB;

GRANT DBA TO kevin_admin;

-- Verify the administrator account and role.
SELECT USERNAME, ACCOUNT_STATUS, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'KEVIN_ADMIN';

SELECT GRANTED_ROLE
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'KEVIN_ADMIN'
  AND GRANTED_ROLE = 'DBA';
