-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:Alfonso Daniel Bianchi                Votre DA:6236742
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC     outils_emprunt;
DESC     outils_outil;
DESC     outils_usager;
-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT  CONCAT(prenom ,' ', nom_famille) AS "liste des usagers"
FROM outils_usager;      
-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT ville AS "habitat des usagers"
FROM outils_usager
ORDER BY ville ASC;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
FROM outils_outil
ORDER BY nom ASC;

SELECT *
FROM outils_outil
ORDER BY code_outil ASC;
-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT num_emprunt AS "Numéro d'emprunt"
FROM outils_emprunt 
WHERE date_retour IS null;
-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT num_emprunt AS "Numéro d'emprunt"
FROM outils_emprunt
WHERE date_emprunt < '14-01-01';
-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT  name AS "Nom",
        code_outil AS "Code de l'outil"
FROM outils_outil   
WHERE UPPER (description) LIKE '%JAUNE%';
-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT  name AS "nom",
        code_outil AS "Code de l'outil"
FROM outils_outil
WHERE fabricant = 'Stanley';      
-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT  name AS "nom",
        fabricant AS "Fabricant:"
FROM outils_outil
WHERE année BETWEEN 2006 AND 2008;
-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT  code_outil AS "Code de l'outil",
        nom AS "Nom de l'outil"
FROM outils_outil   
WHERE UPPER (description) NOT LIKE '%20 VOLTS%';
-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) AS "Nombre d'outils"
FROM outils_outil
WHERE Fabricant <> 'Makita';
-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(f.Prenom, ' ', f.nom_famille) AS "Nom_Complet",
       e.Numero_Emprunt,
       e.Duree_Emprunt,
       f.Prix
FROM outils_emprunt e
JOIN outils_usager d ON e.num_usager = d.num_usager
JOIN outils_outil f ON e.code_outil = f.code_outil
WHERE d.Ville IN ('Vancouver', 'Regina')
AND e.date_retour IS NOT NULL
AND Outils.Prix IS NOT NULL;
-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT  e.nom AS "Nom de l'outil:",
        e.code_outil AS "Code de l'outil:"
FROM outils_outil e
JOIN outils_emprunt d
ON e.code_outil = d.code_outil
WHERE d.date_retour IS NULL;
-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT  nom_famille AS "Nom de famille:",
        courriel AS "Couriel:"
FROM outils_usager 
WHERE num_usager NOT IN (SELECT DISTINCT num_usager FROM outils_emprunt);
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT  e.code_outil AS "Code de l'outil",
        e.prix AS "Prix"
FROM outils_outil e
LEFT OUTER JOIN outils_emprunt d 
ON e.code_outil = d.code_outil
WHERE d.code_outil IS NULL;
-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT  e.nom AS "Nom de l'outil:",
        COALESCE(e.prix, AVG(TousLesOutils.prix)) AS "Prix"
FROM outils_outil e
JOIN (SELECT ABG(prix) AS prix FROM outils) AS TousLesOutils
WHERE e.fabricant = 'Makita' 
AND (e.prix > TousLesOutils.prix OR e.prix IS NULL);
-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT  u.nom AS "Nom usager:",
        u.prenom AS "Prenom usager:",
        u.ADRESSE AS "addresse:",
        o.nom AS "Nom outil:",
        o.code_outil AS "Code outil:"
FROM outils_outil o, outils_emprunt e, outils_usager u
WHERE   e.num_usager = u.num_usager 
 AND    e.code_outil = o.code_outil
 AND    e.date_emprunt >= '2014-01-01'  
ORDER BY nom ASC
-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT  o.nom AS "nom de l'outil",
        o.prix AS "prix"
FROM outils_outil o,outils_emprunt e
WHERE o.code_outil = e.code_outil
AND o.code_outil IN 
(SELECT code_outil FROM outils_emprunt GROUP BY code_outil HAVING COUNT(*) >= 2); 

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
--  IN
SELECT  u.nom AS "nom de l'outil",
        u.adresse AS "Adresse",
        u.ville AS "Ville:"
FROM outils_usager u
JOIN outils_emprunt e 
ON u.num_usager = e.num_usager
WHERE u.num_usager IN(SELECT DISTINCT num_usager FROM outils_emprunt);
--  EXISTS
SELECT u.nom AS "nom de l'outil",
        u.adresse AS "Adresse",
        u.ville AS "Ville:"
FROM outils_usager u
WHERE EXISTS
(SELECT num_usager FROM outils_emprunt e WHERE e.num_usager = u.num_usager); 
-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT  fabricant AS "Marque", 
        AVG(prix) AS "moyenne_prix"
FROM outils_outil
GROUP BY fabricant;
-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT  u.ville AS "Nom Ville:",
       SUM(prix) AS somme_prix
FROM outils_outil o, outils_emprunt e, outils_usager u
WHERE   e.num_usager = u.num_usager 
 AND    e.code_outil = o.code_outil
GROUP BY u.ville  
ORDER BY somme_prix DESC;
-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL,NOM,FABRICANT,CARACTERISTIQUES,ANNEE,PRIX) VALUES ('PH768','LanceFlammes','Makita','100 watts, noire, gazoline','2008','300');
-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL,NOM,ANNEE) VALUES ('AT786','Chainsaw','2009');
-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM outils_outil WHERE code_outil IN ('PH768','AT786');
-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE outils_outil SET nom_famille = UPPER(nom_famille);





