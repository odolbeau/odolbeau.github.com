---
layout: post
title: "When Monolog meet ELK"
description: How to use Monolog to send all application logs to an ELK stack
tags: [symfony2, monolog, elk, elasticsearch, logstash, kibana, log]
---

For this first article since 2 years (I know, it was long, did I miss you ? :D)
I'm going to talk about Monolog, Gelf and ELK. It's just a quick introduction
but you will find a lot of resources in this article.

## Monolog

I'm sure you already know [Monolog](https://github.com/Seldaek/monolog), the
(almost) perfect logging library for PHP. :)

I strongly suggest you to read the [core
concepts](https://github.com/Seldaek/monolog#core-concepts) of Monolog if
you're not familiar with channels, handlers and processors. In 2 words, channel
is the name of the logger, handlers are its outputs and processors are here to
add extra information in your logs.

As we will see at the end of this article, you can make really interresting
filters with your channels and the extra data added by your processors.

## Gelf

[Gelf](http://graylog2.org/gelf) means Graylog Extended Log Format. This new
format have been created by Graylog to avoid all syslog inconvenients like the
length limit and the lack of data types and compression.

Gelf messages can be sent by UDP (fortunately !) and of course, the awesome
Monolog provide a
[GelfHandler](https://github.com/Seldaek/monolog/blob/master/src/Monolog/Handler/GelfHandler.php).

Here is an example of a gelf message (can be found [in the
specs](http://graylog2.org/gelf#specs)) :

{% highlight json %}
{
  "version": "1.1",
  "host": "example.org",
  "short_message": "A short message that helps you identify what is going on",
  "full_message": "Backtrace here\n\nmore stuff",
  "timestamp": 1385053862.3072,
  "level": 1,
  "_user_id": 9001,
  "_some_info": "foo",
  "_some_env_var": "bar"
}
{% endhighlight %}

As describe in the specs, some informations are mandatory (but don't worry
about it, just let Monolog deal with it) and you can add as many informations
as you wish.

## ELK

ELK is an acronym for [ElasticSearch](http://www.elasticsearch.org/) /
[Logstash](http://logstash.net/) /
[Kibana](http://www.elasticsearch.org/overview/kibana/).

### ElasticSearch

ElasticSearch is a very powerful distributed search engine which use a RESTful
API. In the ELK stack, ElasticSearch is the storage backend. All our logs will
be stored insite an index.

### Logstash

Logstash have been created to manage logs. It collect, parse and store them.
There is a lot of existing inputs (41), filters (50) and outputs (55). For
example, look at this configuration file :

{% highlight json %}
input {
    gelf {
        type => gelf
    }
}

output {
  elasticsearch_http {
    host => "http://mylogstash"
    port => 9200
  }
}
{% endhighlight %}

We have configured a single input which is gelf. As we saw it, by default, gelf
logs are sent in UDP on port 12201a nd of course, logstash know it.

There is no filter in this configuraton as we don't really need it for this
example. By the way, the gelf message will be directly sent to elasticsearch.

And finally, there is an elasticsearch_http output. So, logstash will call the
ElasticSearch API to insert logs into a generated index per day.

You can take a look at the full documentation for the [gelf
input](http://logstash.net/docs/1.4.2/inputs/gelf) and the [elasticsearch_http
output](http://logstash.net/docs/1.4.2/outputs/elasticsearch_http) to have more
informations.

### Kibana

Kibana is a very powerful tool to see and interact with your data. It's very
easy to use and you can create a lot of dashboards to visualize all your logs.
Take a look at the [project
homepage](http://www.elasticsearch.org/overview/kibana/) to see some example.

## Tips

### Create dashboards for everything !

Is there a particular error in your production environment ? Create a dashboard
just for it ! You will have all available informations in the same place, it
will be easier to aggregate informations and understand when it's occurred.

### Context is your friend bro !

Of course, you all know
[PSR-3](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md),
which defined a standard `PSR\Log\LoggerInterface` (used by Monolog obviously).
But did you read the ["Context"
section](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md#13-context)
? Did you notice thaht all methods defined in the interface take an `$context`
array as second argument ? Do you use it ? No ? You have to !

This context is the best way to provide more information with your log. You can
easily add all needed informations to know WHEN an error (for example)
occurred. And once you send all this context to the ELK stack, you can easily
filter your logs according to the context. Does this error occurred every time
with the same user ? is it only when this particular entity ? Anyway, just add
context and you will be able to group your logs according to it. :)
