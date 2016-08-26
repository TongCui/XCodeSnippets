[railstutorial](https://www.railstutorial.org/book/beginning)

# Start App

rails new hello_app

## Bundler

bundle install
bundle update
bundle install --without production

## Start Serverll

rails server

http://localhost:3000

rails server 

rails server -b <IP> -p <PORT>

## Model-View-Controller (MVC)

## Hello world

#### application_controller.rb

def hello
  render html: "hello, world"
end

#### routes.rb
root 'application##hello'

## Generate a random string

('a'..'z').to_a.shuffle[0..7].join


# A toy app

## Generate a model

The argument of the scaffold command is the singular version of the resource name (in this case, User), together with optional parameters for the data model’s attributes

rails generate scaffold User name:string email:string

## Migrating the database
rails db:migrate

URL Action  Purpose
/users  index page to list all users
/users/1  show  page to show user with id 1
/users/new  new page to make a new user
/users/1/edit edit  page to edit user with id 1

## A Nice Image To Desc MVC
[MVC](https://www.railstutorial.org/book/toy_app)

## update routes.rb
root "users#index"


## A micropost microtour

rails generate scaffold Micropost content:text user_id:integer

## Console

rails console

## Static Pages

rails generate controller StaticPages home help

rails generate model User name:string email:string
rails destroy model User

rails db:migrate
rails db:rollbac

## Tesing

## HTML

 <% ... %> executes the code inside, while <%= ... %> executes it and inserts the result into the template.)

 <% provide(:title, "Help") %>

  <head>
       <title><%= yield(:title) %> | Ruby on Rails Tutorial Sample App</title>
  </head>
















