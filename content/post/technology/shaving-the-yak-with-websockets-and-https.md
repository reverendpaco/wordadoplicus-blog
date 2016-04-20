+++
date = "2016-04-17T15:28:58Z"
draft = true
title = "shaving the yak with websockets and https"
tags = ["erlang","elixir" ,"docker"] 
image = "elixirAndErlang.png"
categories = ["programming"]
+++

I've always wanted to do a post that provides a concrete example of why it's hard to give estimates.

* needed to add SSL to my web assets
* could not add them just to nginx, as i didn't want the hassle of having the same key on each on each machine on scale-out
* therefore, chose SSL termination
* but had to migrate the websockets code to nginx from haproxy (why? because the SSL forwarding wasn't guaranteed to work)
* but once everything was at nginx, I had no way of knowing what to proxy forward to cowboy (why? because nginx matches on URL, and less so on headers (like haproxy)
* therefore, i had to modify all my urls to be prefixed so that nginx could send them on 
* 
