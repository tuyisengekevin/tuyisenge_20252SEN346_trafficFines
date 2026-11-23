

-- 1. Create the project PDB and its administrator account.
CREATE PLUGGABLE DATABASE I_20252SEN346_KEVIN_PARK_DB
  ADMIN USER kevin_admin
  IDENTIFIED BY kevin;

-- 2. Open the PDB for normal read/write operations.
ALTER PLUGGABLE DATABASE I_20252SEN346_KEVIN_PARK_DB
  OPEN READ WRITE;

-- 3. Save the open state so Oracle opens this PDB after CDB restart.
ALTER PLUGGABLE DATABASE I_20252SEN346_KEVIN_PARK_DB
  SAVE STATE;

-- 4. Verify that the PDB is open.
SELECT NAME, OPEN_MODE
FROM V$PDBS
WHERE NAME = 'I_20252SEN346_KEVIN_PARK_DB';

-- 5. Verify that the open state was saved.
SELECT CON_NAME, STATE
FROM DBA_PDB_SAVED_STATES
WHERE CON_NAME = 'I_20252SEN346_KEVIN_PARK_DB';
