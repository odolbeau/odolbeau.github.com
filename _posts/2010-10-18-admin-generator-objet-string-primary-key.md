---
layout: post
title: "Admin generator: Objet ayant un string en primary key"
description: "Admin generator: Objet ayant un string en primary key"
tags: [symfony, admin generator, primary key, propel]
---

Petite astuce pour ceux qui seraient amenés a utiliser autre chose un **string** comme **clé primaire** d'une table et qui voudrait tout de même utiliser l'<a title="admin generator" href="http://www.odolbeau.fr/tag/admin-generator">admin generator</a> sans obtenir d'erreur...

Il vous suffit simplement de modifier votre fichier routing.yml de manière à préciser la nature de la clé primaire attendue dans les requirements:

{% highlight yaml %}
annonce:
  class: sfPropelRouteCollection
  requirements: { id: \w+ }
  options:
    model: Annonce
    module: annonce
    prefix_path: annonce
    column: id
    with_wildcard_routes: true
{% endhighlight %}

N'oubliez pas de changer le champ soumis à ce prérequis si celui-ci ne s'appelle pas "id" comme dans l'exemple! :)

En espérant que ce <a href="http://www.odolbeau.fr/tag/snippet" title="snippet" >snippet </a>puisse vous servir! ;)
