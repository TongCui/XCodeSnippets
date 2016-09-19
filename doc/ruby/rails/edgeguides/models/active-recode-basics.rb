#!/usr/bin/env ruby

## Object Relational Mapping
# is a technique that connects the rich objects 
# of an application to tables in a relational database management system. 

## Convention over Configuration in Active Record

1. Naming Conventions
By default, Active Record uses some naming conventions 
to find out how the mapping between models and database 
tables should be created. Rails will pluralize your class names 
to find the respective database table. 

|Model/Class  | Table/Schema|
|Article      | articles    |
|LineItem     | line_items  |
|Mouse        | mice        |
|Person       | people      |

2. Schema Conventions
for the columns in database tables, depending on the purpose of these columns.

- Foreign Keys : singularized_table_name_id(e.g. item_id , order_id)

- Primary Keys : id

There are also some optional column names that will add additional features to Active Record instances:

- created_at
- updated_at
- lock_version
- type
- (association_name)_type
- (table_name)_count # a comments_count column in an Article class that has many instances of Comment will cache the number of existent comments for each article.


## Creating Active Record Models


class Product < ApplicationRecord
end

Suppose

CREATE TABLE products (
   id int(11) NOT NULL auto_increment,
   name varchar(255),
   PRIMARY KEY  (id)
);

## Overriding the Naming Conventions
What if you need to follow a different naming convention 
or need to use your Rails application with a legacy database?

class Product < ApplicationRecord
  self.table_name = "my_products"
end

class ProductTest < ActiveSupport::TestCase
  set_fixture_class my_products: Product
  fixtures :my_products
  ...
end

It is also possible to override the column 

class Product < ApplicationRecord
  self.primary_key = "product_id"
end

## CRUD: Reading and Writing Data

1. Create

user = User.create(name: "David", occupation: "Code Artist")

or

user = User.new
user.name = "David"
user.occupation = "Code Artist"

or 

user = User.new do |u|
  u.name = "David"
  u.occupation = "Code Artist"
end

2. Read

users = User.all

user = User.first

david = User.find_by(name: 'David')

users = User
.where(name:'David', occupation: 'Code Artist')
.order(created_at: :desc)

3. Update

user = User.find_by(name: 'David')
user.name = 'Dave'
user.save

or 

user.update(name: 'Dave')

or 

User.update_all "max_login_attempts = 3, must_change_password = 'true'"

4. Delete

user = User.find_by(name: 'David')
user.destroy

## Validations


class User < ApplicationRecord
  validates :name, presence: true
end
 
user = User.new
user.save  # => false
user.save! # => ActiveRecord::RecordInvalid: Validation failed: Name can't be blank

## Callbacks

## Migrations

class CreatePublications < ActiveRecord::Migration[5.0]
  def change
    create_table :publications do |t|
      t.string :title
      t.text :description
      t.references :publication_type
      t.integer :publisher_id
      t.string :publisher_type
      t.boolean :single_issue
 
      t.timestamps
    end
    add_index :publications, :publication_type_id
  end
end

rails db:migrate
rails db:rollback













