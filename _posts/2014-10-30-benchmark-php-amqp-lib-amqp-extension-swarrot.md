---
layout: post
title: "[Benchmark] PHP amqp-lib VS amqp-ext with Swarrot"
description: Benchmark between PHP amqp-lib and amqp-ext with Swarrot
tags: [php, amqp, broker, swarrot]
---

## The history

Everything start on 7 April 2014. We gave a talk with [Grégoire Pineau (aka
@lyrixx)](https://twitter.com/lyrixx) called "Making asynchronous tasks in PHP"
(slides are available [on
speakerdeck](https://speakerdeck.com/odolbeau/making-asynchronous-tasks-in-php)).

During this talk we trolled about the
[php-amqplib](https://github.com/videlalvaro/php-amqplib) created by [Alavaro
Videla](old_sound) and maintained by [a lot of
users](https://github.com/videlalvaro/php-amqplib/graphs/contributors).

This library is one of the 2 main ways to talk to an amqp broker. The other one
is the [php extension](git@github.com:pdezwart/php-amqp.git).

Anyway, the subject has come back a few days ago [on
twitter](https://twitter.com/oscherler/status/524113790687010816) (conversation
is in French) when [Ölbaum](https://twitter.com/oscherler) asked us if we still
recommend to not use the php-amqplib. Some tweets later, I proposed to make a
small benchmark to compare these 2 ways of talking to a broker. Because
trolling is good but sometimes, having some real arguments is better.

## Environment

* The broker used is [RabbitMQ](http://www.rabbitmq.com/) (v3.3.5).
* I lunched tests on a Mac Book Pro (2,8 GHz Intel Core i7, 16 GB 1600 MHz DDR3
  with OSX 10.10).
* I used PHP 5.6.2.
* I used the last stable version for both the extension (1.4.0) and the library
  (2.4.1).

I chose to use [Swarrot](https://github.com/swarrot/swarrot) to write as few
code as possible for each implementation.

The full project used for this benchmark can be found [on
github](https://github.com/odolbeau/php-amqp-bench). Of course, feel free to
contribute and complete it!

## Results

And now, the results.
Every tests have been launched 3 times.
What you see here is the average time of these 3 launches.

### Publish 1 million messages in a direct exchange

Code [is
here](https://github.com/odolbeau/php-amqp-bench/blob/master/src/Bab/Console/Command/PublishCommand.php)
The concerned queue has been purged before each launch.

    ./bench publish [ext|lib] -m 1000000

#### With the extension

    +-------------+-------------+
    | Duration    |  36 seconds |
    +-------------+-------------+
    | Memory peak | 1.5 MiB     |
    +-------------+-------------+

#### With the library

    +-------------+-------------+
    | Duration    |  46 seconds |
    +-------------+-------------+
    | Memory peak | 2.5 MiB     |
    +-------------+-------------+

#### So what?

The duration difference is pretty small between the extension and the library.
In both case the memory consumption is very stable (I tried with 100, 1k, 10k,
100k messages, the memory consumption is near the same).

### Get 100k messages from a queue (+ ack)

Code [is
here](https://github.com/odolbeau/php-amqp-bench/blob/master/src/Bab/Console/Command/GetCommand.php).

    ./bench get [ext|lib] -m 1000000

#### With the extension

    +-------------+-------------+
    | Duration    |  19 seconds |
    +-------------+-------------+
    | Memory peak | 1.8 MiB     |
    +-------------+-------------+

#### With the library

    +-------------+-------------+
    | Duration    |  43 seconds |
    +-------------+-------------+
    | Memory peak | 2.8 MiB     |
    +-------------+-------------+

#### So what?

For the memory consumption, again, nothing to say. It's low and stable in both
case. To consume messages, the pecl extension is more than 2 times faster than
the library.

## Conclusion

The extension is faster than the library. C is faster than PHP. Is it really
surprising? No! It's not really pertinent to compare 2 tools which obviously
make the same job but have different implementations.

The main difference is the installation. The library is VERY simple to install!
You just have to add `"videlalvaro/php-amqplib": "~2.4"` in your composer.json
and you're done. On the contrary, for the extension, you generally need to
compile the `rabbitmq-c` (an AMQP client in C used by the php extension) which
can be a bit boring.

So, if you already install the extension and if it's not a problem for you, go
for it! Otherwise, don't panic and use the library!

In both case, take a look at [Swarrot](https://github.com/swarrot/swarrot) (and
the [SwarrotBundle](https://github.com/swarrot/SwarrotBundle)) to be able to
change your choice if needed.
