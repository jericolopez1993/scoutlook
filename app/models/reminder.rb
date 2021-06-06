# action_taken:
#       0 = nil
#       1 = Action Taken
#       2 = Deleted
#       3 = Ignored

class Reminder < ApplicationRecord
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  belongs_to :activity, optional: true
  belongs_to :user, optional: true
  # before_save :notify_users
  after_save :update_computed_data

  validate :reminder_date_cannot_be_in_the_past

  scope :incomplete, -> do
    where(:completed => false).order('created_at DESC')
  end

   def reminder_date_cannot_be_in_the_past
     if self.new_record?
       puts "#{self.reminder_date}"
       if  self.reminder_date < Time.now
         errors.add(:reminder_date, "can't be in the past")
       end
     else
       unchanged_reminder = Reminder.find(self.id)
       if self.reminder_date.present? && self.reminder_date < Date.today && unchanged_reminder.reminder_date != self.reminder_date
         errors.add(:reminder_date, "can't be in the past")
       end
     end
   end

  def update_computed_data
    ComputeDataService.new.reminder(self.carrier_id)
    GlobalSummaryServices.new.run
    if self.shipper_id
      ComputedDataShippersService.new.reminder(self.shipper_id)
    end
  end

  def reminder_date_str
    self.reminder_date.strftime("%Y-%m-%d %H:%M %p")
  end

  def notify_users
    user = self.user
    reminder = self.to_json(:methods => :reminder_date_str)
    # reminder.push({"reminder_date_str" => self.reminder_date.strftime("%Y-%m-%d %H:%M")})
    # reminder['reminder_date_str'] = self.reminder_date.strftime("%Y-%m-%d %H:%M")
    RemindersChannel.broadcast_to user, data: reminder
  end

  def display_name
      "<a href='/reminders/#{self.id}'>Reminder</a>"
  end

  scope :listings, -> {select("
    reminders.*,
    carriers.company_name AS carrier_name,
    shippers.company_name AS shipper_name,
    activities.shipper_id AS activity_shipper_id,
    activities.carrier_id AS activity_carrier_id,
    activities.campaign_name AS campaign_name,
    (SELECT company_name FROM carriers WHERE id = activities.carrier_id LIMIT 1) AS activity_carrier_name,
    (SELECT company_name FROM shippers WHERE id = activities.shipper_id LIMIT 1) AS activity_shipper_name,
    concat_ws(' ', users.first_name, users.last_name) AS user_name
    ").joins("
      LEFT JOIN shippers
      ON shippers.id = reminders.shipper_id
    ").joins("
      LEFT JOIN carriers
      ON carriers.id = reminders.carrier_id
    ").joins("
      LEFT JOIN users
      ON users.id = reminders.user_id
    ").joins("
      LEFT JOIN activities
      ON activities.id = reminders.activity_id
    ").where("
      reminders.action_taken != 2
    ")}

  # default_scope {listings}

  def reminder_date_interval
    current = self.created_at

    if self.reminder_date
      current = self.reminder_date
    end

    if self.reminder_interval > 0
      current = current + self.reminder_interval.days
    end

    return current.strftime("%m/%d/%Y %l:%M %P")
  end

  def reminder_date_reccuring
    current = self.created_at

    if self.reminder_date
      current = self.reminder_date
    end

    if self.reminder_interval > 0
      current = current + self.reminder_interval.days

      if current < Date.today
        until current >= Date.today
          current += self.reminder_interval.days
        end
      end
    end

    current.strftime("%m/%d/%Y %l:%M %P")
  end

  def self.interval_to_text(reminder_interval)
    if reminder_interval == 1
      "every day"
    elsif reminder_interval == 7
      "by-weekly"
    elsif reminder_interval == 30
      "by-monthly"
    elsif reminder_interval == 90
      "by-quarterly"
    elsif reminder_interval == 360
      "by-yearly"
    else
      "every #{reminder_interval} days"
    end
  end

  def get_next_reminder_date
    reminder_date = self.next_reminder_date

    unless self.next_reminder_date
      reminder_date = self.created_at

      if self.reminder_date
        reminder_date = self.reminder_date
      end
    end

    return reminder_date
  end

  def self.compute_next_reminder_date(reminder)
    if reminder.completed
      return "Done"
    end

    reminder_date = reminder.get_next_reminder_date

    if reminder.recurring
      reminder_date = "#{reminder_date} (#{Reminder.interval_to_text(reminder.reminder_interval)} recurring from #{reminder.reminder_date.strftime("%m/%d/%Y %l:%M %P")})"
    elsif reminder.reminder_interval
      reminder_date = "#{reminder_date} (#{Reminder.interval_to_text(reminder.reminder_interval)} from #{reminder.created_at.strftime("%m/%d/%Y %l:%M %P")})"
    end

    return reminder_date
  end

end
