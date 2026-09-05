-- =====================================================================
-- TIFOSI - Script de peuplement (données de test)
-- Sources : focaccia.xlsx, ingredient.xlsx, boisson.xlsx, marque.xlsx
-- =====================================================================
USE tifosi;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE comprend;
TRUNCATE TABLE contient;
TRUNCATE TABLE achete;
TRUNCATE TABLE menu;
TRUNCATE TABLE boisson;
TRUNCATE TABLE focaccia;
TRUNCATE TABLE ingredient;
TRUNCATE TABLE marque;
TRUNCATE TABLE client;
SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------------------
-- marque
-- -----------------------------------------------------------------
INSERT INTO marque (id_marque, nom) VALUES
(1, 'Coca-cola'),
(2, 'Cristalline'),
(3, 'Monster'),
(4, 'Pepsico');

-- -----------------------------------------------------------------
-- ingredient
-- -----------------------------------------------------------------
INSERT INTO ingredient (id_ingredient, nom) VALUES
(1, 'Ail'),
(2, 'Ananas'),
(3, 'Artichaut'),
(4, 'Bacon'),
(5, 'Base Tomate'),
(6, 'Base crème'),
(7, 'Champignon'),
(8, 'Chevre'),
(9, 'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fumé'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise'),
(25, 'Mozarella');

-- -----------------------------------------------------------------
-- boisson
-- -----------------------------------------------------------------
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
(1, 'Coca-cola zéro', 1),
(2, 'Coca-cola original', 1),
(3, 'Fanta citron', 1),
(4, 'Fanta orange', 1),
(5, 'Capri-sun', 1),
(6, 'Pepsi', 4),
(7, 'Pepsi Max Zéro', 4),
(8, 'Lipton zéro citron', 4),
(9, 'Lipton Peach', 4),
(10, 'Monster energy ultra gold', 3),
(11, 'Monster energy ultra blue', 3),
(12, 'Eau de source', 2);

-- -----------------------------------------------------------------
-- focaccia
-- -----------------------------------------------------------------
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
(1, 'Mozaccia', 9.8),
(2, 'Gorgonzollaccia', 10.8),
(3, 'Raclaccia', 8.9),
(4, 'Emmentalaccia', 9.8),
(5, 'Tradizione', 8.9),
(6, 'Hawaienne', 11.2),
(7, 'Américaine', 10.8),
(8, 'Paysanne', 12.8);

-- -----------------------------------------------------------------
-- comprend (composition de chaque focaccia, quantite en grammes)
-- -----------------------------------------------------------------
INSERT INTO comprend (id_ingredient, id_focaccia, quantite) VALUES
(5, 1, 200),
(25, 1, 50),
(9, 1, 20),
(13, 1, 80),
(1, 1, 2),
(3, 1, 20),
(7, 1, 40),
(18, 1, 50),
(20, 1, 1),
(16, 1, 20),
(5, 2, 200),
(11, 2, 50),
(9, 2, 20),
(1, 2, 2),
(7, 2, 40),
(18, 2, 50),
(20, 2, 1),
(16, 2, 20),
(5, 3, 200),
(22, 3, 50),
(9, 3, 20),
(1, 3, 2),
(7, 3, 40),
(18, 3, 50),
(20, 3, 1),
(6, 4, 200),
(10, 4, 50),
(9, 4, 20),
(7, 4, 40),
(18, 4, 50),
(20, 4, 1),
(15, 4, 20),
(5, 5, 200),
(25, 5, 50),
(9, 5, 20),
(12, 5, 80),
(7, 5, 80),
(18, 5, 50),
(20, 5, 1),
(16, 5, 10),
(17, 5, 10),
(5, 6, 200),
(25, 6, 50),
(9, 6, 20),
(4, 6, 80),
(2, 6, 40),
(19, 6, 2),
(18, 6, 50),
(20, 6, 1),
(16, 6, 20),
(5, 7, 200),
(25, 7, 50),
(9, 7, 20),
(4, 7, 80),
(21, 7, 40),
(18, 7, 50),
(20, 7, 1),
(16, 7, 20),
(6, 8, 200),
(8, 8, 50),
(9, 8, 20),
(21, 8, 80),
(13, 8, 80),
(1, 8, 2),
(3, 8, 20),
(7, 8, 40),
(18, 8, 50),
(20, 8, 1),
(16, 8, 20),
(14, 8, 50);
