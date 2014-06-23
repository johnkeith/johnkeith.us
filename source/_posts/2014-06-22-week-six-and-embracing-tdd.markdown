---
layout: post
title: "Week Six and Embracing TDD"
date: 2014-06-22 19:41:39 -0400
comments: true
categories: [rails, tdd]
---
We have made it to the end of week six. It was a big one for me: 

- Pushed a [Javascript game to Heroku](http://unodos.herokuapp.com)
- Promptly got hacked
- Started figuring out OmniAuth
- Finally surmounted my fear/distaste for Test Driven Development. 

TDD was one of the big aspects of the move to Rails that I was dreading. During our phase working in Sinatra, we didn't worry about TDD - it was enough trying to wrap our heads around the basics of HTTP, Postgres, and ActiveRecord. Now that we are building with Rails in ernest, TDD has moved to the foreground of our development process. 

Initially, I was very wary of TDD. The Launch instructors did a great job of demonstrating the rationale behind TDD, showing us how TDD can ensure against your changes in one part of an app breaking another part, which was one thing that never quite sunk in for me working through tutorials online. That said, some of my early fumbling through Capybara and Rspec left me hesitant about TDD. 

When we started TDD, I shied away from the assignments, focusing on a side project in Javascript. We finally finished that Javascript game on Friday, turning it into a Sinatra app that we were able to put up on Heroku, and this weekend I resolved to put in the time to get comfortable using TDD. 

Having spent the past two days building a first Rails app from the ground up with TDD, my perspective has certainly changed. When you strictly adhere to the TDD methodology, it makes the process of building an app (especially a Rails app by hand, without scaffolding, as was the assignment this weekend) much more approachable and logical. My final product hardly had comprehensive test coverage, but now I feel comfortable with using TDD as a guide for building an app piece by piece. 
