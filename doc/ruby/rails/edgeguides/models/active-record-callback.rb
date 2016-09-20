#!/usr/bin/env ruby

## Callback
class User < ApplicationRecord
  validates :login, :email, presence: true
 
  before_validation :ensure_login_has_a_value
 
  protected
    def ensure_login_has_a_value
      if login.nil?
        self.login = email unless email.blank?
      end
    end
end

or 

class User < ApplicationRecord
  validates :login, :email, presence: true
 
  before_create do
    self.name = login.capitalize if name.blank?
  end
end


class User < ApplicationRecord
  before_validation :normalize_name, on: :create
 
  # :on takes an array as well
  after_validation :set_location, on: [ :create, :update ]
 
  protected
    def normalize_name
      self.name = name.downcase.titleize
    end
 
    def set_location
      self.location = LocationService.query(self)
    end
end

## Available Callbacks


3.1 Creating an Object
- before_validation
- after_validation
- before_save
- around_save
- before_create
- around_create
- after_create
- after_save
- after_commit/after_rollback
3.2 Updating an Object
- before_validation
- after_validation
- before_save
- around_save
- before_update
- around_update
- after_update
- after_save
- after_commit/after_rollback
3.3 Destroying an Object
- before_destroy
- around_destroy
- after_destroy






