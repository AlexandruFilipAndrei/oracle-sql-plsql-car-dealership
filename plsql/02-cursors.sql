-- ============================================================
-- Explicit and implicit cursors
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Explicit cursor 01:
-- Temporarily increase the salary of salespeople with more than three sales.
DECLARE
    CURSOR c_angajati IS
        SELECT id_angajat, salariu
        FROM Angajati
        WHERE functie = 'Vânzător Mașini';

    v_id         Angajati.id_angajat%TYPE;
    v_salariu    Angajati.salariu%TYPE;
    v_nr_vanzari NUMBER;
BEGIN
    SAVEPOINT before_salary_update;

    OPEN c_angajati;
    FETCH c_angajati INTO v_id, v_salariu;

    WHILE c_angajati%FOUND LOOP
        SELECT COUNT(*)
        INTO v_nr_vanzari
        FROM Vanzari
        WHERE id_angajat = v_id;

        IF v_nr_vanzari > 3 THEN
            UPDATE Angajati
            SET salariu = salariu * 1.10
            WHERE id_angajat = v_id;

            DBMS_OUTPUT.PUT_LINE(
                'Salariu marit temporar pentru angajatul ID: ' || v_id
            );
        END IF;

        FETCH c_angajati INTO v_id, v_salariu;
    END LOOP;

    CLOSE c_angajati;
    ROLLBACK TO before_salary_update;
END;
/

-- Explicit cursor 02:
-- Display whether each vehicle is available or sold.
DECLARE
    CURSOR c_vehicule IS
        SELECT marca, model, stare
        FROM Vehicule
        ORDER BY id_vehicul;

    v_marca Vehicule.marca%TYPE;
    v_model Vehicule.model%TYPE;
    v_stare Vehicule.stare%TYPE;
BEGIN
    OPEN c_vehicule;

    LOOP
        FETCH c_vehicule INTO v_marca, v_model, v_stare;
        EXIT WHEN c_vehicule%NOTFOUND;

        CASE v_stare
            WHEN 'Indisponibila' THEN
                DBMS_OUTPUT.PUT_LINE(
                    v_marca || ' ' || v_model || ' - a fost vanduta.'
                );
            ELSE
                DBMS_OUTPUT.PUT_LINE(
                    v_marca || ' ' || v_model || ' - este in stoc.'
                );
        END CASE;
    END LOOP;

    CLOSE c_vehicule;
END;
/

-- Implicit cursor 01:
-- Display the number of sales made by each employee.
BEGIN
    FOR r IN (
        SELECT a.nume_angajat,
               COUNT(z.id_vanzare) AS nr_vanzari
        FROM Angajati a
        LEFT JOIN Vanzari z ON a.id_angajat = z.id_angajat
        GROUP BY a.id_angajat, a.nume_angajat
        ORDER BY a.id_angajat
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Angajatul ' || r.nume_angajat ||
            ' a realizat ' || r.nr_vanzari || ' vanzari.'
        );
    END LOOP;
END;
/

-- Implicit cursor 02:
-- Display the number of vehicles bought by each client.
BEGIN
    FOR r IN (
        SELECT c.nume_client,
               COUNT(z.id_vanzare) AS nr_masini
        FROM Clienti c
        LEFT JOIN Vanzari z ON c.id_client = z.id_client
        GROUP BY c.id_client, c.nume_client
        ORDER BY c.id_client
    ) LOOP
        IF r.nr_masini = 0 THEN
            DBMS_OUTPUT.PUT_LINE(
                r.nume_client || ' nu a cumparat nicio masina.'
            );
        ELSIF r.nr_masini = 1 THEN
            DBMS_OUTPUT.PUT_LINE(
                r.nume_client || ' a cumparat o masina.'
            );
        ELSE
            DBMS_OUTPUT.PUT_LINE(
                r.nume_client || ' a cumparat ' ||
                r.nr_masini || ' masini.'
            );
        END IF;
    END LOOP;
END;
/
