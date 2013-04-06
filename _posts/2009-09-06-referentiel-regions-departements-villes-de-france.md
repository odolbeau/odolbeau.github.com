---
layout: old_post
title: "Référentiel des régions, départements et villes de France"
description: "Référentiel des régions, départements et villes de France"
tags: [référentiel, régions, départements, villes, France, symfony, propel]
---

Tout formulaire d'inscription ou presque impose la saisie d'une adresse qui devra être sévèrement contrôlée afin d'éviter les informations erronées.

Une solution simple pour s'éviter une partie de ces contrôles rébarbatifs (et bien souvent faillibles): obliger l'utilisateur à **sélectionner la ville** qu'il souhaite dans une liste déroulante. Et la difficulté principale liée à la mise en place d'un système semblable n'est bien sur pas d'ordre technique.

En effet, la première étape consiste à trouver un **référentiel** complet des communes françaises. Et c'est là que les choses se compliquent. Les nomenclatures officielles semblent rares et sont généralement peu complètes.

A ce jour, le référentiel le plus complet que je suis parvenu a trouvé est celui de l'**INSEE** (disponible [ici](http://www.insee.fr/fr/methodes/nomenclatures/cog/telechargement.asp "Nomclatures INSEE") au format txt et mbf). Il contient la liste complète des communes, cantons, arrondissements, départements et régions de France au 1^er^ janvier 2009 (les référentiels des années précédentes sont également disponibles sur la même page). Malheureusement, ce référentiel ne contient pas les **code postaux** des communes.

Je me suis personnellement limité aux régions, départements et communes, jugeant les cantons et les arrondissements d'un intérêt limité. J'ai également supprimé de nombreuses informations pour ne garder que l'essentiel, c'est à dire pour les communes: le nom, le département et la région.

Voici donc le [script SQL](/uploads/posts/2009-09-06/script.sql "Script SQL des régions, départements et communes de France") (généré par phpmyadmin) qui vous permettra de créer les trois tables (régions, départements et communes) puis de les remplir. Vous pouvez également récupérer l'[archive (zip)](/uploads/posts/2009-09-06/script.zip "Archive Script SQL des régions départements et communes de France") contenant ce fichier.

Petit bonus pour celles et ceux qui utilisent **Symfony**, voici les 3 fichiers **fixtures** (pour Propel uniquement): [régions](/uploads/posts/2009-09-06/0100-region.yml "Fixtures Propel d'insertion des régions"), [départements](/uploads/posts/2009-09-06/0200-department.yml "Fixtures Propel d'insertion des départements") et [communes](/uploads/posts/2009-09-06/0300-city.yml "Fixtures Propel d'insertion des communes"). Vous pouvez également récupérer l'[archive (zip)](/uploads/posts/2009-09-06/fixtures.zip "Archive contenant les fixtures Propel d'insertion des régions, départements et communes de France") contenant ces trois fichiers.

Il ne vous reste plus qu'à créer vos listes déroulantes! :)
