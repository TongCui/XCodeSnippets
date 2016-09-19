#!/usr/bin/env ruby

## Migration Overview



class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
 
      t.timestamps
    end
  end
end


# If you wish for a migration to do something 
# that Active Record doesn't know how to reverse, 
# you can use reversible:


class ChangeProductsPrice < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up   { t.change :price, :string }
        dir.down { t.change :price, :integer }
      end
    end
  end
end


or


class ChangeProductsPrice < ActiveRecord::Migration[5.0]
  def up
    change_table :products do |t|
      t.change :price, :string
    end
  end
 
  def down
    change_table :products do |t|
      t.change :price, :integer
    end
  end
end

## Creating a Migration

rails generate migration AddPartNumberToProducts

This will create an empty but appropriately named migration:


class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
  def change
  end
end

rails generate migration AddPartNumberToProducts part_number:string

class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :part_number, :string
  end
end

rails generate migration AddPartNumberToProducts part_number:string:index

class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :part_number, :string
    add_index :products, :part_number
  end
end

rails generate migration RemovePartNumberFromProducts part_number:string


class RemovePartNumberFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :part_number, :string
  end
end

You are not limited to one magically generated column. For example:

rails generate migration AddDetailsToProducts part_number:string price:decimal


class AddDetailsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :part_number, :string
    add_column :products, :price, :decimal
  end
end

rails generate migration CreateProducts name:string part_number:string

class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :part_number
    end
  end
end

rails generate migration AddUserRefToProducts user:references


class AddUserRefToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :user, foreign_key: true
  end
end

rails g migration CreateJoinTableCustomerProduct customer product


class CreateJoinTableCustomerProduct < ActiveRecord::Migration[5.0]
  def change
    create_join_table :customers, :products do |t|
      # t.index [:customer_id, :product_id]
      # t.index [:product_id, :customer_id]
    end
  end
end

## Model Generators

# The model and scaffold generators will create migrations 
# appropriate for adding a new model. 
# This migration will already contain instructions 
# for creating the relevant table. 
# If you tell Rails what columns you want, 
# then statements for adding these columns 
# will also be created. 


rails generate model Product name:string description:text

class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
 
      t.timestamps
    end
  end
end

##  Passing Modifiers
rails generate migration AddDetailsToProducts 'price:decimal{5,2}' supplier:references{polymorphic}

class AddDetailsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price, :decimal, precision: 5, scale: 2
    add_reference :products, :supplier, polymorphic: true
  end
end

## Writing a Migration

create_table :products do |t|
  t.string :name
end

create_table :products, options: "ENGINE=BLACKHOLE" do |t|
  t.string :name, null: false
end

create_join_table :products, :categories
# which creates a categories_products table 
# with two columns called category_id and product_id. 
# These columns have the option :null set 
# to false by default. 
# This can be overridden by specifying 
# the :column_options option:
create_join_table :products, :categories, column_options: { null: true }


create_join_table :products, :categories, table_name: :categorization

create_join_table :products, :categories do |t|
  t.index :product_id
  t.index :category_id
end


change_table :products do |t|
  t.remove :description, :name
  t.string :part_number
  t.index :part_number
  t.rename :upccode, :upc_code
end

# This changes the column part_number on products table to be a :text field. Note that change_column command is irreversible.
change_column :products, :part_number, :text


change_column_null :products, :name, false
change_column_default :products, :approved, from: true, to: false


add_foreign_key :articles, :authors


## When Helpers aren't Enough

Product.connection.execute("UPDATE products SET price = 'free' WHERE 1=1")

## Running Migrations

rails db:migrate VERSION=20080906120000


rails db:rollback
rails db:rollback STEP=3
rails db:migrate:redo STEP=3

rails db:setup
rails db:drop
rails db:setup























