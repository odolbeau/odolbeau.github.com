---
layout: post
title: Installation de symfony sous windows
description: Installation de symfony sous windows
tags: [symfony, php, windows, wamp]
---

Voici un petit tutoriel simple et rapide qui vous permettra de préparer votre environnement de travail puis d'installer symfony. Étapes nécessaires avant de pouvoir utiliser cet excellent framework! :)

La procédure d'installation de symfony sur une architecture WAMP ne présente aucune difficulté particulière et peux aisément se réaliser en suivant les instructions de la [documentation officielle](http://www.symfony-project.org/book/1_2/03-Running-Symfony#chapter_03_installing_the_symfony_libraries "Documentation officielle permettant d'installer le framework symfony") du framework symfony ou du [premier chapitre](http://www.symfony-project.org/jobeet/1_2/Propel/en/01#chapter_01_symfony_installation "Premier chapitre du tutoriel Jobeet") de l'excellent tutoriel [Jobeet](http://www.symfony-project.org/jobeet/1_2/ "Tutoriel Jbeet").

Cependant, pour celles et ceux que l'anglais horripile ou qui préfèrent suivre des explications adaptées à leur plateforme, voici les étapes à suivre pour installer le framework symfony.

Seul prérequis avant de démarrer l'installation, assurez-vous d'avoir une version de [WampServer](http://www.wampserver.com/ "Site officiel de WampServer") à jour.

## Première étape: Installation de PEAR

Définition de [Wikipedia](http://fr.wikipedia.org/wiki/PEAR "Définition de PEAR sur Wikipedia") pour [PEAR](http://pear.php.net/ "Site officiel de PEAR"):

> *PEAR* (pour _PHP Extension and Application Repository_) est une collection de bibliothèques PHP. C'est aussi une application qui permet de gérer les bibliothèques (installer ou mettre à jour une bibliothèque).

PEAR va permettre d'installer symfony ([ainsi que de nombreux autres packages](http://pear.php.net/packages.php "Liste des packaches PEAR disponibles")) grâce à une simple ligne de commande.

*MAJ: La manipulation permettant d'installer PEAR dépend maintenant de votre version de WampServer (merci à <a href="http://www.odolbeau.fr/installation-de-symfony-sous-windows/comment-page-1#comment-12">LeoSquall</a> pour la remarque!)*

* **Version 2.0h ou inférieure:**

    Pour installer PEAR, lancez `go-pear.bat` situé dans le dossier `bin/php/php5.x.x` de votre répertoire d'installation de WampServer en utilisant l'invite de commande.

    Ce qui donne dans mon cas:

    {% highlight bash %}
    cd C:\APPS\WampServer\bin\php\php5.2.6
    go-pear.bat
    {% endhighlight %}

* **Version 2.0i ou supérieure:**

    Créez un fichier `script.bat` dans le dossier `bin/php/php5.x.x` de votre répertoire d'installation de WampServer puis copiez-y le code suivant:

    {% highlight bash %}
    php -d phar.require_hash=0 PEAR\go-pear.phar
    {% endhighlight %}

    Exécutez le script en double cliquant dessus ou via l'invite de commande

_MAJ: Vous pouvez continuer de suivre ce tutorial, quelque soit votre version de WampServer! :)_

<div class="img-container-medium alignright">
    <img title="Modification de la variable Path" src="{{ 'images/posts/2009-08-12/variables-environnement.jpg' | asset_url }}" alt="Modification de la variable Path" width="235" height="270" />
    <p class="legend">Modification de la variable Path</p>
</div>

Au cours de l'installation, contentez-vous d'appuyez sur Entrée à chaque nouvelle demande et de répondre par l'affirmative lorsque que le script vous demandera si vous souhaitez qu'il modifie votre fichier php.ini (_Would you like to alter php.ini ?_).

Maintenant que PEAR est installé, il ne reste plus qu'à s'en servir! :) Pour cela il va falloir rajouter une nouvelle variable système. Rien de plus simple:
Clic droit sur le poste de travail -> Propriétés -> Onglet "Avancé" -> Variables système.

Modifiez à présent la variable Path en ajoutant simplement à la fin de la chaine l'adresse du dossier utilisé auparavant (celui dans lequel se situe le script go-pear.bat) précédé d'un point virgule.
Dans mon cas: `; C:\APPS\WampServer\bin\php\php5.2.6`

Fermer l'invite de commande puis ré-ouvrez la afin que les modifications soient prises en compte.

