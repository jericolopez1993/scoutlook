class Reminder < ApplicationRecord
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  belongs_to :activity, optional: true
  belongs_to :user, optional: true

  def display_name
      "<a href='/reminders/#{self.id}'>Reminder</a>"
  end
end
