---
layout: post
title: "Which tool to use to make marketing dashboard?"
description: There is a lot of tool to make beautiful dashboards. But which one is the most adapted for marketing dashboards?
tags: [dashboard, marketing, elk, influxdb, grafana, kibana]
---

## The history

For those who don't know it, I made [a presentation of the ELK
stack](https://www.youtube.com/watch?v=1r1SOeaDqH4) at the PHP Forum in Paris
(in French). During this talk, I mainly talked about our
([BlaBlaCar](http://www.blablacar.com)) technical logs. I also mentioned that
we use ELK to make some marketing dashboards too (signups by country, payments
and so on.) even if I said thaht I don't consider ELK as the best tool to do
this.

Last week Claude Duvernier ([@C_Duv](https://twitter.com/C_Duv)) asked me [on
twitter](https://twitter.com/C_Duv/status/530869087531184129) which tool I
would recommend instead of ELK. This make me think that in fact, ELK is not a
bad choice, even if some others tools exist.

Disclaimer: I'm definitely not aware of all existing tools to make marketing
dashboards. I will talk only about solutions I already used. Sorry if I miss
something important. This article is more my personal feedback regarding some
tools we use than a real comparatif.

## Tools

### ELK

Let me start by the one I probably know the most.  ELK is **very** easy to
setup and to use. You just have to send all important events to logstash or
anything else (in our case, we send it to a RabbitMQ broker) and store them in
ElasticSearch. Kibana will then help you to display all this events.

By design, all elasticsearch queries are made on the fly. ElasticSearch is
"just" a data store and don't aggregate anything. You're able to update your
queries when you want, filter results, etc directly in Kibana which is really
appreciable. The drawback is the time needed to render some graphs for a long
period.

Another point to consider with ELK is the storage needed for all your data. It
can be quite huge depending on what you choose to store and on your retention
policy.

**Pros:**

* Very easy to setup and to install
* Kibana is very easy to use (I didn't try the latest version with aggregations
  support but I'm sure it's even better)

**Cons:**

* Rendering time depends on the interval size
* Storage space needed (sometimes)

### NewRelic

For those who don't know it, NewRelic is an [Application Performance
Management](http://en.wikipedia.org/wiki/Application_performance_management)
(APM). I won't talk a lot about it because even if you **can** make some graphs
based on pages frequentation, it's definitely not the solution to our problem.

I choose to put it in this list only because we use some New Relic dashboards
for technical needs (to check registrations & payments after a deployment for
example) but it can looks like a marketing dashboard.

**Pros:**

* Easy to make some basic dashboards (once you already installed it)

**Cons:**

* Non free
* Very basic
* Can only track pages frequentation
* Not possible to change time aggregation interval

### InfluxDB

Recently introduced at BlaBlaCar, I am fallen in love with [this time series
database](http://influxdb.com/). For now, we use it for code instrumentation
purpose and we only have technical dashboards (and a bunch of issues with
collected data. :P). The latest stable release of InfluxDB is the 0.8.5 and the
cluster support is experimental. Despite all of this, it works well. :) It's
not the goal here so I will not talk about the design of InfluxDB. You are
strongly enouraged to [take a
look](http://influxdb.com/docs/v0.8/introduction/overview.html) at it.

Like ELK, you need to send events with all relevant informations you need.
This time however, you shouldn't query the created serie. You have to create
some [continuous
queries](http://influxdb.com/docs/v0.8/api/continuous_queries.html) in order to
split your data.

For example in our case, we send an event for each http queries. This event
contains the called route and we have a continuous query which create new
series per route and calculate the average response time and memory usage with
an aggregation of 1 minute. Another continuous query make the same, every hour.

To create dashboards with data from InfluxDB, we use
[grafana](http://grafana.org/), a kibana clone which supports InfluxDB,
Graphite and OpenTSDB.  With this system, we always query the same series. It's
**really** fast, even if you display a lot of series on a large period.

**Pros:**

* Really fast to display
* Can store all kinds of events (even system events for example).
* Grafana is as simple as Kibana (maybe more)

**Cons:**

* Harder to setup than an ELK stack
* Need to define all continuous queries to be able to use them after
* Cluster support not ready yet

## Conclusion

I know that there is a lot of others solutions available to create marketing
dashboards. I hesitated to talk about Hadoop / Vertica / Tableau which are also
used at BlaBlaCar for data analysis. However as I don't personally use these
tools, they doesn't fill my initial requirements.

Despite what I told during my talk at ForumPHP Paris, ELK **IS** a very good
choice even more if you already use this stack to analyze your logs and if you
don't need to display a long period for your marketing dashboard.  If you have
more time and want to use a time series database, I recommend you InfluxDB even
if it's a really young software. :)

If you use another tool and think it's THE perfect solution, let me know. :)
