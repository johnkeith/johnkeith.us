---
layout: post
title: "Finding middle ground with Middleman"
date: 2014-02-05 19:24:45 -0500
comments: true
categories: [markdown, middleman]
---
For a while, I've been wondering - where is the better way of building static sites? I've made a ton of stuff working off of Bootstrap templates and Wordpress themes, but I also really love creating sites without all the mess of those big frameworks. I want to hand code sites to keep learning about the presentational side of web development, but an environment like Rails is not ideal for such explorations. Even the much more managable Sinatra is only a little better, as I feel like my focus when building something in Sinatra is split evenly between the front-end and back-end. 

That said, after finding and playing with [Middleman](http://www.middlemanapp.com), I believe it provides the perfect way to focus on the front-end of things without sacrifing the power of HAML, SASS and the like. The LiveReload extension is also amazing - it is incredible how small effiencies make all the differences when writing and testing out new ideas. 

I was really thrilled when I managed to figure out how to insert Markdown files into a HAML template built in a Middleman project. 

``` haml
.main-contain
  .pure-g-r
    .pure-u-1-2
      %h1 Hello folks.
    .pure-u-1-2
      %p What up?
      :markdown
        #{File.read(File.join(File.dirname(__FILE__), "test.md"))}
```

The code is nothing special, but being able to read a file of Markdown text and insert it into my template was pretty exciting. I'm planning to use this trick to create a text-heavy site that keeps its content as seperate from the presenation as possible by inserting all the large chunks of text as Markdown files into templates. 