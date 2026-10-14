\xEF\xBB\xBF-- Food delivery database (Microsoft SQL Server)
-- Step 1: create the database and all 10 tables

CREATE DATABASE dostava_hrane;
GO
USE dostava_hrane;
GO

CREATE TABLE Korisnik (
    korisnik_id INT PRIMARY KEY IDENTITY,
    ime NVARCHAR(50),
    prezime NVARCHAR(50),
    email NVARCHAR(100),
    lozinka NVARCHAR(255),
    telefon NVARCHAR(20),
    adresa NVARCHAR(255)
);

CREATE TABLE Restoran (
    restoran_id INT PRIMARY KEY IDENTITY,
    naziv NVARCHAR(100),
    adresa NVARCHAR(255),
    telefon NVARCHAR(20),
    tip_kuhinje NVARCHAR(50)
);

CREATE TABLE Kategorija (
    kategorija_id INT PRIMARY KEY IDENTITY,
    naziv NVARCHAR(100),
    opis NVARCHAR(255),
    aktivan BIT
);

CREATE TABLE Jelo (
    jelo_id INT PRIMARY KEY IDENTITY,
    restoran_id INT,
    kategorija_id INT,
    naziv NVARCHAR(100),
    opis NVARCHAR(255),
    cena DECIMAL(10,2),
    dostupno BIT,
    FOREIGN KEY (restoran_id) REFERENCES Restoran(restoran_id),
    FOREIGN KEY (kategorija_id) REFERENCES Kategorija(kategorija_id)
);

CREATE TABLE Narudzbina (
    narudzbina_id INT PRIMARY KEY IDENTITY,
    korisnik_id INT,
    datum_vreme DATETIME,
    status NVARCHAR(50),
    ukupna_cena DECIMAL(10,2),
    FOREIGN KEY (korisnik_id) REFERENCES Korisnik(korisnik_id)
);

CREATE TABLE StavkaNarudzbine (
    stavka_id INT PRIMARY KEY IDENTITY,
    narudzbina_id INT,
    jelo_id INT,
    kolicina INT,
    cena_ukupno DECIMAL(10,2),
    FOREIGN KEY (narudzbina_id) REFERENCES Narudzbina(narudzbina_id),
    FOREIGN KEY (jelo_id) REFERENCES Jelo(jelo_id)
);

CREATE TABLE Dostavljac (
    dostavljac_id INT PRIMARY KEY IDENTITY,
    ime NVARCHAR(50),
    prezime NVARCHAR(50),
    vozilo NVARCHAR(50)
);

CREATE TABLE Dostava (
    dostava_id INT PRIMARY KEY IDENTITY,
    narudzbina_id INT,
    dostavljac_id INT,
    vreme_preuzimanja DATETIME,
    vreme_isporuke DATETIME,
    FOREIGN KEY (narudzbina_id) REFERENCES Narudzbina(narudzbina_id),
    FOREIGN KEY (dostavljac_id) REFERENCES Dostavljac(dostavljac_id)
);

CREATE TABLE Placanje (
    placanje_id INT PRIMARY KEY IDENTITY,
    narudzbina_id INT,
    iznos DECIMAL(10,2),
    datum_placanja DATE,
    nacin_placanja NVARCHAR(50),
    status NVARCHAR(50),
    FOREIGN KEY (narudzbina_id) REFERENCES Narudzbina(narudzbina_id)
);

CREATE TABLE Recenzija (
    recenzija_id INT PRIMARY KEY IDENTITY,
    korisnik_id INT,
    jelo_id INT,
    ocena INT,
    komentar NVARCHAR(1000),
    datum_postavljanja DATE,
    verifikovana_kupovina BIT,
    FOREIGN KEY (korisnik_id) REFERENCES Korisnik(korisnik_id),
    FOREIGN KEY (jelo_id) REFERENCES Jelo(jelo_id)
);
GO
