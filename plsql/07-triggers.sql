-- ============================================================
-- Database triggers
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Display a message after a new vehicle is inserted.
CREATE OR REPLACE TRIGGER trg_afisare_vehicul_nou
AFTER INSERT ON Vehicule
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Vehiculul nou adaugat este: ' ||
        :NEW.marca || ' ' || :NEW.model
    );
END;
/

-- Prevent deletion of sales older than 30 days.
CREATE OR REPLACE TRIGGER trg_blocare_stergere_vanzare
BEFORE DELETE ON Vanzari
FOR EACH ROW
BEGIN
    IF :OLD.data < SYSDATE - 30 THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'Nu se poate sterge o vanzare mai veche de 30 de zile.'
        );
    END IF;
END;
/

-- Prevent a vehicle price from exceeding 1,000,000.
CREATE OR REPLACE TRIGGER trg_verificare_pret
BEFORE INSERT OR UPDATE OF pret ON Vehicule
FOR EACH ROW
BEGIN
    IF :NEW.pret > 1000000 THEN
        RAISE_APPLICATION_ERROR(
            -20012,
            'Pretul nu poate fi mai mare de 1.000.000.'
        );
    END IF;
END;
/
