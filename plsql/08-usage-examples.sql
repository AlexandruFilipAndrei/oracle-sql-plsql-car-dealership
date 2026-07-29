-- ============================================================
-- Usage examples for procedures, functions, packages and triggers
-- Run after the project installation.
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Procedure examples
BEGIN
    AfisareVehicul(2);
    AfisareVehicul(999);
END;
/

BEGIN
    AfisareAngajatiSalariu(9000);
END;
/

-- Function examples
SELECT PretVehicul(2) AS pret_vehicul
FROM dual;

SELECT TotalVanzariAngajat(7) AS total_vanzari
FROM dual;

SELECT NumeFurnizorVehicul(12) AS furnizor
FROM dual;

SELECT CalculeazaDiscountVehicul(14) AS discount_procent
FROM dual;

SELECT NumarVehiculeDisponibile() AS vehicule_disponibile
FROM dual;

-- Package examples
BEGIN
    pachet_angajati.AfisareAngajati;
    DBMS_OUTPUT.PUT_LINE(
        'Numar total de angajati: ' || pachet_angajati.NumarAngajati
    );
END;
/

BEGIN
    pachet_vanzari.AfisareVanzari;
    DBMS_OUTPUT.PUT_LINE(
        'Numar total de vanzari: ' || pachet_vanzari.NumarVanzari
    );
END;
/

-- Trigger example 01: insertion message.
-- The temporary row is inserted and removed in the same PL/SQL block.
BEGIN
    SAVEPOINT before_vehicle_demo;
    AdaugaVehicul(99, 'Demo', 'Vehicle', 22000, 1);
    ROLLBACK TO before_vehicle_demo;
END;
/

-- Trigger example 02: price validation.
-- The trigger rejects the update, so no data change is committed.
BEGIN
    UPDATE Vehicule
    SET pret = 1000001
    WHERE id_vehicul = 11;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Trigger validation: ' || SQLERRM);
END;
/

-- Procedure deletion example using a temporary unreferenced vehicle.
BEGIN
    SAVEPOINT before_delete_demo;

    INSERT INTO Vehicule (
        id_vehicul,
        marca,
        model,
        pret,
        id_furnizor
    ) VALUES (
        98,
        'Demo',
        'Delete Test',
        18000,
        1
    );

    StergereVehicul(98);
    ROLLBACK TO before_delete_demo;
END;
/
