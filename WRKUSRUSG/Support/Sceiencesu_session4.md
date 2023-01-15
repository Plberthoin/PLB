---
title: Sceiencesu_session4
updated: 2023-01-15 10:24:27Z
created: 2023-01-15 10:23:39Z
---

﻿





• C’est la base de l’informatique de gestion prendre des

données et les transformer

• La base de données de l’IBMi est une base DB2





• Les langages présents sur la machine (essentiellement le

RPG et le COBOL) disposent de leurs propres instructions

pour accéder aux informations de la base de données au

parle de Raw accès.

• Remarque :

o L’accès est unitaire, un enregistrement un accès

o





• Vous devez déclarer votre Fichier

• Exemple :

o dcl-f

o GPARAM

o USAGE(\*UPDATE:\*OUTPUT)

o rename(GPARAM:GPARAMF) ;





• Accéder votre fichier

• Exemple :

o read Gparam ;

o if %eof(GPARAM) ;

• Si nécessaire , faire une mise à jour

• Exemple :

o write gparamf;

o update gparamf;





• Les accès se font par SQL , on parle de SQL embarqué

• Le système prévoira automatiquement une Zone de

communication, avec une Zone importante SQLCODE qui

renvoie le status de la dernière instruction exécuté

• Remarque :

o L’accès est ensembliste, un accès peut traiter plusieurs

enregistrements





• Accès à un enregistrement

o exec sql

o select lib into :lib from gparam ;

o If sqlcode <> 0,

• On utilise des variables host qui sont des variables du

programmes et qui commenceront par : dans une requête

SQL





• Accès à plusieurs enregistrements sauf pour les lectures ou

il faudra utiliser des curseurs on peut mettre à jour plusieurs

lignes.

• Exemple

o Update emplois set salaire = salaire \* 1.1

o Where status = ‘CADRE’

•





• Les curseurs

• Principe

• Déclaration

o EXEC SQL

o declare nomcurseur1 cursor for select …

• Ouverture

o EXEC SQL

o open nomcurseur1

• Lecture dans une Boucle

o EXEC SQL

o fetch

o from nomcurseur1





• Exemple de curseur simple





• Questions

