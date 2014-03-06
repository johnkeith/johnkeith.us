---
layout: post
title: "Build What You Use As a Way to Learn"
date: 2014-03-06 17:38:44 -0500
comments: true
categories: ruby
---
I can't remember where I read it, but recently I came across the advice that one of the best ways to practice programming is to recreate the type of applications you use everyday. No need to make them flashy, simply implement their core features in order to achieve the same results. 

I decided to give it a try today and build a tiny todo app in Ruby. I wanted to write the app keeping in mind the directives from Sandi's Metz's [Practical Object-Oriented Design in Ruby](http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330).

> "Remember that a class should do the smallest possible useful thing. That
thing ought to be simple to describe. If the simplest description you can devise uses the
word "and,” the class likely has more than one responsibility.​" - Metz

While it ended up that my app only had one class, I tried to follow in the spirit of the quote above by keeping my methods as focused as possible. I also tried to heed her advice to stave off design decisions for as long as possible - an interesting strategy that had me trying to store all completed and incomplete todos in the same file. I quickly realized, though, that this was an inefficient way of doing things, since my completed items list would (hopefully) be a far larger file than my active items list and there is no reason to load that large file every time the app is opened.

There is one little quirk that I can't seem to shake: when you mark a todo as finished, the item is removed from the activelist.txt file, but is not added to the completelist.txt file until you close the program. I'm sure it has something to do with the file opening modes I selected, but I can't figure out why I am able to modify and then view the modifications done to activelist.txt while in the app, but not do the same with completelist.txt.

In the end, this was a great way to get practice using the File and IO classes of Ruby and exploring their methods. Not to mention, I get a pretty nifty little command line todo list manager (which I'll stick in Dropbox for easy access) out of it! 

~~~ ruby
require 'rbconfig'

class Todo
	def clear_screen
		host_os = RbConfig::CONFIG['host_os']

		case host_os
			when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
				system "cls"
			when /darwin|mac os|linux|solaris|bsd/
				puts "\e[H\e[2J"
		end
	end

	def open_app
		view_all
	end

	def view_all
		clear_screen

		list_read = read_active_list
		
		puts "------INCOMPLETE------\n\n"
		list_read.each do |line|
			puts line
		end
		puts "\n----------------------"

		choose_action
	end

	def read_active_list
		list = File.open("activelist.txt","a+").readlines
	end

	def choose_action
		puts %/
		What would you like to do with your list?
		1. Add a todo
		2. Mark complete
		3. View incomplete
		4. View completed
		5. Exit/

		choice = gets.chomp.downcase

		case choice
			when "1" then input_todo
			when "1." then input_todo
			when "add" then input_todo
			when "add todo" then input_todo
		
			when "2" then mark_done
			when "2." then mark_done
			when "mark" then mark_done
			when "mark done" then mark_done

			when "3" then view_incomplete
			when "3." then view_incomplete
			when "view incomplete" then view_incomplete
			
			when "4" then view_complete
			when "4." then view_complete
			when "view completed" then view_complete

			when "5" then return
			when "5." then return
			when "exit" then return

			else
				p "Not a valid choice"
				choose_action
		end
	end

#ask for todo
	def input_todo
		puts "\nEnter your new todo:"
		todo = gets.chomp
		add_todo(todo)
		view_all
	end

#write method
	def add_todo(todo)
		File.open("activelist.txt", "a") { |f| f.write "#{todo}\n" }
	end

#mark done method
	def mark_done
		clear_screen

		list_read = File.open("activelist.txt","a+").readlines

		puts "------INCOMPLETE------\n\n"
		list_read.each_with_index do |line, index|
			puts "#{index + 1}. " + line
		end
		puts "\n----------------------"

		puts "\nWhich todo do you want to mark complete? (Type the number or zero to cancel)."
		
		choice = gets.chomp.to_i

		File.open("activelist.txt", "w") do |f|
			list_read.each_with_index do |line, index|
				if (index + 1) == choice 
					add_to_complete_list line
				else
					f.write "#{line}"
				end
			end
		end

		view_all
	end

	def add_to_complete_list line
		File.open("completelist.txt", "a").write "#{line}"
	end

	def view_complete
		clear_screen

		complete_list = File.open("completelist.txt", "a+").readlines

		puts "------COMPLETED------\n\n"
		complete_list.each do |line|
			puts line
		end
		puts "\n---------------------"

		choose_action
	end

	def view_incomplete
		view_all
	end
end

my_todo_list = Todo.new

my_todo_list.open_app
~~~