-- ============================================================
-- File: 02_test_referential_actions.sql
-- Purpose: Demonstrate NO ACTION, ON DELETE SET NULL and CASCADE.
-- Run as KEVIN_ADMIN in the project PDB AFTER
-- 01_constraints_and_delete_rules.sql.
--
-- All test rows use reserved negative/synthetic identifiers and
-- are rolled back at the end. Do not run while another session
-- is using these same test identifiers.
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;

SAVEPOINT phase4_fk_test_start;

-- Test setup: one synthetic agency, violation, disposition,
-- location, ticket and penalty stage.
INSERT INTO ISSUING_AGENCY (AGENCY_CODE, AGENCY_NAME, AGENCY_SHORT)
VALUES (-9001, 'Phase IV Test Agency', 'P4TEST');

INSERT INTO VIOLATION (VIOLATION_CODE, VIOLATION_PROC_DESC)
VALUES ('ZZ_P4_TEST', 'Temporary row for referential-action testing');

INSERT INTO DISPOSITION (DISPOSITION_CODE, DISPOSITION_TYPE, DISPOSITION_DESC)
VALUES (-9001, 'TEST', 'Temporary Phase IV test disposition');

INSERT INTO LOCATION (LOCATION_TEXT, MAR_ID, XCOORD, YCOORD, LATITUDE, LONGITUDE)
VALUES ('ZZ_PHASE4_TEST_LOCATION', NULL, NULL, NULL, NULL, NULL);

INSERT INTO PARKING_TICKET (
    TICKET_NUMBER, SOURCE_OBJECT_ID, VIOLATION_TYPE_DESC,
    ISSUE_DATE, ISSUE_TIME, AGENCY_CODE, VIOLATION_CODE,
    LOCATION_ID, PLATE_STATE, VEHICLE_TYPE, MULTI_OWNER_NUMBER,
    DISPOSITION_CODE, DISPOSITION_DATE, FINE_AMOUNT, TOTAL_PAID,
    GIS_LAST_MOD_DTTM
)
SELECT
    -9001, -9001, 'P',
    SYSTIMESTAMP, 1200, -9001, 'ZZ_P4_TEST',
    LOCATION_ID, NULL, NULL, '0',
    -9001, NULL, 25.00, 0,
    SYSTIMESTAMP
FROM LOCATION
WHERE LOCATION_TEXT = 'ZZ_PHASE4_TEST_LOCATION';

INSERT INTO TICKET_PENALTY (TICKET_NUMBER, PENALTY_STAGE, PENALTY_AMOUNT)
VALUES (-9001, 1, 0);

-- Test 1: default NO ACTION. Deleting the referenced agency must fail
-- with ORA-02292 (child record found).
BEGIN
    DELETE FROM ISSUING_AGENCY WHERE AGENCY_CODE = -9001;
    RAISE_APPLICATION_ERROR(-20001, 'FAIL: NO ACTION allowed parent deletion.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2292 THEN
            DBMS_OUTPUT.PUT_LINE('PASS: NO ACTION prevented deleting referenced agency.');
        ELSE
            RAISE;
        END IF;
END;
/

-- Test 2: ON DELETE SET NULL. Deleting the location should retain
-- the ticket and clear its optional LOCATION_ID.
DELETE FROM LOCATION WHERE LOCATION_TEXT = 'ZZ_PHASE4_TEST_LOCATION';

DECLARE
    v_location_id NUMBER;
BEGIN
    SELECT LOCATION_ID INTO v_location_id
    FROM PARKING_TICKET
    WHERE TICKET_NUMBER = -9001;

    IF v_location_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('PASS: SET NULL preserved ticket and cleared LOCATION_ID.');
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'FAIL: LOCATION_ID was not set to NULL.');
    END IF;
END;
/

-- Test 3: ON DELETE CASCADE. Deleting the ticket should remove its
-- dependent penalty stage.
DELETE FROM PARKING_TICKET WHERE TICKET_NUMBER = -9001;

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TICKET_PENALTY
    WHERE TICKET_NUMBER = -9001;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('PASS: CASCADE removed dependent penalty row.');
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'FAIL: penalty row remained after ticket deletion.');
    END IF;
END;
/

-- Remove remaining synthetic reference rows, then undo all test DML.
ROLLBACK TO phase4_fk_test_start;

PROMPT Referential-action test completed; test data rolled back.
