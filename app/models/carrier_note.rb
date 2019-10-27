class CarrierNote < ApplicationRecord
  belongs_to :carrier
  belongs_to :user
end
