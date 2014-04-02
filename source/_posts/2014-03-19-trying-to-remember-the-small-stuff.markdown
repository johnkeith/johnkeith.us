---
layout: post
title: "Trying to Remember the Small Stuff"
date: 2014-03-19 17:47:29 -0400
comments: true
categories: [rails, ruby] 
---

Refactoring is really fun, especially in those moments when you have an "Aha!" flash and one of those little details clicks into place. I had that today with method I wrote for changing the sorting on a table in a Rails view. 

``` ruby
def sortable(column, title = nil)
  title ||= column.titleize
  direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
  font_awesome_direction = direction == "asc" ? "up" : "down"
  css_class = column == sort_column ? "fa-caret-#{font_awesome_direction}" : nil
  link_to title, {:sort => column, :direction => direction}, {class: css_class}
end
```

That sortable method was placed in my application_helper.rb. It works with these two methods from my view controller. 

``` ruby
def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
end

def sort_column
  Expense.column_names.include?(params[:sort]) ? params[:sort] : "date"
end
```

And all of these are put into place with the index method in that same view controller. 

``` ruby
def index
  @expenses = Expense.order(sort_column + ' ' + sort_direction).paginate(page: params[:page])
end
```  

Initially, what I'd written wasn't terrible: it worked in the browser, my columns resorted themselves on prompting, and a nice little caret was provided as feedback and a guide post for the user. That said, I was irked by the way the caret was smushed right up against the text and the way that adding the caret threw off the font sizing and styling I had going at the top of my table. 

So, I took a step back and tried to determine out if it was possible to embed HTML inside of a link_to in Rails. A couple minutes later, I had figured out it was perfectly acceptable and learned a little bit about the nifty \#html\_safe method that Rails provides. This led me to a rewritten last line that I think provides a much more pleasing output. 

``` ruby
link_to "<i class='fa #{css_class}'></i> ".html_safe+title, {:sort => column, :direction => direction}
```

It was also great to have one of those moments when all that reading comes in handy. I couldn't get the icons to appear the first time I fired up the page, because I had wrapped my icon HTML in single quotes instead of double. Using double quotes on the outside and then single on the inside allows Ruby to interpolate the css\_class variable. Nothing fancy, but still a good learning experience that will hopefully keep me more consistent with my use of quotes. 
