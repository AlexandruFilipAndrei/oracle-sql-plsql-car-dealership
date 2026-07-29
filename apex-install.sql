-- ============================================================
-- Oracle APEX installation script
-- Oracle SQL and PL/SQL Car Dealership Database
--
-- Recommended environment: Oracle APEX SQL Workshop -> SQL Scripts.
-- The current schema must be allowed to create tables, views, indexes,
-- sequences, procedures, functions, packages and triggers.
-- ============================================================

-- ============================================================
-- DATABASE SCHEMA
-- ============================================================

-- ============================================================
-- Database schema
-- Oracle SQL and PL/SQL Car Dealership Database
-- ============================================================


-- Remove existing project objects so the script can be rerun.
BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW VanzariDetalii';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Stocuri CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Vanzari CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Vehicule CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Clienti CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Angajati CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Furnizori CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

CREATE TABLE Furnizori (
    id_furnizor   NUMBER(5)     CONSTRAINT pk_furnizori PRIMARY KEY,
    nume_furnizor VARCHAR2(50)  CONSTRAINT nn_furnizori_nume NOT NULL
);

CREATE TABLE Clienti (
    id_client   NUMBER(5)     CONSTRAINT pk_clienti PRIMARY KEY,
    nume_client VARCHAR2(50)  CONSTRAINT nn_clienti_nume NOT NULL,
    telefon     VARCHAR2(10)
);

CREATE TABLE Angajati (
    id_angajat   NUMBER(5)      CONSTRAINT pk_angajati PRIMARY KEY,
    nume_angajat VARCHAR2(50)   CONSTRAINT nn_angajati_nume NOT NULL,
    functie      VARCHAR2(50),
    salariu      NUMBER(10, 2),
    CONSTRAINT ck_angajati_salariu CHECK (salariu IS NULL OR salariu >= 0)
);

CREATE TABLE Vehicule (
    id_vehicul   NUMBER(5)      CONSTRAINT pk_vehicule PRIMARY KEY,
    marca        VARCHAR2(50)   CONSTRAINT nn_vehicule_marca NOT NULL,
    model        VARCHAR2(50)   CONSTRAINT nn_vehicule_model NOT NULL,
    pret         NUMBER(10, 2)  CONSTRAINT nn_vehicule_pret NOT NULL,
    stare        VARCHAR2(20)   DEFAULT 'Disponibila' NOT NULL,
    id_furnizor  NUMBER(5),
    CONSTRAINT ck_vehicule_pret CHECK (pret >= 0),
    CONSTRAINT ck_vehicule_stare CHECK (stare IN ('Disponibila', 'Indisponibila')),
    CONSTRAINT fk_vehicule_furnizor
        FOREIGN KEY (id_furnizor) REFERENCES Furnizori(id_furnizor)
);

CREATE TABLE Vanzari (
    id_vanzare  NUMBER(5)  CONSTRAINT pk_vanzari PRIMARY KEY,
    id_masina   NUMBER(5)  CONSTRAINT nn_vanzari_masina NOT NULL,
    id_client   NUMBER(5)  CONSTRAINT nn_vanzari_client NOT NULL,
    id_angajat  NUMBER(5)  CONSTRAINT nn_vanzari_angajat NOT NULL,
    data        DATE       CONSTRAINT nn_vanzari_data NOT NULL,
    CONSTRAINT fk_vanzari_vehicul
        FOREIGN KEY (id_masina) REFERENCES Vehicule(id_vehicul),
    CONSTRAINT fk_vanzari_client
        FOREIGN KEY (id_client) REFERENCES Clienti(id_client),
    CONSTRAINT fk_vanzari_angajat
        FOREIGN KEY (id_angajat) REFERENCES Angajati(id_angajat)
);

