---
layout: post
title: "Image hosting for a Heroku Octopress site"
date: 2014-03-04 17:44:27 -0500
comments: true
categories: [octopress, heroku]
---
Since Heroku only allows for 300 MB of storage for their free tier of hosting, it makes sense to store the images for an Octopress site in a separate location. Previously, I used Flickr for a few posts, but the process of uploading the files and hunting down the embed link was tiresome. 

The better way, it seems, is to use Google Drive, despite the fact that Google doesn't provide an easy way to embed either. What makes using Google Drive much friendlier than Flickr, however, is a site called [gdURL](http://gdurl.com/​). 

With gdURL, all you need to do is share an image file on Google Drive, change the privacy settings to "Anyone who has the link can view", then run the link Google Drive provides you through the gdURL service and you receive a tidy, bite-sized link for embedding your image. 

For instance, I used gdURL in the following line to link to a picture of this site's new theme.

~~~ markdown
![So Fresh and So Green](http://gdurl.com/i4Wr)​
~~~

![So Fresh and So Green](http://gdurl.com/i4Wr)​

Quick, easy, and keeps the size of your Octopress repo down.