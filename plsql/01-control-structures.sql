-- ============================================================
-- PL/SQL control structures
-- ============================================================

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Display sold vehicles by budget category.
BEGIN
    FOR v IN (
        SELECT vh.marca, vh.model, vh.pret
        FROM Vehicule vh
        JOIN Vanzari z ON vh.id_vehicul = z.id_masina
        ORDER BY vh.pret DESC
    ) LOOP
        IF v.pret < 15000 THEN
            DBMS_OUTPUT.PUT_LINE(
                'De buget: ' || v.marca || ' ' || v.model ||
                ' - ' || v.pret || ' EUR'
            );
        ELSE
            DBMS_OUTPUT.PUT_LINE(
                'Buget ridicat: ' || v.marca || ' ' || v.model ||
                ' - ' || v.pret || ' EUR'
            );
        END IF;
    END LOOP;
END;
/
