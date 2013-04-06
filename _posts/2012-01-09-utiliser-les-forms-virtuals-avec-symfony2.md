---
layout: post
title: Utiliser les forms virtuals avec Symfony2
description: Utiliser les forms virtuals avec Symfony2
tags: [symfony2, forms, virtual]
---

<p>2012 commence tout juste (à ce propos, bonne année!) et commence plutôt bien!</p>

<p>J'ai été amené, il y a quelques jours, à utiliser <b>l'attribut virtual du composant Form de symfony2</b>. Le besoin était on ne peut plus simple: Créer un FormType adapté à nos besoins pour afficher un formulaire d'adresse. Ce dernier devant bien entendu être utilisé au sein de plusieurs entités disposant déjà des propriétés à éditer (address, city, zipcode, ...) et de leur getter / setters associés.<br />
Partant de ce constat, <a href="http://alexandre-salome.fr/" alt="Site web d'Alexandre Salome">Alexandre Salomé</a> m'a proposé de créer un <b>FormType "virtual"</b>! Lorsque cet attribut est passé à true, le FormType créé utilisera les propriétés de l'objet parent!<br />
Mais un exemple concret sera sans aucun doute bien plus parlant!</p>

<p>Nous avons donc une entité contenant entres autres, différents champs d'adresse:</p>

{% highlight php %}
<?php

namespace ...;

class Company
{
    private $name;
    private $address;
    private $city;

    public function getName()
    {
        return $this->name;
    }
    public function setName($name)
    {
        $this->name = $name;
    }

    public function getAddress()
    {
        return $this->address;
    }
    public function setAddress($address)
    {
        $this->address = $address;
    }

    public function getCity()
    {
        return $this->city;
    }
    public function setCity($city)
    {
        $this->city = $city;
    }
}
{% endhighlight %}

<p>On se contentera ici de trois propriétés seulement (dont une qui ne nous sera pas utile pour notre FormType).</p>

<p>Passons à notre FormType:</p>

{% highlight php %}
<?php

namespace ...;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class LocalisationType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('address', 'textarea')
            ->add('city', 'text')
        ;
    }

    public function getDefaultOptions(array $options)
    {
        return array(
            'virtual' => true
        );
    }

    public function getName()
    {
        return 'localisation';
    }
}
{% endhighlight %}

<p>Notez l'utilisation de l'option "virtual".<br />
Lors du bind de votre formulaire, notre FormType étant virtuel, ce sont les propriétés de notre objet parent (ici Company) qui seront mis à jour par le PropertyPath.</p>

<p>Bien entendu, il s'agit d'un FormType extrèmement basique! Vous souhaiterez prabablement ajouter quelques champs supplémentaires...</p>

<p>Dernière chose, n'héitez pas à passer les noms des champs qui composent votre adresse en option au FormType Localisation de manière à être plus souple.</p>
