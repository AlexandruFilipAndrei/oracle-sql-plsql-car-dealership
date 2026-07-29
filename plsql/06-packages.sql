-- ============================================================
-- PL/SQL packages
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Employee package specification.
CREATE OR REPLACE PACKAGE pachet_angajati IS
    PROCEDURE AfisareAngajati;
    FUNCTION NumarAngajati RETURN NUMBER;
END pachet_angajati;
/

-- Employee package body.
CREATE OR REPLACE PACKAGE BODY pachet_angajati IS
    PROCEDURE AfisareAngajati IS
    BEGIN
        FOR r IN (
            SELECT nume_angajat, functie
            FROM Angajati
            ORDER BY id_angajat
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                r.nume_angajat || ' - ' || r.functie
            );
        END LOOP;
    END AfisareAngajati;

    FUNCTION NumarAngajati RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM Angajati;

        RETURN v_total;
    END NumarAngajati;
END pachet_angajati;
/

-- Sales package specification.
CREATE OR REPLACE PACKAGE pachet_vanzari IS
    PROCEDURE AfisareVanzari;
    FUNCTION NumarVanzari RETURN NUMBER;
END pachet_vanzari;
/

-- Sales package body.
CREATE OR REPLACE PACKAGE BODY pachet_vanzari IS
    PROCEDURE AfisareVanzari IS
    BEGIN
        FOR r IN (
            SELECT id_vanzare, id_client, id_angajat, data
            FROM Vanzari
            ORDER BY id_vanzare
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Vanzare ID: ' || r.id_vanzare ||
                ', Client: ' || r.id_client ||
                ', Angajat: ' || r.id_angajat ||
                ', Data: ' || TO_CHAR(r.data, 'YYYY-MM-DD')
            );
        END LOOP;
    END AfisareVanzari;

    FUNCTION NumarVanzari RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM Vanzari;

        RETURN v_total;
    END NumarVanzari;
END pachet_vanzari;
/
