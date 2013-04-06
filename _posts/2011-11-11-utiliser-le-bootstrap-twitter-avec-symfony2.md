---
layout: old_post
title: "Utiliser le bootstrap twitter avec symfony2"
lang: fr
description: Utiliser le bootstrap twitter avec symfony2
tags: [symfony2, twitter, less, assetic]
---

Je me l'étais promis depuis longtemps, je l'ai enfin fait! Tester un minimum <a href="http://lesscss.org/" alt="Site officiel de Less">Less</a> avec <a href="https://github.com/kriswallsmith/assetic" alt="Repo d'Assetic sur github.">Assetic</a> (tant qu'à faire!).

Et histoire de jeter un petit coup d'oeil sur cet outil magnifique, autant le faire dans les meilleurs conditions. Pour ça, merci twitter et son <a href="http://twitter.github.com/bootstrap/" alt="Page officielle du bootstrap twitter">bootstrap</a>, qui utilise lui aussi Less (avec <a href="http://markdotto.com/bootstrap/" alt="Site officiel de Preboot.less">Preboot.less</a> pour être plus précis).

Première chose à faire, installer less et configurer Assetic dans votre projet sf2. Pour ce faire, vous pouvez suivre l'<a href="http://www.funstaff.ch/2011/08/22/symfony2-assetic-less-et-yui-compressor-installation-sur-mac" alt="Tutoriel d'installation d'Assetic, less et yui compressor pour Symfony2">excellent tuto de Bertrand Zuchuat</a> (qui s'adresse avant tout aux possesseurs de Mac, mais vous devriez pouvoir le suivre sans trop d'adaptations quelque soit votre OS).

Une fois fait, il ne vous reste plus qu'à utiliser le bootstrap twitter.

Ce que devrait être rapide puisque <a href="http://bundles.knplabs.org/fr/phiamo/profil" alt="Profile de phiamo sur bundles.knplabs.org">phiamo</a> et <a href="http://bundles.knplabs.org/fr/hidenorigoto/profil" alt="Profil de hidenorigoto sur bundles.knplabs.org">hidenorigoto</a> ont déjà fait tout le travail pour vous avec le <a href="http://bundles.knplabs.org/fr/phiamo/MopaBootstrapBundle" alt="MopaBootstrapBundle">MopaBootstrapBundle</a>.

Il ne vous reste donc qu'à installer ce bundle en suivant les instructions d'installation et vous pourrez ainsi tirer pleinement profit du bootstrap twitter (y compris dans vos formulaires puisque le style par défaut a été revu et travaillé pour l'occasion!)
