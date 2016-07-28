+++
date = "2016-05-23T11:36:29-04:00"
title = "Wordadoplicus Site Architecture"
image = "architecture-cover.png"
author = "Daniel Eklund"
tags = ["s3","cloudfront","cdn","rds","discourse","dns","ssl","hugo"]
categories = ["architecture"]


+++

I'm often asked how Wordadoplicus was architected.
I could talk for days on end about the choice of
Erlang/Elixir/Haskell and Javascript to code the application itelf, but I hope to
use this post as a high-level description of the operational and foundational
components upon which the entire system sits.

What is better than a picture?
# Overall Architecture
 ![architecture](/images/architecture.png)

I put together this picture to remind me of how the outsite world's view of
Wordadoplicus (i.e. DNS and IP addresses) ultimately maps to the architectural
components.  On the left are the DNS and IP addresses and on the right, the
various components.  As is evident, the entire deployment stack exists in 
Amazon's AWS public cloud.  

I will go into detail next, but the main thing to note at this point is that there
are three different subdomains:
  
  * [ wordadoplicus.com ](https://wordadoplicus.com)
  * [ blog.wordadoplicus.com](https://blog.wordadoplicus.com)   (i.e. where you are right now)
  * [forum.wordadoplicus.com](https://forum.wordadoplicus.com)

that all serve different purposes and are all built on different technologies.

# Blog Site

The site you are reading now is a 99% static site (the 1% is the embedded
comments section at the bottom).  For something like a blog site, I see zero
need to involve a CPU for each and every HTTP request beyond that necessary to fetch
the pre-generated HTML assets.  This is the way the web was meant to be.  I did
some searching and chose Hugo as my generator. 

This is probably the least exciting thing about the overall architecture, but I am
glad to have chosen the appropriate technology for the appropriate need.

 ![architecture](/images/architecture-hugo.png)
As you see above, the actualy assets are hosted in an Amazon S3 bucket for
fractional pennies on the dollar.  I have built a VM image wrapped around a Git
repository ( https://github.com/reverendpaco/wordadoplicus-blog ) that downloads and installs Hugo, 
and the AWS S3 command line library. 

Quicker than you can say ```parcheesi```, I can modify markdown files, generate a new static document-site,
and rsync them to my S3 bucket, thus updating [ blog.wordadoplicus.com](https://blog.wordadoplicus.com) .
# Forum Site
 ![architecture](/images/architecture-discourse.png) 

The forum is crucial for
the overall business needs of Wordadoplicus, which is 1/2 a game site, and 1/2
a community.  I thought a lot about developing the community aspect from
scratch, but always felt overwhelmed with the difficulties in re-inventing the
wheel.  Like a bolt from the blue, the thought occured to me: why not use a
pre-existing forum software?  And thus my discovery of Discourse. 

The image above shows other components engaged with Discourse.  These are 

  * RDS (the Postgres database that hosts all the data),
  * Elasticache (the Redis in-memory cache that Discourse uses to cache pre-generated views),
  * CloudFront (Amazon's CDN that geographically distributes many of the forum's static assets)
  * SES (*Not Shown*) (Amazon's Simple Email Service)

This configuration is a twist to the "out-of-the-box" recommendation for downloading and 
installing Discourse, which generally has the components built into its Docker image and recommends
deploying on DigitalOcean. As I had already been deployed on Amazon with the game site (next section),
I decided to modify my deployment with Amazon and not DigitalOcean. 

I followed [this excellent step-by-step](http://stroupaloop.com/blog/discourse-setup-using-aws/) guide 
for deploying Discourse in Amazon with the above components, and it mostly worked modulo some
VPC idiosyncracies.

# Game Site
The game site is where I poured all my *original* work (i.e. where I coded functionality from scratch).  
 ![architecture](/images/architecture-gamesite.png)
As you can see, there is one server (dockerized) that has Erlang/Elixir,
Haskell, a webserver, and many other components.  This is https://wordadoplicus.com,  the
main game site.  This is the
server that hosts an OpenResty Nginx webserver that serves
static HTML assets that open websockets to talk to the Erlang/Elixir game
server.

In the traditional sense, there is no *application server* because there is no
computation or dynamic computation of HTML per HTTP request.  Instead, the user
gets a fixed HTML asset (chocked full with javascript) that knows how to react
to messages/events from the back-end and paint itself dynamically.  This was a
foundational choice.  Along with the use of Erlang/Elixir in the back-end, I
purposefully chose design strategies and technologies that were designed to be scalable and
low-latency.  

By the way, if you don't think Erlang/Elixir is worth it for buliding highly-scalable systems, then 
you should [ talk](http://highscalability.com/blog/2014/2/26/the-whatsapp-architecture-facebook-bought-for-19-billion.html) [to](https://vimeo.com/44312354) [these](http://www.wired.com/2015/09/whatsapp-serves-900-million-users-50-engineers/) guys.

## Components
As I mentioned above, there are many components on my server.  I use Vagrant and Docker
to provide a "cattle-not-pet" approach to development and deployment.  To
keep myself honest, I will, usually once every two days, destroy my development environment
and start it from scratch from my git repository.  I have scripted everything to
start with a simple invocation of ```vagrant up```.
 ![architecture](/images/architecture-components.png)

The components that launch within this machine are:

* OpenResty Nginx for serving static assets (and some ocassional Lua pre-fetch calls to session management)
* HAProxy for SSL termination and to account for future load-balancing to many erlang nodes
* an Elixir/Erlang docker container that runs the various components (EMPD and my Erlang/Elixir node) that run the actual games
* a Haskell call-on-demand docker image with my code for generating new randomized boards according to a mini-DSL board template I can parse using Parsec
* Ubuntu, because.. Linux
* a Postgres Docker container for development, appropriately configured and seeded to match the RDS deployment database

As most of these components are isolated in their own Docker container, I have given myself the flexibility to spin
up different virtual machines to host these components separately.  Currently, my deployment has them all on one
Amazon EC2 instance (a medium sized one at that), but any future response to heavy traffic will definitely split these 
components into instances with more appropriate resources.


## Interacting with other Architectural Systems
The last thing I'll say about the Game Site, is that there is a lot of code that interacts with the Discourse system. 
I had mentioned previously that Wordadoplicus is equally a gaming site and a community site.  To understand why, [read the origin story](/post/community-and-ethos/orgin-story/).  By choosing Discourse I hoped to not have to re-invent the wheel when it came to that functionality
needed for a forum and a community:  emailing, user management, posting, IP blocking, reporting, ACL, metrics, etc, etc, etc.

On the other hand, the gaming site absolutely needs the notion of user identity that has to be tied into the forum's
user system.  This integration, primarily through Discourse's ability to treat itself as an SSO authority, has allowed
me to piggy-back the gaming site on the forum's user management.  If you register/login/logout on the forum, you have
done the same (via SSO cookie magic) on the game site.   

This is not an easy marriage, as Discourse does not treat this scenario as a common one, so a few patches were needed to 
get me to a place where it could work even minimally. Despite the SSO integration, I have needs to reach into the 
Discourse database, and plan on developing the game site schema alongside the Discourse forum schema.

# Conclusion
There is no conclusion.  I hope you enjoyed this high-level description.

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

