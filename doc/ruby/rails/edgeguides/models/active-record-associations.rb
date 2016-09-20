#!/usr/bin/env ruby

## why?
In Rails, an association is a connection between two Active Record models.

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
end
 
class Book < ApplicationRecord
  belongs_to :author
end


@book = @author.books.create(published_at: Time.now)
@author.destroy

## The Types of Associations

- belongs_to
- has_one
- has_many
- has_many :through
- has_one :through
- has_and_belongs_to_many