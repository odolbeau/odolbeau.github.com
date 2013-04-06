---
layout: old_post
title: "Gérer plusieurs sites avec les virtuals hosts d'Apache"
lang: fr
description: "Gérer plusieurs sites avec les virtuals hosts d'Apache"
tags: [apache, virtual hosts]
---

Vous connaissez certainement déjà les [alias](http://httpd.apache.org/docs/2.0/mod/mod_alias.html#alias "Apache mod_alias"), qui permettent de **gérer plusieurs sites** et qui sont très simple à mettre en place. Mais peut-être n'avez-vous jamais entendu parler des [virtuals hosts d'Apache](http://httpd.apache.org/docs/2.2/en/vhosts/ "Documentation des virtuals hosts d'Apache").

Pour simplifier, les alias permettent **uniquement** de créer un **"lien symbolique"** entre un dossier choisi (par exemple le dossier contenant toutes le sources de phpmyadmin) et votre **serveur web**. Une fois votre alias créé, il vous suffit d'appeler l'URL que vous auriez appelé si le dossier choisi se trouvait **physiquement** à la racine de votre serveur web. (_http://localhost/phpmyadmin_).

Avec les **virtuals hosts**, le fonctionnement est fondamentalement différent. Ici, le but est d'avoir **plusieurs racines** de sites web avec **un seul et unique serveur apache**. L'intérêt? Pouvoir gérer divers sites **indépendamment** les uns des autres, ce qui n'est pas le cas en utilisant les **alias**, puisque cette solution n'utilise qu'**une seule racine**.

Maintenant que vous êtes convaincu de l'intérêt des virtuals hosts (du moins je l'espère), passons à la **configuration d'apache**! :)

La configuration des virtuals hosts se fera dans le fichier `httpd-vhosts.conf` (dossier `/conf/extra` du répertoire d'installation d'apache). Mais avant de commencer, il faut vérfier que ce fichier est bien appelé par le **fichier de configuration principal**, à savoir `httpd.conf` (dossier `/conf` du répertoire d'installation d'apache).

Ouvrez donc ce fichier et vérifiez que la ligne d'include de `httpd-vhosts.conf` est bien décommentée:

{% highlight apacheconf %}
# Virtual hosts
Include conf/extra/httpd-vhosts.conf
{% endhighlight %}

Maintenant, on commence les choses sérieuses en ouvrant le-dit fichier `httpd-vhosts.conf`.

Vous pouvez commencer par supprimer les exemples avant d'ajouter cette ligne **INDISPENSABLE** à votre fichier:

{% highlight apacheconf %}
NameVirtualHost *:80
{% endhighlight %}

Ensuite, voici la configuration pour un virtual host pour le site "monSiteWeb":

{% highlight apacheconf %}
<VirtualHost *:80>
    DocumentRoot "c:/racine/de/monSiteWeb/"
    ServerName local.monsiteweb.fr
    ServerAdmin webmaster@monsiteweb.fr
    ErrorLog logs/local.monsiteweb.fr-error_log
    TransferLog logs/local.monsiteweb.fr-access_log
</VirtualHost>
{% endhighlight %}

Quelques explications:

* **DocumentRoot:** Le chemin d'accès à la racine de votre projet
* **ServerName:** Le nom qui sera utilisé pour accéder au site. Vous pouvez mettre ce que vous souhaitez! Personnellement, j'ai pris l'habitude de mettre "local." suivi du nom du site afin d'être certain que cette URL est bien locale.
* **ServerAdmin _(facultatif)_:** L'adresse mail de l'administrateur du site.
* **ErrorLog _(facultatif)_:** le fichier dans lequel seront stockés les logs d'erreurs de votre site.
* **TransferLog _(facultatif)_:** le fichier dans lequel seront stockés les logs d'accès de votre site.
* D'autres paramètres sont bien entendu disponibles. je vous laisse vous référer à la [documentation officielle](http://httpd.apache.org/docs/2.2/en/vhosts/ "Documentation officiel des virtuals hosts d'Apache") si besoin est.

**Redémarrez** maitenant votre **serveur apache** afin que les changements soient pris en compte.

Votre virtual host est maintenant fonctionnel! Dernière manipulation avant de pouvoir y accéder, **mettre à jour** votre fichier **hosts**!

Ce dernier se trouve:

* pour Windows: `C:\WINDOWS\system32\drivers\etc\hosts`
* pour Linux: `/etc/hosts`

Ajoutez la ligne suivante:

{% highlight apacheconf %}
127.0.0.1     local.monsiteweb.fr
{% endhighlight %}

Cela signifie que **toutes** les requêtes adressées à `local.monsiteweb.fr` seront transférées au serveur `127.0.0.1`, c'est à dire **VOTRE serveur**.

Vous devriez maintenant pouvoir tester votre configuration en vous rendant à l'adresse suivante: _http://local.monsiteweb.fr_

Si vous avez une erreur 404, assurez-vous que votre navigateur a bien pris en compte les modifications effectuées dans le fichier hosts. Pour cela effacer le **cache** et rédemarrez-le.
