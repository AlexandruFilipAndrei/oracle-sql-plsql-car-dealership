-- ============================================================
-- Safe DROP and FLASHBACK TABLE demonstration
-- This script does not remove the main Furnizori table.
-- Oracle recycle bin must be enabled for FLASHBACK TABLE.
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Furnizori_Flashback_Demo PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

CREATE TABLE Furnizori_Flashback_Demo AS
SELECT *
FROM Furnizori;

DROP TABLE Furnizori_Flashback_Demo;

FLASHBACK TABLE Furnizori_Flashback_Demo TO BEFORE DROP;

SELECT *
FROM Furnizori_Flashback_Demo;

DROP TABLE Furnizori_Flashback_Demo PURGE;
