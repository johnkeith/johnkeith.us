---
layout: post
title: "Final Prep for Launch Academy"
date: 2014-04-30 18:10:06 -0400
comments: true
categories: [launch academy, ruby]
---
The last part of our Launch Academy prep work is a moment of reflection. I feel like I've come quite far since I started the prework - especially in terms of my understanding of Git. The Git Immersion and [Learn Git Branching](http://pcottle.github.io/learnGitBranching/) were hugely helpful for me. Being able to visualize what is going on with rebases and merges made all the difference. Sandi Metz's book is by far my favorite of the readings and certainly the one I have spent the most time pouring over. Starting to understand the OOP patterns presented in that book has been a big turning point for me when it comes to grasping how entire applications are written and maintained. 

In addition to finishing out my prework, I've been spending a good deal of time on a site a Launch Academy staffer recommended called [Code Quizzes](http://www.codequizzes.com/) and this has been a great way to sharpen all the Ruby that I've been absorbing. Here are a few of the awesome methods and tricks I've encountered so far from the quiz questions. 

_Question:_
_a = [1, 2, 3] and b = ["a", "b", "c"].  Use these arrays to make [[1, "a"], [2, "b"], [3, "c"]]_

I really like the #zip method this question introduces. The #zip method allows you to combine two or more arrays with ease. Here's an example of combining three arrays. 

``` ruby
a = ["a", "b", "c"]
b = %w(1 2 3 4 5)
c = ["zip", "method"]

a.zip(b, c)
# [["a", "1", "zip"], ["b", "2", "method"], ["c", "3", nil]]

Hash[a.zip(b)]
# {"a"=>"1", "b"=>"2", "c"=>"3"}
```
You can see from the above that zip can be quite flexible and formidable, mashing together arrays or even forming hashes.

The #cycle method is another interesting array operation that came up in questions on Code Quizzes. With #cycle, you can perform a block for a specified amount of times. For example, if you had an array you can use #cycle to print out its contents in order any number of times. 

``` ruby
a = [1, 2, 3, 4]

a.cycle(4) { |i| p i }
```

Inject is certainly a method I want to master: it is really amazing how you can pass in a method to inject and let it do the work for you, without having to write a complete block. 

``` ruby
[1, 2, 3, 4, 5, 42].inject(:+)
```

One question that had me a tad [bumfumbled](http://www.gullahbible.com/e-GullahNT/Conc/44JHNGUL.htm) involved passing a method as a block and it being considered a Proc. 

_Question:_
_arr = ["a", "b"].  Capitalize each element of arr with a proc._

The answer given was `arr.map(&:upcase)`, which I am assuming means that you can pass methods as blocks and with some voodoo they turn into Procs. 

Further on, there was a great question that begged for a similar solution.

_Question:_
_Use a one-liner to find the longest word in the array: arr = %w{what is the longest word in this arrrrrray}_

The site proposed the method below. 

``` ruby
arr.inject { |longest_word, word| word.length > longest_word.length ? word : longest_word}
```

I think, however, it could be put more succicently with `arr.sort_by(&:length).last`.

The larger pattern that I'm begining to see is that with Ruby there is always another way, or twenty, to solve a problem.

