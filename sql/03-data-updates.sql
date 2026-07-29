-- ============================================================
-- Data update examples
-- The statements keep the sample data consistent with sales.
-- ============================================================

SET DEFINE OFF;

-- Mark every sold vehicle as unavailable.
UPDATE Vehicule
SET stare = 'Indisponibila'
WHERE id_vehicul IN (
    SELECT id_masina
    FROM Vanzari
);

-- Keep unsold vehicles marked as available.
UPDATE Vehicule
SET stare = 'Disponibila'
WHERE id_vehicul NOT IN (
    SELECT id_masina
    FROM Vanzari
);

-- Assign salaries according to employee roles.
UPDATE Angajati
SET salariu = CASE
    WHEN functie = 'Director' THEN 15000
    WHEN functie = 'Manager' THEN 12000
    WHEN functie = 'Social Media/Promovare' THEN 7000
    WHEN functie = 'Documente Auto' THEN 8000
    WHEN functie = 'Vânzător Mașini' THEN 10000
    WHEN functie = 'Inspector Auto' THEN 9000
    ELSE 6000
END;

COMMIT;
