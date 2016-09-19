#!/usr/bin/env ruby

## Validations Overview

class Person < ApplicationRecord
  validates :name, presence: true
end
 
Person.create(name: "John Doe").valid? # => true
Person.create(name: nil).valid? # => false

## When Does Validation Happen?

$ bin/rails console
>> p = Person.new(name: "John Doe")
=> #<Person id: nil, name: "John Doe", created_at: nil, updated_at: nil>
>> p.new_record?
=> true
>> p.save
=> true
>> p.new_record?
=> false

# If any validations fail, the object will be marked as invalid 
# and Active Record will not perform the INSERT or UPDATE operation.

# The following methods trigger validations, 
# and will save the object to the database only 
# if the object is valid:

- create
- create!
- save
- save!
- update
- update!

# Note that save also has the ability to skip validations if passed validate:
# false as an argument. This technique should be used with caution.

save(validate: false)

# Note that an object instantiated with new will not report errors 
# even if it's technically invalid, 
# because validations are automatically run 
# only when the object is saved, 
# such as with the create or save methods.



class Person < ApplicationRecord
  validates :name, presence: true
end
 
>> p = Person.new
# => #<Person id: nil, name: nil>
>> p.errors.messages
# => {}
 
>> p.valid?
# => false
>> p.errors.messages
# => {name:["can't be blank"]}
 
>> p = Person.create
# => #<Person id: nil, name: nil>
>> p.errors.messages
# => {name:["can't be blank"]}
 
>> p.save
# => false
 
>> p.save!
# => ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
 
>> Person.create!
# => ActiveRecord::RecordInvalid: Validation failed: Name can't be blank


## errors[]

class Person < ApplicationRecord
  validates :name, presence: true
end
 
>> Person.new.errors[:name].any? # => false
>> Person.create.errors[:name].any? # => true


## errors.details


class Person < ApplicationRecord
  validates :name, presence: true
end
 
>> person = Person.new
>> person.valid?
>> person.errors.details[:name] # => [{error: :blank}]

## acceptance

# This method validates that a checkbox on the user interface was checked when a form was submitted.

class Person < ApplicationRecord
  validates :terms_of_service, acceptance: true
end


class Person < ApplicationRecord
  validates :terms_of_service, acceptance: { message: 'must be abided' }
end

# It can also receive an :accept option, 
# which determines the allowed values that 
# will be considered as accepted. 
# It defaults to ['1', true] and can be easily changed.

class Person < ApplicationRecord
  validates :terms_of_service, acceptance: { accept: 'yes' }
  validates :eula, acceptance: { accept: ['TRUE', 'accepted'] }
end

## validates_associated

# You should use this helper when your model has associations 
# with other models and they also need to be validated. 

# When you try to save your object, valid? 
# will be called upon each one of the associated objects.

class Library < ApplicationRecord
  has_many :books
  validates_associated :books
end

# Don't use validates_associated on both ends of your associations. T
# hey would call each other in an infinite loop.


## confirmation


class Person < ApplicationRecord
  validates :email, confirmation: true
end

```
<%= text_field :person, :email %>
<%= text_field :person, :email_confirmation %>
```

class Person < ApplicationRecord
  # This option defaults to true.
  validates :email, confirmation: { case_sensitive: false }
end

## exclusion

class Account < ApplicationRecord
  validates :subdomain, exclusion: { in: %w(www us ca jp),
    message: "%{value} is reserved." }
end

## format

class Product < ApplicationRecord
  # or without
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
end

## inclusion

class Coffee < ApplicationRecord
  validates :size, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size" }
end

## length


class Person < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { is: 6 }
end


class Person < ApplicationRecord
  validates :bio, length: { maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }
end

## numericality

# /\A[+-]?\d+\z/
class Player < ApplicationRecord
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true }
end

## presence
class Person < ApplicationRecord
  validates :name, :login, :email, presence: true
end

# In order to validate associated records whose presence is required, 
# you must specify the :inverse_of option for the association:


class Order < ApplicationRecord
  has_many :line_items, inverse_of: :order
end