Voilà, PEAR est installé et fonctionnel!

## Deuxième étape: Installation de symfony

Comme expliqué ci-dessus, PEAR va maintenant nous permettre d'installer symfony grâce à une simple ligne de commande! Ou plutôt deux! La première va permettre d'enregistrer un nouveau [channel](http://pear.php.net/channels/ "Liste des channels PEAR") contenant une liste de packages. Une fois ce channel ajouté, il suffit d'installer le package de son choix, en l'occurrence, la dernière version stable de symfony. Voici les commandes:

{% highlight bash %}
pear channel-discover pear.symfony-project.com
{% endhighlight %}

puis

{% highlight bash %}
pear install symfony/symfony
{% endhighlight %}

A présent que symfony est installé, reste à mettre en place un minimum de configuration.

## Troisième étape: Configuration

Afin de faire fonctionner symfony, il faut vérifier et éventuellement modifier votre configuration de php et d'[apache](http://www.apache.org/ "Site officiel d'apache").

### Modification de la configuration de php

Tout d'abord, ouvrez le fichier `php.ini` situé dans le même dossier qu'auparavant. Si vous utilisez WampServer, une fois celui-ci démarré, vous pouvez accéder rapidement au fichier en cliquant (gauche) sur l'icône de WampServer dans la barre des taches, puis PHP -> php.ini.

Dans ce fichier, deux choses à vérifier. Rechercher `memory_limit` et vérifier que la valeur est supérieure ou égale à 16M (`memory_limit = 16M`).

Enfin, si vous utilisez une version inférieure à PHP 5.3, vérifier que les [magic quotes](http://fr2.php.net/magic_quotes "Présentation des magic quotes sur le site php.net") (guillemets magiques) sont désactivés (`magic_quotes_gpc = Off`)

### Modification de la configuration d'apache


Ouvrez maintenant le fichier `httpd.conf` situé dans le dossier `bin/apache/apache2.x.x/conf` du répertoire d'installation de WampServer ou encore une fois, accédez-y via l'icône de WampServer situé dans la barre des tâches (Apache -> httpd.conf)

Vérifiez que le module apache de rewriting, [rewrite_module](http://httpd.apache.org/docs/1.3/mod/mod_rewrite.html "Documentation officiel d'apache: l'extension mod_rewrite") est bien activé (pas de # devant la ligne: `LoadModule rewrite_module modules/mod_rewrite.so`)

N'oubliez pas de redémarrer le serveur apache afin que les modifications soient prises en compte!

Dernière étape, nous devons permettre au serveur apache d'accéder aux images, feuilles de styles et fichier  javascript fournis par symfony et utilisé notamment par l'admin generator, les pages par défaut et la barre de debug.

La solution la plus optimale est d'utiliser un [alias](http://httpd.apache.org/docs/2.2/mod/mod_alias.html "Documentation officielle d'apache: le module alias") apache (plus ou moins l'équivalent d'un [lien symbolique](http://fr.wikipedia.org/wiki/Lien_symbolique "Définition d'un lien symbolique sur Wikipedia") sous unix). Cependant, cette solution dépendant notamment de votre configuration apache existante et de l'utilisation que vous faites de votre serveur (multi-sites, etc) je ne la détaillerai pas dans cet article. Vous trouverez néanmoins un nombre important d'informations dans la [documentation officielle de symfony](http://www.symfony-project.org/book/1_2/03-Running-Symfony#chapter_03_configuring_the_web_server "Documentation officielle de symfony: configurer le serveur web") ou dans celle d'[apache](http://httpd.apache.org/docs/2.2/mod/mod_alias.html "Documentation officielle d'apache: l'extension mod_alias").

Nous allons donc nous contenter d'utiliser la seconde solution. Pour cela, commencez par créer votre projet symfony en suivant les instructions de la [documentation](http://www.symfony-project.org/book/1_2/03-Running-Symfony#chapter_03_setting_up_an_application "Documentation officielle de symfony: mettre en oeuvre une application"), puis copiez/collez l'ensemble des fichiers situés dans le dossier `bin/php/php5.2.6/data/symfony/web/sf` du répertoire d'installation de WampServer dans le répertoire web/sf de votre projet symfony. Cette solution fonctionne parfaitement, néanmoins vous serez obligé de refaire cette manipulation pour chaque projet que vous réaliserez sur votre machine mais également à chaque nouvelle version de symfony que vous utiliserez par la suite.
