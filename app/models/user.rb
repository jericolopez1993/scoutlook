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
end
