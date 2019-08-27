class Reminder < ApplicationRecord
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  belongs_to :activity, optional: true
  belongs_to :user, optional: true
  before_save :notify_users
  after_save :update_computed_data

  def update_computed_data
    ComputeDataService.new.reminder(self.carrier_id)
    if self.shipper_id
      ComputeDataShippersService.new.reminder(self.shipper_id)
    end
  end

  def notify_users
    if last_reminded_changed?
      ReminderBroadcastJob.perform_later self
    end
  end

  def display_name
      "<a href='/reminders/#{self.id}'>Reminder</a>"
  end

  scope :listings, -> {select("reminders.*, carriers.company_name AS carrier_name, shippers.company_name AS shipper_name, activities.shipper_id AS activity_shipper_id, activities.carrier_id AS activity_carrier_id, (SELECT company_name FROM carriers WHERE id = activities.carrier_id LIMIT 1) AS activity_carrier_name, (SELECT company_name FROM shippers WHERE id = activities.shipper_id LIMIT 1) AS activity_shipper_name, concat_ws(' ', users.first_name, users.last_name) AS user_name").joins("LEFT JOIN shippers ON shippers.id = reminders.shipper_id").joins("LEFT JOIN carriers ON carriers.id = reminders.carrier_id").joins("LEFT JOIN users ON users.id = reminders.user_id").joins("LEFT JOIN activities ON activities.id = reminders.activity_id")}

  default_scope {listings}

  def reminder_date_interval
    if self.reminder_date
      date = self.reminder_date + self.reminder_interval.days
      date.strftime("%m/%d/%Y")
    elsif self.reminder_date.nil?
      date = self.created_at + self.reminder_interval.days
      date.strftime("%m/%d/%Y")
    elsif self.reminder_interval.nil?
      date = nil
    end
  end

  def reminder_date_reccuring
    if self.reminder_date
      current = self.reminder_date + self.reminder_interval.days
      until current >= Date.today
        current += self.reminder_interval.days
      end
      current.strftime("%m/%d/%Y")
    else
      current = self.created_at + self.reminder_interval.days
      until current >= Date.today
        current += self.reminder_interval.days
      end
      current.strftime("%m/%d/%Y")
    end
  end
end
