#!/usr/bin/env ruby

# [Ruby on Rails Guides](http://edgeguides.rubyonrails.org/)

## What is Rails?
```
- Don't Repeat Yourself
- Convention Over Configuration
```
## Creating a New Rails Project


rails new blog
# rails new -h

## Starting Server

rails server

```
-p --port
-b --binding=IP
```

## Say "Hello"

# To create a new controller, 
# you will need to run the "controller" generator 
# and tell it you want a controller called "Welcome" 
# with an action called "index", just like this:

rails generate controller Welcome index

# => http://localhost:8080/welcome/index

## Setting the Home Page

# root 'welcome#index' tells Rails to map requests 
# to the root of the application 
# to the welcome controller's index action 
# and get 'welcome/index' tells Rails 
# to map requests 
# to http://localhost:3000/welcome/index 
# to the welcome controller's index action.

## Getting Up and Running

# In the Blog application, you will now create a new resource.
# A resource is the term used for 
# a collection of similar objects, 
# such as articles, people or animals. 
# You can create, read, update and destroy items for a resource 
# and these operations are referred to as CRUD operations.

resources :articles

rails routes


rails generate controller Articles



```
# app/views/articles/new.html.erb

<%= form_for :article do |f| %>
  <p>
    <%= f.label :title %><br>
    <%= f.text_field :title %>
  </p>
 
  <p>
    <%= f.label :text %><br>
    <%= f.text_area :text %>
  </p>
 
  <p>
    <%= f.submit %>
  </p>
<% end %>

```

# The articles_path helper tells Rails to point the form 
# to the URI Pattern associated with the articles prefix

form_for :article, url: articles_path do |f|


def create
  render plain: params[:article].inspect
end

## Creating the Article Model

rails generate model Article title:string text:text

## Running a Migration

rails db:migrate

rails db:migrate RAILS_ENV=production

## Saving data in the controller


def create
  @article = Article.new(params[:article])
 
  @article.save
  redirect_to @article
end

# Rails has several security features 
# that help you write secure applications, 
# and you're running into one of them now. 
# This one is called strong parameters, 
# which requires us to tell Rails exactly 
# which parameters are allowed into our controller actions.


def create
  @article = Article.new(article_params)
 
  @article.save
  redirect_to @article
end
 
private
  def article_params
    params.require(:article).permit(:title, :text)
  end

## Showing Articles

def show
  @article = Article.find(params[:id])
end

## Listing all articles

```
<td><%= link_to 'Show', article_path(article) %></td>

<h1>Hello, Rails!</h1>
<%= link_to 'My Blog', controller: 'articles' %>

<%= link_to 'New article', new_article_path %>

<%= link_to 'Back', articles_path %>
```

# If you want to link to an action in the same controller, 
# you don't need to specify the :controller option, 
# as Rails will use the current controller by default.

# The link_to method is one of Rails' built-in view helpers. 
# It creates a hyperlink based on text to display 
# and where to go - in this case, to the path for articles.


## Adding Some Validation

class Article < ApplicationRecord
  validates :title, presence: true,
                    length: { minimum: 5 }
end

def create
  @article = Article.new(article_params)
 
  if @article.save
    redirect_to @article
  else
    render 'new'
  end
end

```
new.html.erb

<% if @article.errors.any? %>
  <div id="error_explanation">
    <h2>
      <%= pluralize(@article.errors.count, "error") %> prohibited
      this article from being saved:
    </h2>
    <ul>
      <% @article.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
  </div>
<% end %>
```

## Updating Articles


def edit
  @article = Article.find(params[:id])
end

```
<h1>Edit article</h1>
 
<%= form_for :article, url: article_path(@article), method: :patch do |f| %>
```

def update
  @article = Article.find(params[:id])
 
  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

# It is not necessary to pass all the attributes to update. 
# For example, if @article.update(title: 'A new title') was called, 
# Rails would only update the title attribute, 
# leaving all other attributes untouched.


```
<%= link_to 'Edit', edit_article_path(@article) %> |
<%= link_to 'Back', articles_path %>
```

## Using partials to clean up duplication in views

# Our edit page looks very similar to the new page; 
# in fact, they both share the same code for displaying the form
# Let's remove this duplication by using a view partial. 
# By convention, partial files are prefixed with an underscore.

## Deleting Articles

```
<% @articles.each do |article| %>
  <tr>
    <td><%= article.title %></td>
    <td><%= article.text %></td>
    <td><%= link_to 'Show', article_path(article) %></td>
    <td><%= link_to 'Edit', edit_article_path(article) %></td>
    <td><%= link_to 'Destroy', article_path(article),
            method: :delete,
            data: { confirm: 'Are you sure?' } %></td>
  </tr>
<% end %>
```

## Adding a Second Model


rails generate model Comment commenter:string body:text article:references

class Comment < ApplicationRecord
  belongs_to :article
end


class Article < ApplicationRecord
  has_many :comments
  validates :title, presence: true,
                    length: { minimum: 5 }
end

resources :articles do
  resources :comments
end

rails generate controller Comments

```
articles/show.html.erb


<h2>Add a comment:</h2>
<%= form_for([@article, @article.comments.build]) do |f| %>
  <p>
    <%= f.label :commenter %><br>
    <%= f.text_field :commenter %>
  </p>
  <p>
    <%= f.label :body %><br>
    <%= f.text_area :body %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>

```

```
comments/_comment.html.erb


<p>
  <strong>Commenter:</strong>
  <%= comment.commenter %>
</p>
 
<p>
  <strong>Comment:</strong>
  <%= comment.body %>
</p>

articles/show.html.erb

<h2>Comments</h2>
<%= render @article.comments %>

```

## Deleting Associated Objects
def destroy
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
  @comment.destroy
  redirect_to article_path(@article)
end

has_many :comments, dependent: :destroy


## Security







