-- ============================================================
-- Main project installation script
-- Run this file with F5 (Run Script) in Oracle SQL Developer.
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

PROMPT Creating database schema...
@@sql/01-schema.sql

PROMPT Inserting sample data...
@@sql/02-sample-data.sql

PROMPT Applying data updates...
@@sql/03-data-updates.sql

PROMPT Creating database objects...
@@sql/05-database-objects.sql

PROMPT Creating stored procedures...
@@plsql/04-procedures.sql

PROMPT Creating stored functions...
@@plsql/05-functions.sql

PROMPT Creating packages...
@@plsql/06-packages.sql

PROMPT Creating triggers...
@@plsql/07-triggers.sql

PROMPT Project installation completed.
PROMPT Run sql/04-queries.sql and plsql/08-usage-examples.sql separately.
