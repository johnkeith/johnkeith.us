---
layout: post
title: "Dynamically control button labels with a helper method"
date: 2014-03-14 19:20:08 -0400
comments: true
categories: [rails]
---
_Reader beware: I'm learning Rails right now. In no way, shape or form should this post or any posts here for at least the next month and a half be taken as gospel truth of how to do things right in Rails. They probably are way, way out in right field._

Okay, say you have a view and in that view you have a beautiful button. If you want to assign a name to that button dynamically, say based on the truthiness of some variable, here's an easy way to do it. 

1. Open up the ***_helper.rb file for your model. In your _helper file, write a method that will provide you two pieces of text, depending on a certain condition.

~~~ ruby
def sign_up_btn
  if User.sign_up_allowed == true
    "Prevent new account creation"
  else
    "Allow new account creation"
  end
end
~~~

Or, if you want to be fancy, try this refactored-while-in-the-midst-of-blogging-version. 

~~~ ruby
def sign_up_btn
  User.sign_up_allowed ? "Prevent new account creation" : "Allow new account creation"
end

~~~

Then, back over in your view file, add this bit to create the button and assign it a title based on the results of the method above. 

~~~ erb
<%= button_to action: "disallow_sign_up" do %><%= "#{sign_up_btn}" %><% end %>
~~~

(Just so you get a fuller picture, here's my disallow_sign_up method from my users_controller. I wrote it as a way for an admin to turn off access to the sign up page in the expense tracking app I'm working on.)

~~~ ruby
def disallow_sign_up
  User.sign_up_allowed ? User.sign_up_allowed = false : User.sign_up_allowed = true
  redirect_to users_index_path
end
~~~

I have a serious fixation on the ternary operator, if you haven't noticed. 
