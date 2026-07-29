-- ============================================================
-- Stored procedures
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Display the make, model and price of a vehicle.
CREATE OR REPLACE PROCEDURE AfisareVehicul (
    p_id IN Vehicule.id_vehicul%TYPE
) IS
    v_marca Vehicule.marca%TYPE;
    v_model Vehicule.model%TYPE;
    v_pret  Vehicule.pret%TYPE;
BEGIN
    SELECT marca, model, pret
    INTO v_marca, v_model, v_pret
    FROM Vehicule
    WHERE id_vehicul = p_id;

    DBMS_OUTPUT.PUT_LINE(
        'Vehicul: ' || v_marca || ' ' || v_model ||
        ', Pret: ' || v_pret
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Vehiculul nu exista.');
END;
/

-- Delete a vehicle when it is not referenced by another table.
CREATE OR REPLACE PROCEDURE StergereVehicul (
    p_id IN Vehicule.id_vehicul%TYPE
) IS
    e_child_records      EXCEPTION;
    e_vehicul_inexistent EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_child_records, -2292);
BEGIN
    DELETE FROM Vehicule
    WHERE id_vehicul = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_vehicul_inexistent;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Vehiculul a fost sters.');
EXCEPTION
    WHEN e_child_records THEN
        DBMS_OUTPUT.PUT_LINE(
            'Vehiculul are inregistrari asociate si nu poate fi sters.'
        );
    WHEN e_vehicul_inexistent THEN
        DBMS_OUTPUT.PUT_LINE('Vehiculul nu exista.');
END;
/

-- Add a new vehicle. The availability status uses the table default.
CREATE OR REPLACE PROCEDURE AdaugaVehicul (
    p_id           IN Vehicule.id_vehicul%TYPE,
    p_marca        IN Vehicule.marca%TYPE,
    p_model        IN Vehicule.model%TYPE,
    p_pret         IN Vehicule.pret%TYPE,
    p_id_furnizor  IN Vehicule.id_furnizor%TYPE
) IS
BEGIN
    INSERT INTO Vehicule (
        id_vehicul,
        marca,
        model,
        pret,
        id_furnizor
    ) VALUES (
        p_id,
        p_marca,
        p_model,
        p_pret,
        p_id_furnizor
    );

    DBMS_OUTPUT.PUT_LINE('Vehicul adaugat cu succes.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Exista deja un vehicul cu acest ID.');
END;
/

-- Display employees whose salaries exceed a supplied value.
CREATE OR REPLACE PROCEDURE AfisareAngajatiSalariu (
    p_salariu IN Angajati.salariu%TYPE
) IS
    v_nr_angajati NUMBER := 0;
BEGIN
    FOR r IN (
        SELECT nume_angajat, salariu
        FROM Angajati
        WHERE salariu > p_salariu
        ORDER BY salariu DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.nume_angajat || ' - ' || r.salariu
        );
        v_nr_angajati := v_nr_angajati + 1;
    END LOOP;

    IF v_nr_angajati = 0 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Nu exista angajati cu salariul mai mare decat ' || p_salariu
        );
    END IF;
END;
/
