---
layout: old_post
title: "SVN: Définition et enjeux"
description: "SVN: Définition et enjeux"
tags: [svn, subversion]
---

Ou comment un serveur SVN (Subversion) peut vous **simplifier le développement** d'un projet collaboratif ou personnel.

J'ai très récemment été surpris lorsque, entouré de six étudiants en **troisième année d'informatique**, ces derniers m'ont avoué de pas savoir ce qu'était un SVN. Voici donc un article qui je l'espère convaincra les plus indécis d'utiliser un SVN pour **tous leurs projets**.

## Qu'est-ce qu'un SVN?

D'abord, qu'est-ce qu'un SVN? Rien de plus simple, il s'agit d'un **gestionnaire de versions**. Pour être plus précis, il s'agit du système de gestion de versions qui succède à **CVS**. Mais fini le cours d'histoire. Concrètement, à quoi ça sert? Comment ça marche? Pourquoi je m'en sers?

## A quoi ça sert?

Et bien ça sert à **gérer les différentes versions des fichiers d'un projet**, tout simplement! :) Cette **sauvegarde** permet de récupérer les anciennes versions d'un fichier, de le restaurer si ce dernier à été supprimé, de le récupérer s'il a été perdu. Bref, sur un serveur SVN, Vous aurez toutes les versions de votre projet que vous aurez envoyez.

Mais là ou l'utilisation d'une serveur SVN prend tout son intérêt, c'est dans le cadre d'un **projet "collaboratif"**. Vous êtes plus de deux à développer un projet? L'utilisation d'un serveur SVN vous permettra de travailler sur la même version de développement, sans vous envoyer les modifications par mail, par clé USB ou par je ne sais quel autre moyen existant! :)

## Comment ça marche?

Très simplement. Il vous faut un serveur SVN et un client SVN. Pour le serveur, vous pouvez bien sur **l'héberger vous-même** sur votre bon vieux linux. Vous pouvez également faire appel au service de **tiers spécialisés** dans ce domaine (ou dans d'autres). Si votre projet est **libre de droits**, vous avez bien entendu <a title="SourceForge" href="http://sourceforge.net/">Sourceforge </a>ou encore <a title="GoogleCode" href="http://code.google.com/intl/fr/">Google Code</a>. Si ce n'est pas le cas, vous pouvez utiliser <a title="XP-Dev" href="http://www.xp-dev.com/">XP-Dev</a> (gratuit et marche parfaitement) ou <a title="Assembla" href="http://www.assembla.com/">Assembla </a>(période d'essai gratuite, non testé mais semble avoir de bons retours).

<div class="img-container-medium alignright">
    <img title="TortoiseSVN intégré dans l'explorateur" src="{{ 'images/posts/2009-12-03/TortoiseSVN-integration-navigateur.png' | asset_url }}" alt="TortoiseSVN intégré dans l'explorateur" width="230" height="315" />
    <p class="legend">TortoiseSVN intégré dans l'explorateur</p>
</div>

Je ne m'attarderai pas sur l'installation du serveur SVN, de nombreux tutos sont disponibles sur le net.

Concernant le logiciel **SVN client** (qui sera donc installé en local) de nombreuses solutions sont encore une fois disponibles. Certainement la plus connue d'entre elles (pour ceux qui utilisent Windows), <a title="TortoiseSVN" href="http://tortoisesvn.tigris.org/">TortoiseSVN</a> est très complet. Une fois installé, TortoiseSVN sera directement **intégré dans l'explorateur**.

Une fois que tout est installé correctement, le fonctionnement est très simple. Lors de la première utilisation, vous devrez faire un **Checkout**, qui vous permettra de récupérer toutes les données présentes sur le SVN et de lier un dossier local au serveur SVN. Par la suite, deux commandes vont seront utiles: **SVN Update** et **SVN Commit**.

La commande **SVN Update mettra à jour votre copie locale du projet** avec celle du serveur SVN.  Cela vous permettra de récupérer les éventuelles modifications faites par vos collaborateurs.

La commande **SVN Commit vous permettra d'envoyer vos modifications sur le serveur SVN**, afin que ces dernières soient accessibles par vos collaborateurs.

## Pourquoi je m'en sers?

Et bien pour toutes les raisons citées précédemment. Dans le cadre d'un **projet collaboratif**, disposer d'un serveur SVN vous épargne tous les habituels transferts de fichier entre les différents participants et vous fait **gagner un temps précieux**.

Dans le cadre d'un **projet personnel**, l'utilisation d'un serveur SVN permet d'avoir continuellement une sauvegarde à jour de votre projet mais vous autorise également à **travailler sur votre projet depuis différents PC**.

Enfin, bien que ce sujet n'ai pas été abordé dans cet article, vous pourrez installer **d'autres solutions** sur votre serveur SVN. Ainsi l'installation de <a title="TRAC" href="http://trac.edgewall.org/">TRAC </a>par exemple, vous permettra de **gérer votre projet** grâce à différents outils tels qu'un **wiki**, un **gestionnaire de bugs**, un **explorateur Subversion**, etc.

Voilà, ce rapide aperçu des avantages d'un serveur SVN s'achève ici. Je ne peux que vous encourager une fois de plus à utiliser un serveur SVN (si ce n'est déjà le cas) pour **tous vos projets**, collaboratifs ou personnels, que vous travailliez sur une ou plusieurs machines, que vous en ayez ou non envie.
