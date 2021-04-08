class User < ApplicationRecord
  attr_accessor :skip_password_validation
  include Auditable
  rolify
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_one :carrier_contact
  has_one :shipper_contact

  def display_name
    "<a href='/users'>Users</a>"
  end

  def full_name
    (self.first_name.nil? ? '' : self.first_name.titleize) + " " + (self.last_name.nil? ? '' : self.last_name.titleize)
  end

  def carrier_categories_to_array
    if self.carrier_categories.nil?
      [false, false, false, false]
    else
      self.carrier_categories.split(',').collect {|x| x == "true" }
    end
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.current_action
    Thread.current[:action]
  end

  def self.current_action=(action)
    Thread.current[:action] = action
  end

  protected
   def password_required?
     return false if skip_password_validation
     super
   end
end
