+++
date = "2016-04-12T15:37:39Z"
draft = true
title = "erlang and elixir feet wet"
tags = ["erlang","elixir" ] 
image = "elixirAndErlang.png"
+++
{{< rule title="Rule 1:">}}
  Get an Elixir Release.  It contains Erlang, but not Vice Versa
{{< /rule >}}

  I think I’ll just leap in and state what I think is obvious:  get an Elixir
  release that uses your preferred version of Erlang.  Elixir is built on top
  of Erlang.  It comes with the Erlang run-time system (and components).  It
  needs this underlying Erlang iceberg.  The opposite is not true.   My
  particular circumstances allowed me to choose this route, as my Erlang
  codebase was small and I was desirous of upgrading to the latest and greatest
  Erlang release and was willing to migrate (I’m looking at you Erlang maps).
  Others may be constrained by having to stick with an earlier Erlang version
  that might not have an Elixir runtime atop. [^1]

  To get myself started, and because I’m a fan of the containerization
  movement, I downloaded a Docker container with everything pre-built, called
  `trenpixster/elixir`[^2].  For the past four months, I’ve moved my Erlang code over
  from being compiled or run by erlc or erl on my host machine, and have
  ensured that everything runs (via volumes) inside the container.  Given my
  lack of investment in Erlang releases and relups, I hope to mitigate upgrades
  by using immortal servers and doing blue-green deployments.  Time will tell.
  To emphasize a point, I am using this container to run Erlang code, and have
  not yet used Elixir code.  

  I want to get my feet wet.  What is the easiest way for me to adopt a tiny
  bit of Elixir magic?  My thoughts:  create a simple Elixir module of utility
  functions and 




  What are my relevant borders?  I think this question is a huge one to think
  about as you consider doing a mixed development model.  Am I implementing
  non-process modules in one of these languages and calling them?  This might
  be the easiest way to get our feet wet.  We aren’t worrying about .
  
  Rule 2:   Decide Which is the Launching Technology?  
  
  Which process starts your application:  iex or erl?  Does it matter?  

  Rule 3:  Think about Rule 2 from Different Nodes

  [^1]: Sorry.
  [^2]: [https://hub.docker.com/r/trenpixster/elixir/]
