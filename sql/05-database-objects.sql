-- ============================================================
-- Database objects: view, index, sequence and optional synonym
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW VanzariDetalii';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

CREATE VIEW VanzariDetalii AS
SELECT z.id_vanzare,
       v.marca,
       v.model,
       c.nume_client,
       a.nume_angajat,
       z.data
FROM Vanzari z
JOIN Vehicule v ON z.id_masina = v.id_vehicul
JOIN Clienti c ON z.id_client = c.id_client
JOIN Angajati a ON z.id_angajat = a.id_angajat;

BEGIN
    EXECUTE IMMEDIATE 'DROP INDEX idx_marca_vehicule';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1418 THEN
            RAISE;
        END IF;
END;
/

CREATE INDEX idx_marca_vehicule
ON Vehicule(marca);

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_clienti_id';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

CREATE SEQUENCE seq_clienti_id
START WITH 11
INCREMENT BY 1
NOCACHE;

-- A private synonym requires the CREATE SYNONYM privilege.
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP SYNONYM VehiculeSimplu';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -1434 THEN
                RAISE;
            END IF;
    END;

    EXECUTE IMMEDIATE 'CREATE SYNONYM VehiculeSimplu FOR Vehicule';
    DBMS_OUTPUT.PUT_LINE('Optional synonym VehiculeSimplu created.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Optional synonym was not created: ' || SQLERRM
        );
END;
/

-- Verification examples
SELECT * FROM VanzariDetalii;

EXPLAIN PLAN FOR
SELECT *
FROM Vehicule
WHERE marca = 'BMW';
