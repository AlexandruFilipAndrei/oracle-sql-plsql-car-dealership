-- ============================================================
-- Database schema
-- Oracle SQL and PL/SQL Car Dealership Database
-- ============================================================

SET DEFINE OFF;

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
