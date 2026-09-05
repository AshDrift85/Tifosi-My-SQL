-- =====================================================================
-- TIFOSI - Script de création de la base de données
-- Restaurant de street-food italien "Tifosi"
-- =====================================================================

-- -----------------------------------------------------------------
-- 1. BASE DE DONNEES
-- -----------------------------------------------------------------
DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- -----------------------------------------------------------------
-- 2. UTILISATEUR DEDIE A L'ADMINISTRATION DE LA BASE
-- -----------------------------------------------------------------
-- Remplacer 'MotDePasseFort_123!' par un mot de passe robuste avant
-- toute mise en production. Ne jamais committer un vrai mot de passe
-- dans un dépôt public : utiliser une variable d'environnement ou un
-- fichier .env ignoré par Git.
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'CHANGE_ME_BEFORE_USE';

-- Droits complets, mais limités à la base tifosi uniquement
-- (principe de moindre privilège : pas de droits globaux/serveur).
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

USE tifosi;

-- -----------------------------------------------------------------
-- 3. TABLES DE REFERENCE (sans dépendances)
-- -----------------------------------------------------------------

CREATE TABLE ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(50) NOT NULL,
    CONSTRAINT uk_ingredient_nom UNIQUE (nom)
) ENGINE=InnoDB;

CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(50) NOT NULL,
    CONSTRAINT uk_marque_nom UNIQUE (nom)
) ENGINE=InnoDB;

CREATE TABLE client (
    id_client    INT AUTO_INCREMENT PRIMARY KEY,
    nom          VARCHAR(50)  NOT NULL,
    email        VARCHAR(150) NOT NULL,
    code_postal  INT          NOT NULL,
    CONSTRAINT uk_client_email UNIQUE (email),
    CONSTRAINT chk_client_code_postal CHECK (code_postal BETWEEN 1000 AND 99999)
) ENGINE=InnoDB;

CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(50)    NOT NULL,
    prix        DECIMAL(5,2)   NOT NULL,
    CONSTRAINT uk_focaccia_nom UNIQUE (nom),
    CONSTRAINT chk_focaccia_prix CHECK (prix >= 0)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------
-- 4. TABLES DEPENDANTES (relations 1,1 / 0,n -> clé étrangère simple)
-- -----------------------------------------------------------------

-- appartient : boisson (1,1) -- marque (0,n)
-- Chaque boisson appartient à exactement une marque.
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom        VARCHAR(50) NOT NULL,
    id_marque  INT         NOT NULL,
    CONSTRAINT fk_boisson_marque FOREIGN KEY (id_marque)
        REFERENCES marque (id_marque)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uk_boisson_nom_marque UNIQUE (nom, id_marque)
) ENGINE=InnoDB;

-- est constitué : focaccia (0,n) -- menu (1,1)
-- Chaque menu est constitué d'exactement une focaccia ;
-- une focaccia peut être déclinée dans plusieurs menus.
CREATE TABLE menu (
    id_menu     INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(50)  NOT NULL,
    prix        DECIMAL(5,2) NOT NULL,
    id_focaccia INT          NOT NULL,
    CONSTRAINT uk_menu_nom UNIQUE (nom),
    CONSTRAINT chk_menu_prix CHECK (prix >= 0),
    CONSTRAINT fk_menu_focaccia FOREIGN KEY (id_focaccia)
        REFERENCES focaccia (id_focaccia)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- -----------------------------------------------------------------
-- 5. TABLES DE LIAISON (relations n,n)
-- -----------------------------------------------------------------

-- comprend : ingredient (0,n) -- focaccia (1,n), attribut quantite
CREATE TABLE comprend (
    id_ingredient INT NOT NULL,
    id_focaccia   INT NOT NULL,
    quantite      INT NOT NULL,
    PRIMARY KEY (id_ingredient, id_focaccia),
    CONSTRAINT fk_comprend_ingredient FOREIGN KEY (id_ingredient)
        REFERENCES ingredient (id_ingredient)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_comprend_focaccia FOREIGN KEY (id_focaccia)
        REFERENCES focaccia (id_focaccia)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT chk_comprend_quantite CHECK (quantite > 0)
) ENGINE=InnoDB;

-- contient : menu (1,n) -- boisson (0,n)
CREATE TABLE contient (
    id_menu    INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_contient_menu FOREIGN KEY (id_menu)
        REFERENCES menu (id_menu)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_contient_boisson FOREIGN KEY (id_boisson)
        REFERENCES boisson (id_boisson)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- achete : client (0,n) -- menu (0,n), attribut date_achat
-- Clé de substitution id_achat pour permettre à un client d'acheter
-- plusieurs fois le même menu à des dates différentes.
CREATE TABLE achete (
    id_achat   INT AUTO_INCREMENT PRIMARY KEY,
    id_client  INT  NOT NULL,
    id_menu    INT  NOT NULL,
    date_achat DATE NOT NULL,
    CONSTRAINT fk_achete_client FOREIGN KEY (id_client)
        REFERENCES client (id_client)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_achete_menu FOREIGN KEY (id_menu)
        REFERENCES menu (id_menu)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- -----------------------------------------------------------------
-- 6. INDEX complémentaires pour les requêtes fréquentes
-- -----------------------------------------------------------------
CREATE INDEX idx_achete_date ON achete (date_achat);
CREATE INDEX idx_boisson_nom ON boisson (nom);
