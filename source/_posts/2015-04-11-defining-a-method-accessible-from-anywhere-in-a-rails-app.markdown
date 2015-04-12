---
layout: post
title: "Defining a method accessible from anywhere in a Rails app"
date: 2015-04-11 19:56:11 -0400
comments: true
categories: rails, ruby
---
It started as an innocuous attempt to dry up some controller code.  

```ruby
# app/controllers/export_controller.rb

if ENV['TORQUEBOX_APP_TYPE'].present? || ENV['TORQUEBOX_APP_NAME'].present?
	# do some crazy stuff in a background process since this is clearly running in production
else
	# Rails must be running locally, so do it in the foreground
```

I noticed that the same `if` statement was used in our config/application.rb to setup the correct logging when Torquebox is running. After searching the rest of the code and seeing the same logic was present in config/environments/development.rb I mistakenly thought, "It can't be too hard to figure out how to have a method accessible from anywhere in a Rails app." 

How wrong I was!

That said, I came up with two possible solutions. The first was to create a proc, stuff it in a global variable, and then access that from each of the places I needed (the config files and the controller).

```ruby
$torquebox_running = Proc.new { ENV['TORQUEBOX_APP_TYPE'].present? || ENV['TORQUEBOX_APP_NAME'].present? }
```

While the proc worked, I didn't think it was the best solution for two structural reasons. 

1. It would have to be defined in application.rb in order to be used in the start up process, but being defined in that file outside of the Application class (so that it could be accessed elsewhere in the app) would be a tad strange. 

2. Usage wise, the syntax of $torquebox_running.call seemed a bit strained to me.

My gut told me that I might be breaking every law in the book by declaring a global proc during the boot-up process of a Rails app. So I decided on a more compartmentalized (though still perhaps not object-oriented) approach to solving the problem. 

```ruby
# lib/services/torquebox_information_service.rb
module TorqueboxInformationService
	extend self

	def env_vars_present? 
		ENV['TORQUEBOX_APP_TYPE'].present? || ENV['TORQUEBOX_APP_NAME'].present?
	end

	def process_running?
		# not working, needs refinement
		process_pid = Process.pid
		process_info = `ps -ef | grep #{process_pid}`
		process_info.downcase.include?('torquebox')
	end
end
```

```ruby
# config/application.rb
require File.expand_path('../../lib/services/torquebox_information_service', __FILE__)
```

By wrapping these environment checking methods inside a module and using the handy `extend self`, the logic was kept isolated and no awful globals created in the process. 

I then required the module in the application.rb above all other requirements and the Application class in order that it would be available in every part of the app (config files, models, controllers, the whole gaggle of them!). So far, this approach is working and allows the logic for checking if Torquebox is running to be stored in a single place. 

I still feel like this could be improved, though. Maybe by not using `extend self` and instead including the module on any of the classes that need access to these methods it would better keep these Torquebox logic confined to only the places in the app that need access?