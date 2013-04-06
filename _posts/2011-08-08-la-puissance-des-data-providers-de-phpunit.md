---
layout: post
title: "La puissance des data providers de PHPUnit"
lang: fr
description: La puissance des data providers de PHPUnit
tags: [tests unitaires, phpunit, data providers]
---

A n'en pas douter, vous êtes très certainement de grands fans des **tests unitaires** et, pourquoi pas, de <a href="https://github.com/sebastianbergmann/phpunit/" title="PHPUnit official repository">PHPUnit</a>.

Si vous l'utilisez depuis un certain temps, cet article ne vous apprendra probablement rien (désolé! :P). Dans le cas contraire, vous devriez être heureux (en tout cas, moi, je l'étais! :D)

Il y a de ça quelques semaines, je devait tester un service **symfony2** permettant de vérifier les droits d'un utilisateur sur une entité précise pour une action donnée. Inutile de préciser que l'éventail des possibilités était large! :D

Si comme moi, une subite envie de fuire vous prends à l'idée de devoir écrire tous ces tests à la main, restez! Et admirez:

**SANS** les datas providers:

{% highlight php %}
<?php
class MonTestCase extends WebTestCase
{
    public function testRightsForCreateBusinessWithAdmin() { ... }
    public function testRightsForUpdateBusinessWithAdmin() { ... }
    public function testRightsForDeleteBusinessWithAdmin() { ... }
}
{% endhighlight %}

Nous sommes ici obligés d'écrire chacun de nos tests un par un...

**AVEC** les datas providers:

{% highlight php %}
<?php
class MonTestCase extends WebTestCase
{
    public static function providerRights()
    {
        return array(
            array('create', 'business', 'admin'),
            array('update', 'business', 'admin'),
            array('delete', 'business', 'admin'),
        );
    }

    /**
    * @dataProvider providerRights
    */
    public function testRightsOK($action, $entity, $role) { ... }
}
{% endhighlight %}

Cette fois, **LE** test (oui, il n'y en a plus qu'un! \o/) attends certains **paramètres** qui lui sont fournis par le **data provider** déclaré juste au dessus. Ce comportement est spécifié à PHPUnit via l'utilisation d'une **annotation** toute simple.

De cette manière, le même test sera lancé pour chacune des données renvoyées par notre data provider! :)

Fantastique non?

Moins de code, moins de bugs, moins de maintenance, plus de lisibilité. Bref, que des avantages! :D
Si vous voulez plus d'informations sur les data providers, n'hésitez pas à consulter l'excellente documentation de PHUnit <a href="http://www.phpunit.de/manual/3.5/en/writing-tests-for-phpunit.html#writing-tests-for-phpunit.data-providers" title="Documentation de PHPUnit: les data providers">ici</a>!

(Et encore une fois, merci <a href="http://twitter.com/#!/futurecat" title="@futurecat">@futurecat</a>! :))
