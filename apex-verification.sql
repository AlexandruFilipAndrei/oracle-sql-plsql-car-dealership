-- ============================================================
-- Oracle APEX verification script
-- Run this after apex-install.sql.
-- Upload it through SQL Workshop -> SQL Scripts -> Upload.
-- ============================================================

SET SERVEROUTPUT ON;

DECLARE
    v_table_count       NUMBER;
    v_missing_tables    NUMBER;
    v_invalid_objects   NUMBER;
    v_view_rows         NUMBER;
    v_available         NUMBER;

    PROCEDURE check_row_count(
        p_table_name IN VARCHAR2,
        p_expected   IN NUMBER
    ) IS
        v_actual NUMBER;
    BEGIN
        EXECUTE IMMEDIATE
            'SELECT COUNT(*) FROM ' || DBMS_ASSERT.SIMPLE_SQL_NAME(p_table_name)
            INTO v_actual;

        DBMS_OUTPUT.PUT_LINE(
            RPAD(p_table_name, 12) || ': ' || v_actual ||
            ' rows (expected ' || p_expected || ')'
        );

        IF v_actual <> p_expected THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                p_table_name || ' has ' || v_actual ||
                ' rows; expected ' || p_expected
            );
        END IF;
    END;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== DATABASE VERIFICATION ===');

    SELECT COUNT(*)
    INTO v_table_count
    FROM user_tables
    WHERE table_name IN (
        'FURNIZORI',
        'CLIENTI',
        'ANGAJATI',
        'VEHICULE',
        'VANZARI',
        'STOCURI'
    );

    v_missing_tables := 6 - v_table_count;

    IF v_missing_tables <> 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            v_missing_tables || ' required table(s) are missing'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('Required tables: 6/6 found');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== SAMPLE DATA ===');

    check_row_count('FURNIZORI', 10);
    check_row_count('CLIENTI', 10);
    check_row_count('ANGAJATI', 10);
    check_row_count('VEHICULE', 20);
    check_row_count('VANZARI', 10);
    check_row_count('STOCURI', 10);

    SELECT COUNT(*)
    INTO v_invalid_objects
    FROM user_objects
    WHERE object_name IN (
        'VANZARIDETALII',
        'AFISAREVEHICUL',
        'STERGEREVEHICUL',
        'ADAUGAVEHICUL',
        'AFISAREANGAJATISALARIU',
        'PRETVEHICUL',
        'TOTALVANZARIANGAJAT',
        'NUMEFURNIZORVEHICUL',
        'CALCULEAZADISCOUNTVEHICUL',
        'NUMARVEHICULEDISPONIBILE',
        'PACHET_ANGAJATI',
        'PACHET_VANZARI',
        'TRG_AFISARE_VEHICUL_NOU',
        'TRG_BLOCARE_STERGERE_VANZARE',
        'TRG_VERIFICARE_PRET'
    )
    AND status <> 'VALID';

    IF v_invalid_objects <> 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            v_invalid_objects || ' database object(s) are invalid'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Compiled objects: all VALID');

    SELECT COUNT(*)
    INTO v_view_rows
    FROM VanzariDetalii;

    DBMS_OUTPUT.PUT_LINE('VanzariDetalii rows: ' || v_view_rows);

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Procedure test:');
    AfisareVehicul(2);

    v_available := NumarVehiculeDisponibile();
    DBMS_OUTPUT.PUT_LINE('Available vehicles: ' || v_available);

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Package procedure test:');
    pachet_angajati.AfisareAngajati;

    INSERT INTO Vehicule (
        id_vehicul,
        marca,
        model,
        pret,
        stare,
        id_furnizor
    ) VALUES (
        99,
        'Test Brand',
        'Test Model',
        9999,
        'Disponibila',
        1
    );

    DELETE FROM Vehicule
    WHERE id_vehicul = 99;

    IF SQL%ROWCOUNT <> 1 THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Temporary trigger-test vehicle could not be removed'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Trigger test completed and temporary row removed.');
    DBMS_OUTPUT.PUT_LINE('VERIFICATION COMPLETED SUCCESSFULLY.');
END;
/
