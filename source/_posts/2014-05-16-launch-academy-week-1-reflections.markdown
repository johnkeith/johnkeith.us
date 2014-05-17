---
layout: post
title: "Launch Academy Week 1 Reflections"
date: 2014-05-16 20:41:21 -0400
comments: true
categories: [launch academy, ruby]
---
Summing up week one of Launch Academy is tough: it's been a whirlwind of information and challenges. Here's what I do know: I could not be more excited to be here and on my way to becoming a software developer. 

This first week really affirmed my desire to become a developer. Coming into Launch Academy, I was unsure of what life would be like working in web development professionally - I knew I'd enjoyed tinkering in the past, but I didn't know what would it be like to be writing software everyday. At the end of this first week, I feel confident that I'm going to enjoy this new career tremendously. 

That's not to say this week was without it's travails. The Launch Academy instructors stressed from day one that software development is not just about code: great software is the product of strong communication. This is definitely been a big shift in thinking for me as up until now I've essentially been flying solo when coding. It is certainly taken some adjustment and I feel one of the most important things I've been working on this week is learning how to collaborate and develop solutions with other people. 

On the technical side, the past five days been a huge boost for my abilities in Ruby. As we take on bigger and bigger problems, I'm really enjoying figuring out how to design programs and implement them as concisely as possible. Towards the end of the week, after seeing it mentioned in one of our Ruby challenges, I started playing around with the Benchmark module and it has been very interesting to look at how different ways of performing operations can be more efficient than others. I was surprised that the Fibonacci sequence methods below resulted in calculation times that were roughly the same. 

```ruby

require 'benchmark'

time = Benchmark.realtime do
  def fibonacci(nth)
    array_o_fibs = []
    if nth == 1 || nth == 2
      return 1
    else
      array_o_fibs << 1; array_o_fibs << 1
      until array_o_fibs.length == nth
        array_o_fibs << array_o_fibs[-1] + array_o_fibs[-2]
      end
    end
    array_o_fibs[-1]
  end

  fibonacci(100)
end

puts "The time elapsed in milliseconds is #{time*1000} with the non-recursive fibonacci method."

time = Benchmark.realtime do

  def other_fibonacci(n)
    if n == 1 || n == 2
      1
    else
      fibonacci(n - 1) + fibonacci(n - 2)
    end
  end

  other_fibonacci(100)
end
puts "The time elapsed in milliseconds is #{time*1000} with the recursive fibonacci method." 
```
