class User < ApplicationRecord
  audited
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
    (self.first_name.nil? ? '' : self.first_name) + " " + (self.last_name.nil? ? '' : self.last_name)
  end
end
