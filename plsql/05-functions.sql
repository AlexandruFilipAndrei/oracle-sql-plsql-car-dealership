-- ============================================================
-- Stored functions
-- ============================================================

SET DEFINE OFF;

-- Return the price of a vehicle.
CREATE OR REPLACE FUNCTION PretVehicul (
    p_id IN Vehicule.id_vehicul%TYPE
) RETURN NUMBER IS
    v_pret Vehicule.pret%TYPE;
BEGIN
    SELECT pret
    INTO v_pret
    FROM Vehicule
    WHERE id_vehicul = p_id;

    RETURN v_pret;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

-- Return the number of sales made by an employee.
CREATE OR REPLACE FUNCTION TotalVanzariAngajat (
    p_id IN Angajati.id_angajat%TYPE
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM Vanzari
    WHERE id_angajat = p_id;

    RETURN v_total;
END;
/

-- Return the supplier name assigned to a vehicle.
CREATE OR REPLACE FUNCTION NumeFurnizorVehicul (
    p_id IN Vehicule.id_vehicul%TYPE
) RETURN VARCHAR2 IS
    v_nume Furnizori.nume_furnizor%TYPE;
BEGIN
    SELECT f.nume_furnizor
    INTO v_nume
    FROM Vehicule v
    JOIN Furnizori f ON v.id_furnizor = f.id_furnizor
    WHERE v.id_vehicul = p_id;

    RETURN v_nume;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

-- Return a percentage discount based on vehicle price.
CREATE OR REPLACE FUNCTION CalculeazaDiscountVehicul (
    p_id IN Vehicule.id_vehicul%TYPE
) RETURN NUMBER IS
    v_pret Vehicule.pret%TYPE;
BEGIN
    SELECT pret
    INTO v_pret
    FROM Vehicule
    WHERE id_vehicul = p_id;

    IF v_pret > 40000 THEN
        RETURN 10;
    ELSIF v_pret > 20000 THEN
        RETURN 5;
    ELSE
        RETURN 0;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
END;
/

-- Return the number of available vehicles.
CREATE OR REPLACE FUNCTION NumarVehiculeDisponibile
RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM Vehicule
    WHERE stare = 'Disponibila';

    RETURN v_total;
END;
/