validates :boolean_field_name, inclusion: { in: [true, false] }
validates :boolean_field_name, exclusion: { in: [nil] }

## uniqueness


class Account < ApplicationRecord
  validates :email, uniqueness: true
end


class Holiday < ApplicationRecord
  validates :name, uniqueness: { scope: :year,
    message: "should happen once per year" }
end

# Note that some databases are configured to perform case-insensitive searches anyway.

class Person < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
end

## validates_with

class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if record.first_name == "Evil"
      record.errors[:base] << "This person is evil"
    end
  end
end
 
class Person < ApplicationRecord
  validates_with GoodnessValidator
end

class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if options[:fields].any?{|field| record.send(field) == "Evil" }
      record.errors[:base] << "This person is evil"
    end
  end
end
 
class Person < ApplicationRecord
  validates_with GoodnessValidator, fields: [:first_name, :last_name]
end

# If your validator is complex enough that you want instance 
# variables, you can easily use a plain old Ruby object instead:

class Person < ApplicationRecord
  validate do |person|
    GoodnessValidator.new(person).validate
  end
end
 
class GoodnessValidator
  def initialize(person)
    @person = person
  end
 
  def validate
    if some_complex_condition_involving_ivars_and_private_methods?
      @person.errors[:base] << "This person is evil"
    end
  end
 
  # ...
end


## Common Validation Options

1. :allow_nil

class Coffee < ApplicationRecord
  validates :size, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size" }, allow_nil: true
end

2. :allow_blank # like nil or an empty string

class Topic < ApplicationRecord
  validates :title, length: { is: 5 }, allow_blank: true
end

3. :message

validates :name, presence: { message: "must be given please" }

4. :on
# it will be possible to update email with a duplicated value
validates :email, uniqueness: true, on: :create

## Conditional Validation

1. Using a Symbol with :if and :unless
class Order < ApplicationRecord
  validates :card_number, presence: true, if: :paid_with_card?
 
  def paid_with_card?
    payment_type == "card"
  end
end

2. Using a String with :if and :unless

class Person < ApplicationRecord
  validates :surname, presence: true, if: "name.nil?"
end

3. Using a Proc with :if and :unless

class Account < ApplicationRecord
  validates :password, confirmation: true,
    unless: Proc.new { |a| a.password.blank? }
end

class Computer < ApplicationRecord
  validates :mouse, presence: true,
                    if: ["market.retail?", :desktop?],
                    unless: Proc.new { |c| c.trackpad.present? }
end

## Working with Validation Errors

class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end
 
# errors

person = Person.new
person.valid? # => false
person.errors.messages
 # => {:name=>["can't be blank", "is too short (minimum is 3 characters)"]}
 
person = Person.new(name: "John Doe")
person.valid? # => true
person.errors.messages # => {}

# errors[]

person = Person.new(name: "John Doe")
person.valid? # => true
person.errors[:name] # => []
 
person = Person.new(name: "JD")
person.valid? # => false
person.errors[:name] # => ["is too short (minimum is 3 characters)"]
 
person = Person.new
person.valid? # => false
person.errors[:name] # => ["can't be blank", "is too short (minimum is 3 characters)"]

# errors.add
class Person < ApplicationRecord
  def a_method_used_for_validation_purposes
    errors.add(:name, "cannot contain the characters !@#%*()_-+=")
  end
end
 
person = Person.create(name: "!@#")
 
person.errors[:name]
 # => ["cannot contain the characters !@#%*()_-+="]
 
person.errors.full_messages
or 
person.errors.to_a
 # => ["Name cannot contain the characters !@#%*()_-+="]

# errors.details

class Person < ApplicationRecord
  def a_method_used_for_validation_purposes
    errors.add(:name, :invalid_characters)
  end
end
 
person = Person.create(name: "!@#")
 
person.errors.details[:name]
# => [{error: :invalid_characters}]

## Displaying Validation Errors in Views

```
<% if @article.errors.any? %>
  <div id="error_explanation">
    <h2><%= pluralize(@article.errors.count, "error") %> prohibited this article from being saved:</h2>
 
    <ul>
    <% @article.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
    </ul>
  </div>
<% end %>
```















