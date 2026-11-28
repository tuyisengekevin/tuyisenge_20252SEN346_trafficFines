-- Phase IV: raw CSV staging table
-- Connect as KEVIN_ADMIN to I_20252SEN346_KEVIN_PARK_DB.
-- Import the original CSV into this table using SQL Developer's Import Data.
-- All 31 source fields are VARCHAR2 so raw values are preserved as text.
-- Do not load directly into normalized tables or modify the raw CSV.

SET DEFINE OFF;
WHENEVER SQLERROR EXIT SQL.SQLCODE;

CREATE TABLE PARKING_TICKET_STAGE (
    OBJECTID              VARCHAR2(4000),
    TICKET_NUMBER         VARCHAR2(4000),
    VIOLATION_TYPE_DESC   VARCHAR2(4000),
    ISSUE_DATE            VARCHAR2(4000),
    ISSUE_TIME            VARCHAR2(4000),
    ISSUING_AGENCY_CODE   VARCHAR2(4000),
    ISSUING_AGENCY_NAME   VARCHAR2(4000),
    ISSUING_AGENCY_SHORT  VARCHAR2(4000),
    VIOLATION_CODE        VARCHAR2(4000),
    VIOLATION_PROC_DESC   VARCHAR2(4000),
    LOCATION              VARCHAR2(4000),
    PLATE_STATE           VARCHAR2(4000),
    VEHICLE_TYPE          VARCHAR2(4000),
    MULTI_OWNER_NUMBER    VARCHAR2(4000),
    DISPOSITION_CODE      VARCHAR2(4000),
    DISPOSITION_TYPE      VARCHAR2(4000),
    DISPOSITION_DESC      VARCHAR2(4000),
    DISPOSITION_DATE      VARCHAR2(4000),
    FINE_AMOUNT           VARCHAR2(4000),
    TOTAL_PAID            VARCHAR2(4000),
    PENALTY_1             VARCHAR2(4000),
    PENALTY_2             VARCHAR2(4000),
    PENALTY_3             VARCHAR2(4000),
    PENALTY_4             VARCHAR2(4000),
    PENALTY_5             VARCHAR2(4000),
    XCOORD                VARCHAR2(4000),
    YCOORD                VARCHAR2(4000),
    LATITUDE              VARCHAR2(4000),
    LONGITUDE             VARCHAR2(4000),
    MAR_ID                VARCHAR2(4000),
    GIS_LAST_MOD_DTTM     VARCHAR2(4000)
) TABLESPACE PARK_DATA;

COMMENT ON TABLE PARKING_TICKET_STAGE IS
'Phase IV raw CSV staging; source columns intentionally stored as text.';
