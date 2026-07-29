-- ============================================================
-- Predefined, Oracle and user-defined exception examples
-- Change the values below before running the script when needed.
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE ON;

DEFINE id_angajat = 6
DEFINE id_vehicul = 1

-- Exception example 01: NO_DATA_FOUND and WHEN OTHERS.
DECLARE
    v_id_angajat Angajati.id_angajat%TYPE := &id_angajat;
    v_salariu    Angajati.salariu%TYPE;
BEGIN
    SELECT salariu
    INTO v_salariu
    FROM Angajati
    WHERE id_angajat = v_id_angajat;

    DBMS_OUTPUT.PUT_LINE(
        'Salariul angajatului cu ID ' || v_id_angajat ||
        ' este: ' || v_salariu
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Nu exista angajatul cu ID-ul ' || v_id_angajat
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
/

-- Exception example 02: Map Oracle error ORA-02292 to a named exception.
DECLARE
    e_child_records EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_child_records, -2292);

    v_id_vehicul Vehicule.id_vehicul%TYPE := &id_vehicul;
BEGIN
    SAVEPOINT before_delete;

    DELETE FROM Vehicule
    WHERE id_vehicul = v_id_vehicul;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Nu exista vehiculul cu ID-ul ' || v_id_vehicul
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Vehiculul cu ID-ul ' || v_id_vehicul || ' a fost sters temporar.'
        );
    END IF;

    ROLLBACK TO before_delete;
EXCEPTION
    WHEN e_child_records THEN
        DBMS_OUTPUT.PUT_LINE(
            'Vehiculul nu poate fi sters deoarece are inregistrari asociate.'
        );
        ROLLBACK TO before_delete;
    WHEN OTHERS THEN
        ROLLBACK TO before_delete;
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
/

-- Exception example 03: User-defined exception based on SQL%ROWCOUNT.
DECLARE
    e_vehicul_inexistent EXCEPTION;
    v_id_vehicul Vehicule.id_vehicul%TYPE := &id_vehicul;
BEGIN
    SAVEPOINT before_price_update;

    UPDATE Vehicule
    SET pret = pret * 1.10
    WHERE id_vehicul = v_id_vehicul;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_vehicul_inexistent;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Pretul vehiculului cu ID-ul ' || v_id_vehicul ||
        ' a fost actualizat temporar.'
    );

    ROLLBACK TO before_price_update;
EXCEPTION
    WHEN e_vehicul_inexistent THEN
        DBMS_OUTPUT.PUT_LINE(
            'Nu exista vehiculul cu ID-ul ' || v_id_vehicul
        );
        ROLLBACK TO before_price_update;
    WHEN OTHERS THEN
        ROLLBACK TO before_price_update;
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
/

-- Exception example 04: RAISE_APPLICATION_ERROR.
DECLARE
    v_id_angajat Angajati.id_angajat%TYPE := &id_angajat;
    v_nume       Angajati.nume_angajat%TYPE;
    v_nr_vanzari NUMBER;
BEGIN
    SELECT nume_angajat
    INTO v_nume
    FROM Angajati
    WHERE id_angajat = v_id_angajat;

    SELECT COUNT(*)
    INTO v_nr_vanzari
    FROM Vanzari
    WHERE id_angajat = v_id_angajat;

    IF v_nr_vanzari = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Angajatul ' || v_nume || ' nu a realizat nicio vanzare.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Angajatul ' || v_nume || ' a realizat ' ||
        v_nr_vanzari || ' vanzari.'
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Nu exista angajatul cu ID-ul ' || v_id_angajat
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
/

UNDEFINE id_angajat
UNDEFINE id_vehicul
