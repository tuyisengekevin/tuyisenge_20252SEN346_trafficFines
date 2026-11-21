-- ============================================================
-- File: 02_create_user.sql
-- Project: Parking Violations Analytics and Fine Management System
-- Student: TUYISENGE Kevin | ID: 20252SEN346 | Group: I | Course: SEN346
-- Description: Configure the PDB administrator and grant DBA.
-- Run as SYSDBA. The administrator was created by 01_create_pdb.sql.
-- This script configures that account; it does not create a duplicate.
-- ============================================================

ALTER SESSION SET CONTAINER = I_20252SEN346_KEVIN_PARK_DB;

-- The lab account already exists and is unlocked in the completed setup.
-- Grant the required database administrator role inside the project PDB.
GRANT DBA TO kevin_admin;

-- Verify the administrator account and role.
SELECT USERNAME, ACCOUNT_STATUS, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'KEVIN_ADMIN';

SELECT GRANTED_ROLE
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'KEVIN_ADMIN'
  AND GRANTED_ROLE = 'DBA';
