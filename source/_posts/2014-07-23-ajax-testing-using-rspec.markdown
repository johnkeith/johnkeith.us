---
layout: post
title: "Ajax Testing using RSpec, Capybara, and Puffing Billy"
date: 2014-07-23 09:02:38 -0400
comments: true
categories: rspec, testing, capybara, rails
---
Launch Academy has come to an end. It was an incredible 10 weeks, but I already want to jump into a new project while beginning my developer job search. 

Ajax testing was one of the areas I only briefly touched on at the end of the course so I wanted to spend some time this week exploring this area. The engineers at Launch said that Ajax and other key Javascript operations of an app should be tested using a [JavaScript testing framework](http://jasmine.github.io/). I still see benefits to testing interactions that rely on Ajax with integration tests, especially if they are fundamental to a user's experience on the page. The example below is how I implemented a couple of Ajax tests using the GitHub API and a simple form. 

To start with, it is important to note that testing JavaScript requires you to add some extra configuration in your rails_helper and in your specs. Capybara by default uses the Selenium javascript driver to test Javascript on the page. From my initial testing, it seems like Selenium returns consistent results, but takes more time than other methods. Selenium opens a new instance of the browser for each test, which on a big test suite I imagine could lead to considerable delay. 

To enable Javascript on a test, simply pass the `js: true` option to the test. (Or better yet, pass `js: true` to your entire feature to use Javascript on all the tests in a spec). When you run RSpec, you should see browser windows pop up and replay the actions mapped out in your integration tests. 

There are other Javascript drivers, [Poltergeist](https://github.com/teampoltergeist/poltergeist) being the second one I implemented. Poltergeist needs a little extra setup to get it running, as it is built upon [PhantomJS](http://phantomjs.org/), which allows it to run your tests without opening new browser windows each time. 

First, add Poltergeist to your Gemfile. 

``` ruby
gem 'poltergeist'
```
Then, in your rails_helper, specify the default javascript driver to be used in your tests. 

``` ruby
Capybara.javascript_driver = :poltergeist
```
Again, make sure either a single test or your entire feature has Javascript enabled by passing the `js: true` option. 

``` ruby 
require_relative '../rails_helper'

feature "user enters basic information on homepage", js: true do
```
Finally, install PhantomJS from the link above. When running RSpec, you should see your test suite function as normal, without browser windows materializing all over the screen. 

One major issue that arises with these two approaches is API calls. When using these Javascript drivers on their own, the test suite is still reaching out and making API requests. At first I thought I was safe - I had [VCR](https://github.com/vcr/vcr) and [WebMock](https://github.com/bblimke/webmock) enabled in order to record and replay HTTP interactions. I found out the old fashioned way - by disconnecting from my wi-fi and causing the tests to fail - that these mechanisms were  in fact not capturing my Ajax requests. 

To grab these Ajax requests, I hunted down a gem called [Puffing Billy](https://github.com/oesmith/puffing-billy). Puffing Billy handles the recording of Ajax calls like VCR, allowing you to run the test suite with genuine API requests once and then subsequently replay the recordings made from the first calls. Puffing Billy has a great readme on its GitHub page, but below are the steps I followed to get it working. 

First, add Puffing Billy to your Gemfile. 

``` ruby
gem 'puffing-billy'
```
Then, require Puffing Billy in your rails_helper. 

```
require 'billy/rspec'
```
Next, set your default Javascript driver in your rails_helper. (Puffing Billy supports Selenium, Poltergeist, and Webkit. See the docs for more details.)

``` ruby
Capybara.javascript_driver = :poltergeist_billy
```
Lastly, configure Puffing Billy to cache Ajax interactions with this configure block in your rails_helper. 

``` ruby
Billy.configure do |c|
  c.cache = true
  c.cache_request_headers = false
  c.ignore_params = ["http://www.google-analytics.com/__utm.gif",
                     "https://r.twimg.com/jot",
                     "http://p.twitter.com/t.gif",
                     "http://p.twitter.com/f.gif",
                     "http://www.facebook.com/plugins/like.php",
                     "https://www.facebook.com/dialog/oauth",
                     "http://cdn.api.twitter.com/1/urls/count.json"]
  c.path_blacklist = []
  c.persist_cache = true
  c.ignore_cache_port = true # defaults to true
  c.non_successful_cache_disabled = false
  c.non_successful_error_level = :warn
  c.non_whitelisted_requests_disabled = false
  c.cache_path = 'spec/req_cache/'
end
```
That should be it! Now you can run your test suite, watch it pass, and see a folder of the requests in req_cache. 

Below is an example of a basic feature I wrote for what I believe is the world's first, only, and hopefully last GitHub dating app. (Not sure I'll be continuing with that side project...but it was a good example for learning Ajax testing). 

``` ruby
require_relative '../rails_helper'

feature "user enters basic information on homepage", js: true do
  scenario "fills in github username" do
    visit root_path
    fill_in "Your Github username", with: "johnkeith"
    select "Male", from: "gender-select"
    expect(page).to have_xpath "//img[@src=\"https://avatars.githubusercontent.com/u/4976905?\"]"
    expect(page).to have_css "div.has-success"
  end

  scenario "fills in a github username that doesn't exist" do
    visit root_path
    fill_in "Your Github username", with: "notaghuser"
    select "Male", from: "gender-select"
    expect(page).to have_content "Sorry, that is not a Github username."
    expect(page).to have_css "div.has-error"
  end

  scenario "selects own gender" do
    visit root_path
    select "Male", from: "gender-select"
    fill_in "Your Github username", with: "johnkeith"
    expect(page).to have_css "div.has-success"
  end

  scenario "selects preference for matches" do
    visit root_path
    select "Men", from: "match-pref-select"
    fill_in "Your Github username", with: "johnkeith"
    expect(page).to have_css "div.has-success"
  end

  scenario "fills username, selects gender, selects preferences" do
    visit root_path
    fill_in "Your Github username", with: "johnkeith"
    select "Male", from: "gender-select"
    select "Women", from: "match-pref-select"
    expect(page).to have_xpath "//img[@src=\"https://avatars.githubusercontent.com/u/4976905?\"]"
    expect(page).to have_select("gender-select", selected: "Male")
    expect(page).to have_select("match-pref-select", selected: "Women")
  end
end
```


