-- ============================================================
-- File: 06_configure_em_express.sql
-- Student: TUYISENGE Kevin
-- Student ID: 20252SEN346
-- Group: I
-- Project: Parking Violations Analytics and Fine Management System
-- Phase: III - Database (PDB) Creation
-- Description: Configure the project PDB's EM Express HTTPS port using the final two digits of the student ID.
-- ============================================================

-- Run as SYSDBA. The PDB must be open READ WRITE.
-- The student's ID ends in 46, so the required HTTPS port is 5546.
-- Oracle supports setting an HTTPS port for an individual PDB.
-- This script does not overwrite a different nonzero port automatically.

ALTER SESSION SET CONTAINER = I_20252SEN346_KEVIN_PARK_DB;

DECLARE
    v_current_port NUMBER;
BEGIN
    v_current_port := DBMS_XDB_CONFIG.GETHTTPSPORT();

    IF v_current_port = 0 THEN
        DBMS_XDB_CONFIG.SETHTTPSPORT(5546);
    ELSIF v_current_port <> 5546 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'A different HTTPS port is already configured: ' || v_current_port ||
            '. Review it before changing the PDB port.'
        );
    END IF;
END;
/

-- Confirm the PDB-specific HTTPS port.
SELECT DBMS_XDB_CONFIG.GETHTTPSPORT() AS PDB_HTTPS_PORT
FROM DUAL;

-- Expected result: 5546
-- Browser URL: https://localhost:5546/em/
