+++
date = "2016-04-12T15:37:39Z"
draft = true
title = "erlang and elixir feet wet"
tags = ["erlang","elixir" ,"docker"] 
image = "feet-wet.png"
categories = ["programming"]
+++
{{< rule title="Rule 1:">}}
  Get an Elixir Release.  It contains Erlang, but not vice versa.
{{< /rule >}}

  This rule is obvious:  get an Elixir
  release which uses your preferred version of Erlang.  Elixir is built on top
  of Erlang.  It comes with the Erlang run-time system (and components).  It
  needs this underlying Erlang iceberg.  The opposite is not true.  
  
  I could pursue this route without much fuss as my Erlang codebase was small.
  Moreover, I **wanted** to upgrade to the latest Erlang release and was
  willing to migrate to whatever the newest Elixir needed [^0].  Others may be
  constrained by having to stick with an earlier Erlang version that may never
  be capable of supporting an Elixir . [^1]

  To get started, and because I’ve invested some time in learning Docker,
 I downloaded a Docker container with everything pre-built, called
  `trenpixster/elixir`[^2].  For a few weeks, I migrated my Erlang code 
  from my host machine to this container.  Given my
  lack of investment in Erlang releases and relups, I hope to mitigate upgrades
  by using immortal servers and doing blue-green deployments.  Time will tell if this is a wise strategy.
  
{{< note >}}
  The details of my exact environment: 
    
  <ul>
      <li> I am running Erlang OTP version 18.1 and erts 7.1 </li>
      <li> I am using vanilla flavored rebar, (not rebar3). </li>
      <li> My main application has a top-level supervisor, and some gen_servers and a bunch of gen_fsms </li>
      <li> I have not created a formal Erlang release. I have an application that I launch directly from erl, which uses application:ensure_all_started/1 </li>
      <li> I am running my Erlang application from within a Docker container, specifically trenpixster/elixir.  I am using host networking to expose epmd and other ports.  </li>
      <li> I have the following external libraries for my production code usage (there are more, like eper, for development): </li>
     <ul>
        <li> cowboy </li>
        <li> gproc </li>
        <li> lager </li>
        <li>gen_leader</li>
        <li>neotoma</li>
        <li>rfc4627_jsonrpc</li>
     </ul>
  </ul>
{{< /note >}}


 ![architecture](/images/building-erlang.png)

  The above picture shows my standard Erlang application directory structure.  
  All of my source code is in `src` and when `rebar` compiles the application,
  will deposit the beam files into `ebin`.

  I want to get my feet wet.  What is the easiest way for me to adopt a tiny
  bit of Elixir magic?  My thoughts now are to create a simple Elixir module of utility
  functions and make sure that they can be called from my existing code base.

  If I can do this simple thing, I will learn a lot about how these two
  technologies interact.  Accomplishing this should go a long way to figuring out 
  the bookkeeping issues that tend to be an impediment to adoption.  
 
{{< rule title="Rule 2:">}}
  <p>
  Use the Elixir plugin for rebar if you just want to compile some elixir code 
  in an existing Erlang codebase.
  </p>
  
  <p>
  <a href="http://hyperthunk.github.io/rebar-plugin-tutorial/part-1-introducing-rebar-plugins/">http://hyperthunk.github.io/rebar-plugin-tutorial/part-1-introducing-rebar-plugins/</a>
  </p>
{{< /rule >}}

  This rule comes stright from the Elixir documentation, see [here](http://elixir-lang.org/crash-course.html#rebar-integration).
  
  I followed the instructions directly from the [elixir compiling rebar
  plugin](), with only a few modifications which I will mention here for
  completeness:

1. I did not need to add Elixir as a dependency to my project as I was already within the context of a Docker
       container that had Elixir installed.

2. I needed to call `rebar` twice  -- once to fetch and build the
rebar-elixir-plugin, and the second time to use it (I only needed to do this the first time I use it) 

3. Because I did not add Elixir as a **direct** dependency, I had to point my `lib_dirs`
configuration to where I knew the `elixirc` command-line existed within the
Docker container.

In the end, my rebar config file looked like this:
 ![architecture](/images/my-rebar.png)

Upon running `rebar` I was delighted to see a new `.beam` file in my `ebin` directory.

 ![architecture](/images/building-erlang-and-elixir.png)

More importantly, I was able to reference and use this code in my existing Erlang code-base:

```erlang
start(Id) ->                                                                                                 
  start_running_game(Id,'Elixir.SharedGameUtils':create_empty_user_presences()).
```
  
---------

Relevant Blog Articles and References

  * http://hyperthunk.github.io/rebar-plugin-tutorial/part-1-introducing-rebar-plugins/
  * https://github.com/yrashk/rebar_elixir_plugin
  * http://alancastro.org/2010/05/01/erlang-application-management-with-rebar.html
  * http://erlang.org/pipermail/erlang-questions/2012-July/067957.html


  [^0]: I really wanted Erlang Maps.
  [^1]: Sorry.
  [^2]: https://hub.docker.com/r/trenpixster/elixir/
