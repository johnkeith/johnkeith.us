---
layout: post
title: "My Ruby Toolbox at the End of Week Two"
date: 2014-05-26 07:49:44 -0400
comments: true
categories: [ruby, sinatra]
---
Week two flew by and it is amazing how far we have come. It is also amazing how overrun the Launch Academy folder on my laptop is right now. For my reflective post this week, I think it would be a good exercise to do some house keeping on the code I've written so far and take a look at some of the awesome tools I'm starting to learn how to use in Ruby. 

One of the most fun things I did was work with a couple other Launchers on recreating the [2048 game on the command line](https://github.com/johnkeith/Ruby2048). It was a great exercise - working with nested arrays that represented the board, constructing the methods that would move and recalculate the board each turn. The hardest part was combing Google to find out how to handle improper keyboard inputs from the terminal (for example, if you type "Z" instead of the "A","S","W", or "D" keys we specified for moving). It was a slight distraction from our main work of the week, but I really loved figuring out how the mechanisms behind the game worked. (I'd love to work on making an online playable version of the game in Sinatra, but that might have to wait until I have a better grasp of Javascript.) Here's a little snippet of our moving method using #transpose to flip the board around for easier calculating. 

``` ruby
def strip_row_right(row)
  row.delete_if {|space| space == " "}
  until row.length == 4
    row.unshift(" ")
  end
  row
end

def move_down(board)
  board = board.transpose
  board.each_with_index do |row, row_idx|
    strip_row_right(row)
    row.reverse!.each_with_index do |column, col_idx|
      if column == row[col_idx + 1] && !(column == " " )
        board[row_idx][col_idx] = (board[row_idx][col_idx].to_i * 2).to_s
        board[row_idx][col_idx+1] = " "
      else
        next
      end
    end
    row.reverse!
    strip_row_right(row)
  end
  board.transpose
end
```
Another non-core, but extremely rewarding set of exercised I played with this week came from the [Evernote Challenge](https://evernote.com/careers/challenge.php). Basically, the challenge is a set of three problems that Evernote posted on their website, each of which can be submitted and automatically tested on the site. While I was never able to get my tests passing, sadly, I think I was able to sufficiently solve two of the problems, one involving a circular buffer and the other with counting the frequency of terms in a given input. I even dived into writing a few tests for my circular buffer solution to start preparing myself for the leap into TDD that will be coming up in the next few weeks. The frequency problem also was a great opportunity to deal with the travails of sorting hashes and multidimensional sorting of arrays. 

``` ruby 
terms_to_add = gets.chomp.to_i
items_to_count = Hash.new(0)

1.upto(terms_to_add).each do
  input = gets.chomp.to_sym
  items_to_count[input] += 1
end

take_amount = gets.chomp.to_i

take_top = items_to_count.sort_by { |k, v| v }.reverse.take(take_amount)

fully_sorted = take_top.sort_by {|item| [-item[-1], item[0].to_s] }

fully_sorted.each {|item| puts item[0].to_s }
```
As I mentioned, our big focus in class this week was on Sinatra. I built at least five Sinatra apps this week, ranging from ones that pulled in data from a CSV to ones that actually started creating dynamic pages based on JSON data from APIs. I also started using HAML extensively on these project. Its really awesome how simple and readable HAML makes an HTML page. 

This weekend I've been wrestling with creating a URL shortener in Sinatra. I've made it to the point where the site is mostly functioning, but I'm working on error and exception handling, which is no easy task. I also cannot for the life of me get my head around Redis, the database they recommended we use for this project, so I think I'm going to be spending a good amount of time next week trying to figure out databases once and for all. That said, working on the URL shortener gave me a great opportunity to play around with the web scraping gem Nokogiri. Using Nokogiri, I was easily able to scrape a list of sandwich names (to be the links in my URL shortener) off a website and into a easily accessible array. 

``` ruby
page = Nokogiri::HTML(open("http://www.thrillist.com/food/nation/national-sandwich-day"))

sandwich_list = []

sandwiches = page.css("strong")

sandwiches.each do |item|
  sandwich_list << item.text.downcase.gsub(/[\d+\W+\s]/, "").gsub(/the/, "")
end
```
