---
layout: post
title: "Symfony2 cache warmer"
description: Use Symfony2 cache warmers
tags: [symfony2, cache, file, cachewarmer]
---

For this first post since 6 months, let me introduce to you the CacheWarmer class.

## Cache warmer? What is this?

A cache warmer is just a class that writes in a file to store data. Really simple.

Look into you're `app/cache` directory. Here is an example of what you can find:

 - Global configuration
 - Translations
 - Assetic configuration
 - Doctrine proxies classes
 - Twig compiled templates
 - ...

Lot of things, created by cache warmers.

## How to use cache warmer?

Juste create a file that extend the [CacheWarmerInterface](https://github.com/symfony/symfony/blob/master/src/Symfony/Component/HttpKernel/CacheWarmer/CacheWarmerInterface.php "CacheWarmerInterface definition") provided by the HttpKernel Component.

{% highlight php %}
<?php

use Symfony\Component\HttpKernel\CacheWarmer\CacheWarmerInterface;

class MyCustomeCacheWarmer implements CacheWarmerInterface
{
    public function warmUp($cacheDir)
    {
        // Create a file here
        // Write in it
    }

    public function isOptional()
    {
        // By default, all CacheWarmer are called by the `app/console cache:warmup` command.
        // But you can specify the `--no-optional-warmers` to skip non optional ones.
        return false;
    }
}
{% endhighlight %}

For the implementation, you can take a look at the [TemplatePathsCacheWarmer](https://github.com/symfony/symfony/blob/master/src/Symfony/Bundle/FrameworkBundle/CacheWarmer/TemplatePathsCacheWarmer.php "Symfony2 TemplatePathsCacheWarmer") for example.

Of course, you have to declare your CacheWarmer as a service. Do not forget to tag it with `kernel.cache_warmer`:

{% highlight xml %}
<service id="my_custom.cache_warmer" class="path/to/MyCustomCacheWarmer">
    <tag name="kernel.cache_warmer" />
</service>
{% endhighlight %}

Now, if you run the command `app/console cache:warmup` (or `app/console cache:clear` without the `--no-warmup` option) your cache file should be created. (Search it in the `app/cache/` folder).

To use your cached data, it's very simple. Look at [TemplateLocator](https://github.com/symfony/symfony/blob/master/src/Symfony/Bundle/FrameworkBundle/Templating/Loader/TemplateLocator.php "Symfony TemplateLocator").

The `TemplateLocator` simply require the cached file and store the result into a var. To do the same thing, simply store a return statement in your file. For example, the `app/cache/dev/templates.php` file looks like this:

{% highlight php %}
<?php return array (
    'template_name' => 'path/to/template',
    // ...
),
{% endhighlight %}

You're done. You can now use your custom CacheWarmer in your application. :)
