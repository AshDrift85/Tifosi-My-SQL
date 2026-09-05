-- =====================================================================
-- TIFOSI - Script de vérification (10 requêtes de test)
-- =====================================================================
USE tifosi;


-- =====================================================================
-- Requête 1 : Afficher la liste des noms des focaccias par ordre
--             alphabétique croissant
-- =====================================================================
SELECT nom
FROM focaccia
ORDER BY nom ASC;

-- Résultat attendu (8 lignes) :
-- Américaine, Emmentalaccia, Gorgonzollaccia, Hawaienne, Mozaccia,
-- Paysanne, Raclaccia, Tradizione
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 2 : Afficher le nombre total d'ingrédients
-- =====================================================================
SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;

-- Résultat attendu : 25
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 3 : Afficher le prix moyen des focaccias
-- =====================================================================
SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM focaccia;

-- Résultat attendu : 10.38 € (moyenne exacte 10.375)
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 4 : Afficher la liste des boissons avec leur marque,
--             triée par nom de boisson
-- =====================================================================
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
INNER JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom ASC;

-- Résultat attendu (12 lignes) :
-- Capri-sun / Coca-cola
-- Coca-cola original / Coca-cola
-- Coca-cola zéro / Coca-cola
-- Eau de source / Cristalline
-- Fanta citron / Coca-cola
-- Fanta orange / Coca-cola
-- Lipton Peach / Pepsico
-- Lipton zéro citron / Pepsico
-- Monster energy ultra blue / Monster
-- Monster energy ultra gold / Monster
-- Pepsi / Pepsico
-- Pepsi Max Zéro / Pepsico
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 5 : Afficher la liste des ingrédients pour une Raclaccia
-- =====================================================================
SELECT i.nom AS ingredient, c.quantite
FROM comprend c
INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
INNER JOIN focaccia f ON f.id_focaccia = c.id_focaccia
WHERE f.nom = 'Raclaccia';

-- Résultat attendu (7 lignes) :
-- Base Tomate, Raclette, Cresson, Ail, Champignon, Parmesan, Poivre
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 6 : Afficher le nom et le nombre d'ingrédients pour
--             chaque focaccia
-- =====================================================================
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
LEFT JOIN comprend c ON c.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- Résultat attendu (8 lignes) :
-- Américaine : 8       Emmentalaccia : 7     Gorgonzollaccia : 8
-- Hawaienne : 9         Mozaccia : 10          Paysanne : 12
-- Raclaccia : 7         Tradizione : 9
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 7 : Afficher le nom de la focaccia qui a le plus
--             d'ingrédients
-- =====================================================================
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
INNER JOIN comprend c ON c.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- Résultat attendu : Paysanne (12 ingrédients)
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 8 : Afficher la liste des focaccia qui contiennent de l'ail
-- =====================================================================
SELECT DISTINCT f.nom AS focaccia
FROM focaccia f
INNER JOIN comprend c ON c.id_focaccia = f.id_focaccia
INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- Résultat attendu (4 lignes) :
-- Gorgonzollaccia, Mozaccia, Paysanne, Raclaccia
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 9 : Afficher la liste des ingrédients inutilisés
-- =====================================================================
SELECT i.nom AS ingredient
FROM ingredient i
LEFT JOIN comprend c ON c.id_ingredient = i.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom ASC;

-- Résultat attendu (2 lignes) :
-- Salami, Tomate cerise
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun


-- =====================================================================
-- Requête 10 : Afficher la liste des focaccia qui n'ont pas de
--              champignons
-- =====================================================================
SELECT f.nom AS focaccia
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

-- Résultat attendu (2 lignes) :
-- Américaine, Hawaienne
-- Résultat obtenu : conforme au résultat attendu
-- Écarts constatés : aucun