CREATE TABLE Stocuri (
    id_stoc     NUMBER(5)  CONSTRAINT pk_stocuri PRIMARY KEY,
    id_vehicul  NUMBER(5)  CONSTRAINT nn_stocuri_vehicul NOT NULL,
    cantitate   NUMBER(5)  CONSTRAINT nn_stocuri_cantitate NOT NULL,
    CONSTRAINT uq_stocuri_vehicul UNIQUE (id_vehicul),
    CONSTRAINT ck_stocuri_cantitate CHECK (cantitate > 0),
    CONSTRAINT fk_stocuri_vehicul
        FOREIGN KEY (id_vehicul) REFERENCES Vehicule(id_vehicul)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- ============================================================
-- Sample data
-- All people and phone numbers in this file are fictional.
-- ============================================================


-- Suppliers
INSERT INTO Furnizori VALUES (1, 'Licitatie Germania');
INSERT INTO Furnizori VALUES (2, 'Licitatie Olanda');
INSERT INTO Furnizori VALUES (3, 'Licitatie Spania');
INSERT INTO Furnizori VALUES (4, 'Licitatie Polonia');
INSERT INTO Furnizori VALUES (5, 'Germania - furnizor privat');
INSERT INTO Furnizori VALUES (6, 'Olanda - furnizor privat');
INSERT INTO Furnizori VALUES (7, 'Spania - furnizor privat');
INSERT INTO Furnizori VALUES (8, 'Polonia - furnizor privat');
INSERT INTO Furnizori VALUES (9, 'Romania - furnizor privat');
INSERT INTO Furnizori VALUES (10, 'Alte surse');

-- Clients
INSERT INTO Clienti VALUES (1, 'Client Exemplu 01', '0700000001');
INSERT INTO Clienti VALUES (2, 'Client Exemplu 02', '0700000002');
INSERT INTO Clienti VALUES (3, 'Client Exemplu 03', '0700000003');
INSERT INTO Clienti VALUES (4, 'Client Exemplu 04', '0700000004');
INSERT INTO Clienti VALUES (5, 'Client Exemplu 05', '0700000005');
INSERT INTO Clienti VALUES (6, 'Client Exemplu 06', '0700000006');
INSERT INTO Clienti VALUES (7, 'Client Exemplu 07', '0700000007');
INSERT INTO Clienti VALUES (8, 'Client Exemplu 08', '0700000008');
INSERT INTO Clienti VALUES (9, 'Client Exemplu 09', '0700000009');
INSERT INTO Clienti VALUES (10, 'Client Exemplu 10', '0700000010');

-- Employees
INSERT INTO Angajati VALUES (1, 'Angajat Exemplu 01', 'Director', 15000);
INSERT INTO Angajati VALUES (2, 'Angajat Exemplu 02', 'Manager', 12000);
INSERT INTO Angajati VALUES (3, 'Angajat Exemplu 03', 'Social Media/Promovare', 7000);
INSERT INTO Angajati VALUES (4, 'Angajat Exemplu 04', 'Social Media/Promovare', 7000);
INSERT INTO Angajati VALUES (5, 'Angajat Exemplu 05', 'Documente Auto', 8000);
INSERT INTO Angajati VALUES (6, 'Angajat Exemplu 06', 'Vânzător Mașini', 10000);
INSERT INTO Angajati VALUES (7, 'Angajat Exemplu 07', 'Vânzător Mașini', 10000);
INSERT INTO Angajati VALUES (8, 'Angajat Exemplu 08', 'Vânzător Mașini', 10000);
INSERT INTO Angajati VALUES (9, 'Angajat Exemplu 09', 'Inspector Auto', 9000);
INSERT INTO Angajati VALUES (10, 'Angajat Exemplu 10', 'Inspector Auto', 9000);

-- Vehicles
INSERT INTO Vehicule VALUES (1, 'BMW', 'Seria 3', 25000, 'Indisponibila', 1);
INSERT INTO Vehicule VALUES (2, 'Audi', 'A4', 23000, 'Indisponibila', 1);
INSERT INTO Vehicule VALUES (3, 'Mercedes', 'C-Class', 28000, 'Indisponibila', 1);
INSERT INTO Vehicule VALUES (4, 'Volkswagen', 'Passat', 18000, 'Indisponibila', 2);
INSERT INTO Vehicule VALUES (5, 'Ford', 'Focus', 15000, 'Indisponibila', 2);
INSERT INTO Vehicule VALUES (6, 'Toyota', 'Corolla', 17000, 'Indisponibila', 2);
INSERT INTO Vehicule VALUES (7, 'Honda', 'Civic', 6000, 'Indisponibila', 3);
INSERT INTO Vehicule VALUES (8, 'Hyundai', 'Elantra', 14000, 'Indisponibila', 3);
INSERT INTO Vehicule VALUES (9, 'Renault', 'Megane', 13000, 'Indisponibila', 3);
INSERT INTO Vehicule VALUES (10, 'Peugeot', '308', 12000, 'Indisponibila', 4);
INSERT INTO Vehicule VALUES (11, 'BMW', 'Seria 5', 35000, 'Disponibila', 4);
INSERT INTO Vehicule VALUES (12, 'BMW', 'X5', 45000, 'Disponibila', 4);
INSERT INTO Vehicule VALUES (13, 'Audi', 'A6', 34000, 'Disponibila', 5);
INSERT INTO Vehicule VALUES (14, 'Audi', 'Q7', 50000, 'Disponibila', 5);
INSERT INTO Vehicule VALUES (15, 'Mercedes', 'E-Class', 37000, 'Disponibila', 5);
INSERT INTO Vehicule VALUES (16, 'Mercedes', 'GLE', 60000, 'Disponibila', 6);
INSERT INTO Vehicule VALUES (17, 'Honda', 'CR-V', 28000, 'Disponibila', 7);
INSERT INTO Vehicule VALUES (18, 'Honda', 'Accord', 27000, 'Disponibila', 8);
INSERT INTO Vehicule VALUES (19, 'BMW', 'i3', 40000, 'Disponibila', 9);
INSERT INTO Vehicule VALUES (20, 'Mercedes', 'C-Class Coupe', 42000, 'Disponibila', 10);

-- Sales
INSERT INTO Vanzari VALUES (1, 1, 1, 6, DATE '2024-01-05');
INSERT INTO Vanzari VALUES (2, 2, 2, 7, DATE '2024-01-18');
INSERT INTO Vanzari VALUES (3, 3, 3, 8, DATE '2024-02-02');
INSERT INTO Vanzari VALUES (4, 4, 4, 6, DATE '2024-02-15');
INSERT INTO Vanzari VALUES (5, 5, 5, 7, DATE '2024-03-01');
INSERT INTO Vanzari VALUES (6, 6, 6, 8, DATE '2024-03-20');
INSERT INTO Vanzari VALUES (7, 7, 7, 7, DATE '2024-04-05');
INSERT INTO Vanzari VALUES (8, 8, 8, 7, DATE '2024-04-22');
INSERT INTO Vanzari VALUES (9, 9, 9, 8, DATE '2024-05-10');
INSERT INTO Vanzari VALUES (10, 10, 10, 6, DATE '2024-05-25');

-- Available stock
INSERT INTO Stocuri VALUES (1, 11, 1);
INSERT INTO Stocuri VALUES (2, 12, 1);
INSERT INTO Stocuri VALUES (3, 13, 1);
INSERT INTO Stocuri VALUES (4, 14, 1);
INSERT INTO Stocuri VALUES (5, 15, 1);
INSERT INTO Stocuri VALUES (6, 16, 1);
INSERT INTO Stocuri VALUES (7, 17, 1);
INSERT INTO Stocuri VALUES (8, 18, 1);
INSERT INTO Stocuri VALUES (9, 19, 1);
INSERT INTO Stocuri VALUES (10, 20, 1);

COMMIT;

-- ============================================================
-- DATA UPDATES
-- ============================================================

-- ============================================================
-- Data update examples
-- The statements keep the sample data consistent with sales.
-- ============================================================


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

-- ============================================================
-- DATABASE OBJECTS
-- ============================================================

-- ============================================================
-- Database objects: view, index, sequence and optional synonym
-- ============================================================


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

-- ============================================================
-- STORED PROCEDURES
-- ============================================================

-- ============================================================
-- Stored procedures
-- ============================================================


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

-- ============================================================
-- STORED FUNCTIONS
-- ============================================================

-- ============================================================
-- Stored functions
-- ============================================================


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

-- ============================================================
-- PACKAGES
-- ============================================================

-- ============================================================
-- PL/SQL packages
-- ============================================================


-- Employee package specification.
CREATE OR REPLACE PACKAGE pachet_angajati IS
    PROCEDURE AfisareAngajati;
    FUNCTION NumarAngajati RETURN NUMBER;
END pachet_angajati;
/

-- Employee package body.
CREATE OR REPLACE PACKAGE BODY pachet_angajati IS
    PROCEDURE AfisareAngajati IS
    BEGIN
        FOR r IN (
            SELECT nume_angajat, functie
            FROM Angajati
            ORDER BY id_angajat
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                r.nume_angajat || ' - ' || r.functie
            );
        END LOOP;
    END AfisareAngajati;

    FUNCTION NumarAngajati RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM Angajati;

        RETURN v_total;
    END NumarAngajati;
END pachet_angajati;
/

-- Sales package specification.
CREATE OR REPLACE PACKAGE pachet_vanzari IS
    PROCEDURE AfisareVanzari;
    FUNCTION NumarVanzari RETURN NUMBER;
END pachet_vanzari;
/

-- Sales package body.
CREATE OR REPLACE PACKAGE BODY pachet_vanzari IS
    PROCEDURE AfisareVanzari IS
    BEGIN
        FOR r IN (
            SELECT id_vanzare, id_client, id_angajat, data
            FROM Vanzari
            ORDER BY id_vanzare
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Vanzare ID: ' || r.id_vanzare ||
                ', Client: ' || r.id_client ||
                ', Angajat: ' || r.id_angajat ||
                ', Data: ' || TO_CHAR(r.data, 'YYYY-MM-DD')
            );
        END LOOP;
    END AfisareVanzari;

    FUNCTION NumarVanzari RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM Vanzari;

        RETURN v_total;
    END NumarVanzari;
END pachet_vanzari;
/

-- ============================================================
-- TRIGGERS
-- ============================================================

-- ============================================================
-- Database triggers
-- ============================================================


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

-- ============================================================
-- FINAL VALIDATION
-- Raises an error instead of printing a false success message.
-- ============================================================

DECLARE
    v_table_count   NUMBER;
    v_invalid_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_table_count
    FROM user_tables
    WHERE table_name IN (
        'FURNIZORI', 'CLIENTI', 'ANGAJATI',
        'VEHICULE', 'VANZARI', 'STOCURI'
    );

    SELECT COUNT(*)
    INTO v_invalid_count
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

    IF v_table_count <> 6 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Installation failed: expected 6 project tables, found ' || v_table_count || '.'
        );
    ELSIF v_invalid_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Installation finished with ' || v_invalid_count || ' invalid stored object(s).'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE('Installation completed successfully.');
    END IF;
END;
/
