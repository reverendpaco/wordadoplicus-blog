+++
date = "2016-05-23T11:36:29-04:00"
title = "Wordadoplicus Site Architecture"
image = "architecture-cover.png"
author = "Daniel Eklund"
tags = ["s3","cloudfront","cdn","rds","discourse","dns","ssl","hugo"]
categories = ["architecture"]


+++

I'm often asked how I put together Wordadoplicus from an architecture
perspective.  I could talk for days on end about the choice of
Erlang/Elixir/Haskell and Javascript to code the newest stuff, but I hope to
use this post as a high-level description of the operational and foundational
components upon which the entire system sits.

What is better than a picture?
# Overall Architecture
 ![architecture](/images/architecture.png)

I put together this picture to remind me of how the outsite world's view of
Wordadoplicus (i.e. DNS and IP addresses) ultimately maps to the architectural
components.  On the left are the DNS and IP addresses and on the right, the
various components.

I will go into detail next, but the main thing to note at this point is that there
are three different subdomains:
  
  * [ wordadoplicus.com ](https://wordadoplicus.com)
  * [ blog.wordadoplicus.com](https://blog.wordadoplicus.com)   (i.e. where you are right now)
  * [forum.wordadoplicus.com](https://forum.wordadoplicus.com)

that all serve different purposes and are all built on different technologies.

# Blog Site

The site you are reading now is a 99% static site (the 1% is the embedded
comments section at the bottom).  For something like a blog site, I see zero
need to involve a CPU for each and every request beyond that necessary to fetch
the pre-generated HTML assets.  This is the way the web was meant to be.  I did
some searching and chose Hugo as my generator. 

 ![architecture](/images/architecture-hugo.png)
As you see above, the actualy assets are hosted in an Amazon S3 bucket for
fractional pennies on the dollar.  I have built a VM image wrapped around a Git
repository ( https://github.com/reverendpaco/wordadoplicus-blog ) that downloads and installs Hugo, 
and the AWS S3 command line library. 

Quicker than you can say "parcheesi," I can modify markdown files, generate a new static document-site,
and rsync them to my S3 buckets, thus updating [ blog.wordadoplicus.com](https://blog.wordadoplicus.com) .

# Forum Site
 ![architecture](/images/architecture-discourse.png)
The forum is crucial for the overall business needs of Wordadoplicus, which is 1/2 a game site, and 1/2 a community.  I thought a lot about developing the community aspect from scratch, but always felt overwhelmed with the difficulties in re-inventing the wheel.  Like a bolt from the blue, the thought occured to me: why not use a pre-existing forum software?  And thus my discovery of Discourse. 

# Game Site
The game site is where I poured all my *original* work (i.e. where I coded functionality from scratch).  
 ![architecture](/images/architecture-gamesite.png)
As you can see, there is one server (dockerized) that has Erlang/Elixir, Haskell, a webserver, etc.  This is https://wordadoplicus.com.  This is the server that hosts an OpenResty Nginx webserver that is mainly used to server static HTML assets that then use websockets to talk to the Erlang/Elixir game server.

In the semi-traditional sense, there is no *application server* because there is no
computation or dynamic computation of HTML per HTTP request.  Instead, the user
gets a fixed HTML asset (chocked full with javascript) that knows how to react
to messages/events from the back-end and paint itself dynamically.  This was a
foundational choice.  Along with the use of Erlang/Elixir in the back-end, I
purposefully chose design strategies and technologies that were designed to be scalable and
low-latency.  

By the way, if you don't think Erlang/Elixir is worth it for buliding highly-scalable systems, then 
you should [ talk](http://highscalability.com/blog/2014/2/26/the-whatsapp-architecture-facebook-bought-for-19-billion.html) [to](https://vimeo.com/44312354) [these](http://www.wired.com/2015/09/whatsapp-serves-900-million-users-50-engineers/) guys.




<div id='discourse-comments'></div>

<script type="text/javascript">
  DiscourseEmbed = { discourseUrl: 'https://forum.wordadoplicus.com/',
                     topicId: 102 };

  (function() {
    var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
    d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
  })();
</script>

