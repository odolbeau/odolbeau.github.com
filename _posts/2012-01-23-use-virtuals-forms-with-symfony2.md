---
layout: post
title: "Use virtuals forms with Symfony2"
description: Use virtuals forms with Symfony2
tags: [symfony2, forms, virtual]
---

<div class="alert alert-info">
This article is now an official <a href="http://www.symfony.com/doc/current/cookbook/form/use_virtuals_forms.html">cookbook</a> since <a href="https://github.com/symfony/symfony-docs/commit/a7781433cf6af9b43f924d2f61525537141d27bf">February 2012</a>.
</div>

_Wait! What? You already write [this]({% post_url 2012-01-09-utiliser-les-forms-virtuals-avec-symfony2 %} "Utiliser les forms virtuals avec Symfony2") before! Oo_

Yes I do! But in french! And it seems it was not very clear... So let me explain virtuals forms again and this time... in english!

We have 2 entities. A Company and a Customer :

<div class="half-left">
{% highlight php %}
<?php

namespace ...;

class Company
{
    private $name;
    private $website;

    private $address;
    private $zipcode;
    private $city;
    private $country;

    // Some nice getters / setters here.
}
{% endhighlight %}
</div>

<div class="half-right">
{% highlight php %}
<?php

namespace ...;

class Customer
{
    private $firstName;
    private $lastName;

    private $address;
    private $zipcode;
    private $city;
    private $country;

    // Some nice getters / setters here.
}
{% endhighlight %}
</div>
<div class="clear"></div>

Like you can see, both of our entities have these fields: `address`, `zipcode`, `city`, `country`.

Now, we want to build 2 forms. One for create/update a Company and the second to create/update a Customer.

Of course, we have only two entities which have to contains some location informations... for now! Maybe later, some entities will have this fields. So, we have to find a solution to not duplicate our code!

First, we create very simple CompanyType and CustomerType:

<div class="half-left">
{% highlight php %}
<?php

namespace ...;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class CompanyType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('name', 'text')
            ->add('website', 'text')
        ;
    }

    public function getDefaultOptions(array $options)
    {
        return array(
            'data_class' => '...\Company',
        );
    }

    public function getName()
    {
        return 'company';
    }
}
{% endhighlight %}
</div>

<div class="half-right">
{% highlight php %}
<?php

namespace ...;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class CustomerType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('firstName', 'text')
            ->add('lastName', 'text')
        ;
    }

    public function getDefaultOptions(array $options)
    {
        return array(
            'data_class' => '...\Customer',
        );
    }

    public function getName()
    {
        return 'customer';
    }
}
{% endhighlight %}
</div>
<div class="clear"></div>

Definitely nothing complicated here.

Now, we have to deal with our four duplicated fields...
Here is a (simple) location FormType:

{% highlight php %}
<?php

namespace ...;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class LocationType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('address', 'textarea')
            ->add('zipcode', 'string')
            ->add('city', 'string')
            ->add('country', 'text')
        ;
    }

    public function getDefaultOptions(array $options)
    {
        return array(
        );
    }

    public function getName()
    {
        return 'location';
    }
}
{% endhighlight %}

We can't specify a data_class option in this FormType because, we don't have a Location Entity.<br />
We don't have a location field in our entity so we can't directly link our LocationType.<br />
Of course, we absolutely want to have a dedicated FormType to deal with location (remember, DRY!)

**There is a solution!**

We can set the option `'virtual' => true` in the `getDefaultOptions` method of our LocationType and directly start use it in our 2 first types.

Look at the result:

<div class="half-left">
{% highlight php %}
<?php
// CompanyType

public function buildForm(FormBuilder $builder, array $options)
{
    $builder->add('foo', new LocationType());
}
{% endhighlight %}
</div>

<div class="half-right">
{% highlight php %}
<?php
// CustomerType

public function buildForm(FormBuilder $builder, array $options)
{
    $builder->add('bar', new LocationType());
}
{% endhighlight %}
</div>
<div class="clear"></div>

With the virtual option set to false (default behavior), the Form Component expect a Foo (or Bar) object or array which contains our four location fields. Of course, we don't have this object/array in our entities and we don't want it!

With the virtual option set to true, the Form Component skip our Foo (or Bar) object or array. So, it directly access to our 4 location fields which are in the parent entity!


(One more time, thank to [Alexandre Salomé](http://alexandre-salome.fr/ "Alexandre Salome website") for the tips)
