---
layout: post
title: "Simple File Uploads to Rails with Dragonfly"
date: 2014-03-11 17:42:53 -0400
comments: true
categories: [rails]
---
Gems are amazing. As a rookie developer, it is incredible to come into the Ruby/Rails community and discover the wealth of code that is available out there, packaged and ready to be used. I'd encountered and enjoyed open source software before, but it was not until I started writing code that I really came to appreciate what the concept means.

Take for instance file uploading with Rails. You can perform basic uploads using what Rails offers natively or you can choose from a multitude of gems (Paperclip, Carrierwave, Dragonfly, the [list goes on](https://www.ruby-toolbox.com/categories/rails_file_uploads)) that add more advanced methods of uploading and storing files in your Rails app. 

For the expense tracker I am currently working on, I selected [Dragonfly](https://github.com/markevans/dragonfly). I'll admit, I tried Paperclip first and I was unable to make it function correctly. My lack of success with Paperclip, however, was only half the reason I ended up with Dragonfly. 

As I was envisioning document uploads in my app, I wanted the document (a receipt or invoice of a purchase) to become part of the Expenses table that I had already set up with a multitude of fields. With Paperclip, as far as I understood from the tutorials provided, it seemed like the documents would be set up as a separate model in the database, then associated with my current Expenses model. I can see advantages to the Paperclip approach (making all the documents easily accessible in one section of the database), but I wanted keep the relationships in this app as simple as possible, if only for my own sanity.

The great part about Dragonfly is it makes adding a :document column to your current model incredibly easy. The instructions below were what I did to install and integrate Dragonfly to upload documents when creating a new record in my Expense model. 

First, I added Dragonfly to my gemfile and ran bundler.

``` ruby
gem 'dragonfly', "~>1.0.3"
```

```
$ bundle install
```

Then, in my app/models/expense.rb, I added an accessor for my document.

``` ruby
dragonfly_accessor :document
```

Back at the command line, I setup a migration to add a document column to my expenses model. 

```
$ Rails generate migration AddDocumentToExpenses
```

Inside the migration document, I added two columns, one for the :document_uid and :document_name, per the [Dragonfly wiki](http://markevans.github.io/dragonfly/).

``` ruby
class AddDocumentToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :document_uid, :string
    add_column :expenses, :document_name, :string
  end
end
```

Then came migrating the database.

```
rake db:migrate
```

Next was altering my app/views/expenses/_form.html.erb to include a field for file uploads. 

``` erb
<div class="field">
	<%= f.label :document %><br>
	<%= f.file_field :document %>
</div>
```
Then, inside my app/controllers/expenses_controller.rb, I added :document to the list of permitted parameters near the bottom. 

``` ruby
def expense_params
	params.require(:expense).permit(:user_id, :date, :reseller, :item_or_service, :payment_form, :charged_to, :cost, :amount_from_budget, :notes, :document)
end
```

With the next step, I was unsure if this was the correct course to take. I was worried about my files being uploaded to the public folder, as I assumed anything in that area would be easily accessible from the outside. I created a directory in the root of my app called secure_storage, though I have no idea if that name is a complete misnomer. Then, I opened the config/initializers/dragonfly.rb and changed the default location for where files would be stored. Again, hopefully this will put them in a better location than the public directory, but I am not a hundred precent sure. 

``` ruby
datastore :file,
  root_path: Rails.root.join('secure_storage/system/dragonfly', Rails.env),
  server_root: Rails.root.join('secure_storage')
```

Finally, I added a file link (with a condition to make sure it didn't appear if no file was present with the record) on the app/views/expenses/show.html.erb. 

``` erb
<% if @expense.document %>
<p>
  <strong>Document:</strong>
  <%= link_to "File", root_url.chop + @expense.document.url %>
</p>
<% end %>
```

That, I believe, was all! You should now have a working file upload function, one that even lets you download the file too! If you try this and have trouble, let me know in the comments below.
