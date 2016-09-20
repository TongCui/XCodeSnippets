#!/usr/bin/env ruby


class Client < ApplicationRecord
  has_one :address
  has_many :orders
  has_and_belongs_to_many :roles
end


class Address < ApplicationRecord
  belongs_to :client
end

class Order < ApplicationRecord
  belongs_to :client, counter_cache: true
end

class Role < ApplicationRecord
  has_and_belongs_to_many :clients
end

## Methods


- find
- create_with
- distinct
- eager_load
- extending
- from
- group
- having
- includes
- joins
- left_outer_joins
- limit
- lock
- none
- offset
- order
- preload
- readonly
- references
- reorder
- reverse_order
- select
- distinct
- where

## find

# Find the client with primary key (id) 10.
client = Client.find(10)

SELECT * FROM clients WHERE (clients.id = 10) LIMIT 1

client = Client.find([1, 10]) # Or even Client.find(1, 10)

SELECT * FROM clients WHERE (clients.id IN (1,10))


## take

client = Client.take

SELECT * FROM clients LIMIT 1

client = Client.take(2)

SELECT * FROM clients LIMIT 2

## first
client = Client.first
SELECT * FROM clients ORDER BY clients.id ASC LIMIT 1

client = Client.first(3)
# => [
#   #<Client id: 1, first_name: "Lifo">,
#   #<Client id: 2, first_name: "Fifo">,
#   #<Client id: 3, first_name: "Filo">
# ]

client = Client.order(:first_name).first

SELECT * FROM clients ORDER BY clients.first_name ASC LIMIT 1

## last

client = Client.last
SELECT * FROM clients ORDER BY clients.id DESC LIMIT 1

## find_by
Client.find_by first_name: 'Lifo'

or 

Client.where(first_name: 'Lifo').take

SELECT * FROM clients WHERE (clients.first_name = 'Lifo') LIMIT 1

## Retrieving Multiple Objects in Batches

User.all.each do |user|
  NewsMailer.weekly(user).deliver_now
end

## find_each

# wrong
User.find_each do |user|
  NewsMailer.weekly(user).deliver_now
end

User.where(weekly_subscriber: true).find_each do |user|
  NewsMailer.weekly(user).deliver_now
end


User.find_each(batch_size: 5000) do |user|
  NewsMailer.weekly(user).deliver_now
end


User.find_each(start: 2000) do |user|
  NewsMailer.weekly(user).deliver_now
end


User.find_each(start: 2000, finish: 10000) do |user|
  NewsMailer.weekly(user).deliver_now
end

Invoice.find_in_batches do |invoices|
  export.add_invoices(invoices)
end

## where


Client.where("orders_count = #{params[:orders]}")

Client.where("created_at >= :start_date AND created_at <= :end_date",
  {start_date: params[:start_date], end_date: params[:end_date]})

## Ordering

Client.order(created_at: :desc)
# OR
Client.order(created_at: :asc)
# OR
Client.order("created_at DESC")
# OR
Client.order("created_at ASC")

## Selecting Specific Fields

Client.select("viewable_by, locked")


Client.select(:name).distinct

SELECT DISTINCT name FROM clients

query = Client.select(:name).distinct
# => Returns unique names
 
query.distinct(false)
# => Returns all names, even if there are duplicates


## Group
#
Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")

SELECT date(created_at) as ordered_date, sum(price) as total_price
FROM orders
GROUP BY date(created_at)

## only

Article.where('id > 10').limit(20).order('id desc').only(:order, :where)Array


SELECT * FROM articles WHERE id > 10 ORDER BY id DESC
 
# Original query without `only`
SELECT "articles".* FROM "articles" WHERE (id > 10) ORDER BY id desc LIMIT 20
