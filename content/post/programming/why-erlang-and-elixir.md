+++
date = "2016-04-11T19:28:11Z"
draft = true
title = "why erlang and elixir"
image = "elixirAndErlang.png"
tags = ["erlang","elixir" ] 
+++


I had drawn the following picture while I was at the Elixir Conference down in Austin.  

![iceberg](/images/iceberg.png)

 It displayed my understanding of the power and promise of Elixir, not as a
 brand new language with heretofore unknown features, but as the fulfillment of
 the underlying Erlang technology. And, for those of you who don't quite get
 the metaphor, Elixir is just the tip of the iceberg, as a massive ecosystem of
 Erlang lurks below.

 Neither does this statement indict Erlang as ‘unfulfilled’ nor diminish Elixir
 as merely a technology that rides on the coattails of another.  I have extreme
 respect for the decades of crazy good engineering that have gone into making
 Erlang exactly what it is, and likewise for Jose Valim et all for their
 judicious choices in crafting a new language that embraces and promote  the
 engineering below it.

 I made this drawing to justify to myself why I was investing my time in either technology in order to implement my word-game community.

 Erlang came first.  I chose it years ago, when I first put effort into this side-project with what freetime a consultant in the big data industry could muster.  Erlang’s features are perfectly aligned to the needs I had -- to create a highly concurrent swarm of real-time word-games (primarily boggle-based) that would be robust, that would be sparing with system resources, that would have high-uptime, and that could scale as the needs arose.  

 The semantics of the actor model, wrapped around a dynamically typed functional language with a prolog heritage seemed like just the mental model I needed to force me to design properly from the get-go.  I had been sold on functional years ago.  And so Erlang as a language with a opinionated message-passing semantic seemed a proper investment. 

 As time went on, my understanding of the Erlang ecosystem justified this investment, not just from the semantic but from the years of solid engineering that went into supporting this semantic:  the BEAM virtual machine (with its reductions and preemptive scheduling), the OTP framework (supervisors, server and FSM behaviors), the networking to marshall messages across distributed nodes, and all the other features that both arose from the marriage of functional idioms and the protocol-implementation heritage of Erlang’s telephonic products (pattern matching on binaries!  brilliant!).

 Unlike some others, I have no problem with the Erlang syntax or tooling.  I find the syntax neither weird nor off-putting -- although in my first few weeks of programming, I had to repeat to myself the mantra that “comma mean ‘and-then-do’ while semi-colon means ‘or-do-this-instead’”.  

 Most of my word-game community (primarily the games) are implemented in Erlang, using great libraries like Cowboy for pooling websocket handlers, gproc for knowing where my processes are (and assigning them metadata), and lager.  I have followed all the books and blog posts and have built the back-end engine using OTP concepts (I have supervisors and gen_fsm’s and gen_servers and SASL) and have wrapped everything up using applications and releases, and community.
