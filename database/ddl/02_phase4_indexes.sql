-- Phase IV additional indexes.
-- Run once as KEVIN_ADMIN in the project PDB, after checking USER_INDEXES
-- to ensure these index names do not already exist.
-- Existing PK/UQ and foreign-key indexes from 07_create_tables.sql remain.

CREATE INDEX IX_TICKET_DATE_AGENCY
    ON PARKING_TICKET (ISSUE_DATE, AGENCY_CODE)
    TABLESPACE PARK_IDX;

CREATE INDEX IX_TICKET_PLATE_UPPER
    ON PARKING_TICKET (UPPER(PLATE_STATE))
    TABLESPACE PARK_IDX;

-- Evidence query: includes the PK/UQ unique indexes and these Phase IV indexes.
SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS, STATUS
FROM USER_INDEXES
WHERE TABLE_NAME IN ('PARKING_TICKET', 'TICKET_PENALTY',
                     'ISSUING_AGENCY', 'LOCATION')
ORDER BY TABLE_NAME, INDEX_NAME;
