---
layout: post
title: "Treehouse Badges for Octopress"
date: 2014-04-24 23:10:21 -0400
comments: true
categories: [jquery, octopress, treehouse]
---
When I came across Riley Hillard's tutorial on making a [Treehouse report card](http://rileyh.com/treehouse-badges-widget/), I knew I had to have something like this on my site. While I considered using Riley's [ReportCard.js](http://reportcard.rileyh.com/), it dawned on me that recreating the widget might be a great way to get more experience working with hashes, JSON and the like. After a bit of experimentation on [Codepen](http://codepen.io/johnkeith/pen/ocIaj), I had a functional piece of jQuery and a little CSS to give it a decent appearance (though really that’s mostly due to those spiffy looking badges). 

I toyed with the idea of crafting a Liquid Tag that could be used anywhere in a Octopress blog, but decided on building it as widget for the sidebar instead. To make it a little more interesting, I did end up writing a Rake file to automatically add the widget's files into your Octopress folder and add the proper configuration variables to _config.yml. If you are an Octopress/Treehouse fan then go [check it out](https://github.com/johnkeith/TreehouseBadgesOctopress)!
