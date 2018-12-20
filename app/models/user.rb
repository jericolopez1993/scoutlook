class User < ApplicationRecord
  audited
  rolify
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  def display_name
    "<a href='/users'>Users</a>"
  end
  def full_name
    (self.first_name.nil? ? '' : self.first_name) + " " + (self.last_name.nil? ? '' : self.last_name)
  end
  def steward
    begin
      Rep.where(:user_id => self.id).first
    rescue
      nil
    end
  end
  def carrier_contact
    begin
      CarrierContact.find(self.carrier_contact_id)
    rescue
      nil
    end
  end
  def shipper_contact
    begin
      ShipperContact.find(self.shipper_contact_id)
    rescue
      nil
    end
  end
end
