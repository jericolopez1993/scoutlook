class Reminder < ApplicationRecord
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  belongs_to :activity, optional: true
  belongs_to :user, optional: true

  def display_name
      "<a href='/reminders/#{self.id}'>Reminder</a>"
  end

  def reminder_date_interval
    date = self.created_at + self.reminder_interval.days
    date.strftime("%m/%d/%Y")
  end

  def reminder_date_reccuring
    current = self.created_at + self.reminder_interval.days
    until current >= Date.today
      current += self.reminder_interval.days
    end
    current.strftime("%m/%d/%Y")
  end

end
