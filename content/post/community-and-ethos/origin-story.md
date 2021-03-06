+++
date = "2016-04-12T21:24:39Z"
title = "Origin Story"
image = "OriginStory.png"
categories = ["community-and-ethos"]
series = ["Origin Story and Concept Pitch"]
tags = ["yahoo","word racer","games"]
+++

In the year 2000 I traveled to work and live in the city of Hyderabad, India for
six months.  I had friends back in the USA and almost every day we would meet
on Yahoo's IM and play Word Racer (now defunct). It was my way of
alleviating the culture shock as I adjusted to the day-to-day realities of living in a foreign country.  
This post is not a coming of age story, as I came awake to the size, beauty and complexity of the world, but
about that game:  Yahoo Word Racer.

# Word Racer Rules
The premise of the game was simple. You played a boggle-like game on four
separate boards that lasted two minutes each. At the end, whoever scored the
most points wond.  Points were rewarded for the sheer number and length of the
words you found.
Here is a screenshot of the third board.
 
 ![word racer board](/images/wordracerboard.png)

The game was **real-time** and so the first person to find a word would claim
that word, and others could only watch in dismay if they keyed in the same word
milliseconds later.

Here is a youtube of someone playing to prove that he was not a Bot -- ocassionally there were people whose
typing skills and pattern detection were so formidable that others would accuse
them of cheating, and they would go to lengths like this to maintain their honor (and brag).

{{< youtube CKkMxoXQMIo >}}

Cool, ya?

The game was classic late 90's applet:  aesthetics fixed in Sun Microsystem's
JWT ugliness, and heavyweight to download.  Ironically, however, it was also
much more functionally fleshed out than 1) HTML games because an applet could use sockets to
communicate back to the server to give the requisite responsiveness, and 2) flash
games which were a little less lacking in the security sandbox.

Yahoo Word Racer was an addictive game.  It included scrabble rules into the mix, with
word length still determining score, but special tile-multipliers like scrabble that
could multiply the score by two (blue) or red (three).  In contrast to boggle which 
was **blinded** in regards to finding the words (i.e. players were blinded to other players
disovery of the same words which could be made concurrently but independently), 
Word Racer was **first-come first-serve**.

During the 2000's I would log into games.yahoo.com to see my close friends playing but also tens 
of thousands of addicted Yahoo players hangin out in the social lounges.

# Variations
But as with many other games, the rules became a source of speculation for those of us so addicted.
Inevitably, the tribal psyche invented variations, and it is in *this idea*, of variations, that the 
origin story of Wordadoplicus starts.
  <img class="half-size" src="/images/OriginStory.png"/>

We used to play a variation of Word Racer called "Threes". This variation used
the exact same applet and the exact same four boards, but the players agreed
amongst themselves that the game was to be played under a different set of
rules.  And the rules?  **Exactly the same except that you were limited to only
three words per board.**
  <img class="quarter-size" src="/images/originstory-threefingers.png"/>

With this simple honor-based, human-protocol enforced variation, we had created
an entirely different game.  "Threes" was a game for more strategic thinkers
and less for the red-bull-fueled typing demons.  Since scores of the words were
length based, spending your two minutes thinking hard on each of the four boards to
find the longest possible word before typing fast was critical.  Tactically, you didn't
want to type a long word immediately because 1) you showed your hand and someone 
could find a bigger word based on the cognate (i.e. let's say you typed ```states``` for 70 points, but because
of your discovery your competitor sees the word ```estates``` and ```testates``` for 110 and 150 points
repsectively -- shame on you! ), and 2) you might see a bigger word later.

{{< note >}}
 I might as well give you a link to play this game, so that you can see what I'm talking about.  
<br/>
<br/>
I implemented a four-board, real-time,
non-blinded word game at the Wordadoplicus site.  It is called "Velociracers Three" and
runs in your browser with no installs. 
You can play it <a href="https://wordadoplicus.com/games/multiplayer/competitive/realtime/s/theVelociracersThree/spawn"> here</a>.
 
<br/>
<br/>
I also re-implementend Word Racer (but with slightly different boards and more configuration) 
and called it Velociracer. You can play it <a href="https://wordadoplicus.com/games/multiplayer/competitive/realtime/s/theVelociracers/spawn"> here</a>.

<br/>
<br/>
Both of these games are fully functional games that can be played real-time against anyone else in the world.
The problem, (as of this blog post's writing), is getting someone else in the world to play against you.  It's really
quite simple, if they have the URL, so if you have someone on IM, just copy the URL at the top of the game
and give it to them. 
  <img src="/images/originstory-url.png"/>
 They should appear and you can play against them.  Otherwise just play yourself
to see how the game goes.


{{< /note >}}


But as I mentioned above, the game didn't enforce these rules. It was honor-based,
and inevitably would cause confusion if an outsider joined our game and we 
had to kick him/her out for violating the rules. Or less confrontationally, if one
of us made a mistake and accidentally typed a fourth word, we would have to subtract the 
score at the end.  Why couldn't the game enforce this?

And did Yahoo respond to the evolution and implement this new game based on community 
feedback?  No.  The game had been released years ago (I think 1999) and it seemed nobody 
maintained the codebase.  It had been thrown over the wall, or whatever metaphor you think
is better to explain the  lack of awareness, feedback and growth.

The foundational idea came from the collective creativity of the players, and from
the apparent disinterest Yahoo had in growing the game:  **instead of building a word game, why not
build a system for building word games?**

As a software engineer, I was not unaware of these metaphysical issues.  The idea
was not the game, but the idea of ideation.  Also it was about the engineering. 

Speculate with me and imagine variations of boggle-type games:

* how about different tile modifiers not just x3 and x2, but what about x7?
* how about tile modifiers you had to *avoid*, that could subtract from your score, or freeze you from typing for a set amount of time?
* what about changing the board so that it's not just square, what about
  * hexagonal?
  <img class="half-size" src="/images/originstory-hexagonal.png"/>
  * arbitrarily connected?
  <img class="half-size" src="/images/originstory-arbitrary.png"/>
* what about embedding morphemes in the tiles, instead of just letters? (in the following pic, I have put ```ing``` in a tile)
  <img class="half-size" src="/images/originstory-morphemes.png"/>
* what about making a tile into a blank, that a player could use as any letter?
* what about changing the scoring so that it
  * scored words with rarers letters higher (i.e. scrabble scoring)?
  * used real-time statistics to detect that a nine-letter word was 3 times as rare as a eight-letter word and thus gave you a 3 times higher score? 
* What about predicating the next word you find by the first word you find?
  * if you find a two letter word, you have to find a three letter word, then a four letter word etc.
  * if your first word ends in a letter, then the next word must begin with that letter
  * if your first word ends in a digraph, then the next word must begin with that digraph (e.g.  ```smell``` and ```llama```)
* what about games that have no timers and you just want to spend weeks finding every single word?

I could go on, and I have had a lot of fun creating game concepts both simple and complicated (and some impossible to 
implement in a computationally feasible manner).  But I think you get the point.
{{< note >}}
For anyone interested in the game rules for this fun old game, you may look at the cache for <a href="http://self.gutenberg.org/article.aspx?title=word_racer">this page</a>.  For some reason, any mention about Yahoo's Word Racer and how
to play it seem to have been scrubbed from the internet.  The Wayback machine is useful for this as wel
{{< /note >}}


<div id='discourse-comments'></div>

<script type="text/javascript">
  DiscourseEmbed = { discourseUrl: 'https://forum.wordadoplicus.com/',
                     topicId: 104 };

  (function() {
    var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
    d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
  })();
</script>


