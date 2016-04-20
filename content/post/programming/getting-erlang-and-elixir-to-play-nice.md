+++
date = "2016-04-11T20:25:35Z"
draft = true
title = "part 0: getting erlang and elixir to play nice"
tags = ["erlang","elixir" ] 
image = "elixirAndErlang.png"
categories = ["programming"]
series = ["Elixir and Erlang Together"]
+++


I want to adopt Elixir into my project, but I’ve already implemented most of
what I needed in Erlang.  How do I get these two technologies to work together,
and how do I start implementing relevant functionality in Elixir?

On one hand, there are easy answers --  Elixir can easily call Erlang libraries:

```elixir
:lists.sort [3, 2, 1]
```
and likewise, Erlang can easily call Elixir libraries.

```erlang
'Elixir.String':downcase(Bin)
```

On the other hand, statements like the one above only make sense when tooling
and environment are in place.  Understanding how each of these technology’s runtime
find libraries, implement builds, call each other, etc. are the devil in the
details.   

Here are a set of questions that reflect a more mature consideration:

  1.  Which build tool should I use for a mixed deployment/build? `Mix`? `Rebar`?
     `Rebar3`?
      -  Are there some aspects of these build tools that are not present in
         the other?
      -  Are there “lock-ins” that make going back and forth difficult?
      -  Can they call each other?  A rebar invocation calling a mix task?
         Vice Versa? Does that even make sense?
      -  Are some even appropriate to compare to each other?
  1.  Which runtime command-line should I use?  Iex?  Erl?
      -  Does it make sense to have both?  On a single machine?  Do they
         require different epmds?  Does Elixir even use EPMD (probably)?
      -  What does Iex give me over Erl (aside from allowing me to enter raw
         Elixir syntax)?
  1.  What is the culture and technology solution within the Elixir ecosystem to
     using my favorite Erlang libraries (Dialyzer, Gproc, Redbug) in the way
     I’m used to?
      -  Do I favor downloading a thin wrapper around the above tools?  
      -  Are there even thin-wrappers around these tools?  i.e. is there a
         possible “elixeper” whipped up as a github repository somewhere?
      -  If there are wrappers? Is there a way to detect authority? i.e. this
         is a blessed Elixir wrapper around Dialyzer, and will continue being
         supported by the community?
      -  Do I favor just using directly, and occasionally creating my own
         thin-wrappers?  e.g.. macros/functions in elixir to wrap the gproc’s
         paucity?
  1.  What are my boundaries between using one language and another?  Modules,
     processes, *applications*, nodes/*releases*?  What are the suggested
     boundaries?
  1.  How painful is it to intermix these technologies, so that deciding an
     answer to the above question ‘what are my boundaries?’ becomes more
     relevant to decide up-front?
  1.  How does ExUnit interact with Eunit? Or Common Test?  At all?
  1.  How do the other existing tools, fundamental libraries, work with each
     other?  Exrm, Reltool, Relx, Hex, erlang.mk, systools, lager, SASL, eprof,
     observer, TypEr, PropEr, Cover, pman, percept?  (the listing of these
     things might make you think I’m using all of these, which is far from the
     truth).  
  1.  Can I implement a gen_server in Elixir with a supervisor in Erlang?
     Vice-versa?  Does that even make sense?
  1.  What are implications for creating a DSL from Elixir’s macro system on
     existing Erlang code/modules/gen_fsm?
  1.  How does Elixir launch a script?  I’m using `run_erl` in daemon mode now,
     for its IO. Is that supported by Elixir?
  1.  Does the Elixir tooling use different directory structures than Erlang?
     As it pertains to *applications*, as it pertains to *releases*?
  1.  Can an Elixir *application* be referenced directly from an Erlang release?
      -  Does Elixir piggy-back on the *application* conventions? (like the
         .app in the ebin directory?)
      -  Does Elixir piggy-back on the Erlang release conventions (like
         sys.config)?
      -  What is this Elixir umbrella concept?  It seems to be involved in all
         of this.
  1.  How does Hex wrap these libraries as *applications* or libraries for
     either technology?

  (above, I have italicized the word *application* and *release* when I mean it
  to be understood by its respective formal Erlang definition)

  The answers to the above will be inevitably, **“it depends,”** and **“sure”** and **“maybe”**
  and **“like a champ”**. With the flexibility of both systems, there will be many
  ways to do the same thing, so the answers will have to evolve from my
  particular circumstances.  

  The sheer amount of questions above, shows the mindset of someone like me:

  1. familiar with Erlang, 
  1. desirous of adopting Elixir, but 
  1. utterly new to Elixir (at least insofar as the tooling and frameworks -- the language seems pretty obvious to me).  

  So that’s the point of this post and the rest in this series.  To document
  how to get Erlang and Elixir to work together from the perspective of someone
  already invested in an Erlang codebase and just learning Elixir.  I hope to
  get specific answers to my needs, but also draw larger conclusions that are
  applicable to all.


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




Relevant Blog Articles and References

  * http://nickcanzoneri.com/elixir/erlang/2015/08/03/calling-erlang-code-from-elixir.html
  * http://joearms.github.io/2016/03/13/Calling-Elixir-From_Erlang.html
  * http://elixir-lang.org/crash-course.html#adding-elixir-to-existing-erlang-programs
  * http://elixir-lang.org/crash-course.html
  * https://github.com/yrashk/rebar_elixir_plugin



