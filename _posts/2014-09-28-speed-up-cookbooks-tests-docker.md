---
layout: post
title: "Speed up your cookbooks tests with docker"
description: How you can use docker to accelerate your serverspec tests
tags: [chef, cookbook, tests, docker, kitchen, serverspec]
---

If you're not familiar with [chef](https://www.getchef.com/), a configuration
management tool (like Puppet or Ansible for example) you should probably [click
here](https://learn.getchef.com/) and learn how to use it. :)

If you're not familiar with [docker](https://www.docker.com/) it's not a
problem! You just need to [install
it](https://docs.docker.com/installation/#installation) and to continue
reading. :)

For those who already use chef, I'm sur you write a lot of tests to check your
cookbooks isn't it? :) And you know that it can take a (very) long time to run
the full test suite on different VM.

But don't worry, from now on, it's over! Look at
[kitchen-docker](https://github.com/portertech/kitchen-docker).

Just add `kitchen-docker` in your `Gemfile` (or install it directly with `gem
install kitchen-docker`) and you can now start to use docker instead of
Vagrant. \o/ Just replace you're current driver in `.kitchen.yml`:

{% highlight yaml %}
driver:
  name: docker
{% endhighlight %}

If you use docker on a Mac (with
[boot2docker](https://github.com/boot2docker/boot2docker)) or inside another
machine, you also need to change the socket used by the docker daemon :

{% highlight yaml %}
platforms:
- name: ubuntu-12.04
  driver_config:
    socket: tcp://docker.example.com:4242
{% endhighlight %}

And that's all, you can now launch `kitchen test` and see the result. :)

On some cookbooks used at [BlaBlaCar](http://www.blablacar.com), running the
full test suite is near 60% quicker than before.

Of course, it's not the perfect solution and there is some drawbacks. For
example :
* the `cron` service is not automatically launched
* on my local environment (mac), when chef change the DNS used in your docker,
  some tests fails.
* some of our tests need a VM with more than 1 disk. Not possible with docker.

Apart from this problems, we save time everyday. \o/
