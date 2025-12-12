CREATE DATABASE bibliotheque
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE bibliotheque;
CREATE TABLE auteur (
  id   INT AUTO_INCREMENT PRIMARY KEY,
  nom  VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE ouvrage (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  titre       VARCHAR(200) NOT NULL,
  disponible  BOOLEAN NOT NULL DEFAULT TRUE,
  auteur_id   INT NOT NULL,
  CONSTRAINT fk_ouvrage_auteur
    FOREIGN KEY (auteur_id)
    REFERENCES auteur(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;
CREATE TABLE abonne (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  nom   VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE emprunt (
  ouvrage_id  INT NOT NULL,
  abonne_id   INT NOT NULL,
  date_debut  DATE NOT NULL DEFAULT (CURRENT_DATE),
  date_fin    DATE,

  PRIMARY KEY (ouvrage_id, abonne_id, date_debut),

  CONSTRAINT fk_emprunt_ouvrage
    FOREIGN KEY (ouvrage_id)
    REFERENCES ouvrage(id)
    ON DELETE RESTRICT,

  CONSTRAINT fk_emprunt_abonne
    FOREIGN KEY (abonne_id)
    REFERENCES abonne(id)
    ON DELETE CASCADE,

  CONSTRAINT ck_date_emprunt
    CHECK (date_fin IS NULL OR date_fin >= date_debut)
) ENGINE=InnoDB;
SELECT titre
FROM ouvrage
WHERE disponible = TRUE;
SELECT nom, email
FROM abonne
WHERE email LIKE '%@gmail.com';
SELECT *
FROM emprunt
WHERE date_fin IS NULL;
SELECT a.nom, o.titre
FROM emprunt e
JOIN abonne a ON e.abonne_id = a.id
JOIN ouvrage o ON e.ouvrage_id = o.id;
SELECT abonne_id, COUNT(*) AS total
FROM emprunt
GROUP BY abonne_id;
SELECT 
  abonne.id,
  abonne.nom,
  COUNT(*) 
FROM emprunt
JOIN abonne 
  ON emprunt.abonne_id = abonne.id
GROUP BY 
  abonne.id, abonne.nom;
UPDATE ouvrage
SET disponible = FALSE
WHERE id = 5;
DELETE FROM emprunt
WHERE date_fin < '2025-01-01';

