---
layout: post
title: "Week Three and Designing for Efficiency"
date: 2014-06-01 19:31:07 -0400
comments: true
categories: [ruby, launch academy]
---
Week three of Launch Academy was a short one with the holiday on Monday, but we covered a lot of ground. It was the start of the second module in the curriculum and we dove headfirst into databases this week. The relation database we are using right now is Postgres, which has been a nice change from the static data storage in CSV files we were using in weeks one and two. 

We also had a great speaker come this week - [Peter Degen-Portnoy](https://twitter.com/PDegenPortnoy). He gave us a brief introduction to object oriented design, which will be the focus of our work this week. 

Outside of our core material last week, I spent time wresting with problems of efficiency. I found myself still mulling over mechanics from the 2048 code I wrote in week two, looking for ways to improve the efficiency of the logic used to find random empty spaces on the game board. I knew our initial way was not ideal - it determined random X and Y coordinates on the board and checked to see if that space was empty. Eventually, I ended up benchmarking three different ways of finding a random empty space in a matrix and I believe I found a reasonably efficient way to go about it. (It is the middle method of the three below, which gives consistently better results, often taking half the time of the other two).

My goal is to continue thinking along these lines this week - learning about how to incorporate object oriented design into our apps while keeping an eye out for writing efficient code. 

``` ruby
test_board = [["2","4","4","2"],
              ["4","2","2"," "],
              ["2","2","8","2"],
              ["4","3","4","8"]]

def insertRandomly(board)
  two_or_four = rand.round == 0 ? 4 : 2
  insert_successful = false
  while !insert_successful
    random_position_one = rand(board.length)
    random_position_two = rand(board.length)
    if board[random_position_one][random_position_two] == " "
      board[random_position_one][random_position_two] = two_or_four.to_s
      insert_successful = true
    end
  end
end

def insertLessRandomly(board)
  two_or_four = rand.round == 0 ? 4 : 2
  random_direction = rand.round == 0 ? true : false
  insert_successful = false
  while !insert_successful
    random_position_one = rand(board.length)
    empty_space = nil
    empty_space = board[random_position_one].find_index do |item|
      item == " "
    end
    if empty_space != nil
      board[random_position_one][empty_space] = two_or_four.to_s
      insert_successful = true
    end
  end
end

def insertByIndex(board)
  two_or_four = rand.round == 0 ? 4 : 2
  empty_spaces = []
  board.each_with_index do |row, row_index|
    row.each_with_index do |column, col_index|
      empty_spaces << [row_index, col_index] if column == " "
    end
  end
  select_empty = empty_spaces.sample
  board[select_empty[0]][select_empty[1]] = two_or_four
end
```
