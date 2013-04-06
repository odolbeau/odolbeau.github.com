---
layout: post
title: "HTML5: Désactiver la validation de vos forms"
lang: fr
description: "HTML5: Désactiver la validation de vos forms"
tags: [symfony2, html5, validation, form]
---

Comme vous le savez certainement, les navigateurs récents vous offrent la possibilité de valider vos champs de formulaires pour peu que vous utilisiez <a href="http://www.w3.org/TR/html5/forms.html#forms">les nouvelles directives HTML5</a> dédiées à la validation.

Ces nouveaux attributs vous permettent d'avoir une validation côté client. Votre formulaire ne sera donc pas envoyé si des erreurs sont détectées par le navigateur. Difficile de tester vos messages d'erreurs dans ces conditions!

Heureusement, ces nouveaux attributs ont un maître! Il suffit d'un seul pour les dominer tous: <a href="http://www.w3.org/TR/html5/forms.html#the-form-element">l'atribut **novalidate** de la balise form</a>!

Avec lui, plus de validation côté client! Vous pouvez à nouveau tester vos formulaires et vos messages d'erreurs comme il se doit! (bien entendu, n'oubliez pas de l'enlever une fois vos tests terminés! \o/)

Et on remercie tous <a href="http://twitter.com/#!/futurecat">@futurecat</a> pour cette astuce tout bête qui nous sauve la vie! (c'était <a href="http://twitter.com/#!/futurecat/status/90066313304739840">ici</a>)
