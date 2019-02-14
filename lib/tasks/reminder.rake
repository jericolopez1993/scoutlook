namespace :reminder do
  desc "TODO"
  task check_due: :environment do
    Reminder.where(:reminder_date => Date.today).each do |reminder|
      reminder.update_attributes(:last_reminded => Date.today)
    end
    Reminder.where(:recurring => false).where('reminder_interval <> 0').each do |reminder|
      if reminder.reminder_date
        if (reminder.reminder_date + reminder.reminder_interval.days) == Date.today
          reminder.update_attributes(:last_reminded => Date.today)
        end
      else
        if (reminder.created_at + reminder.reminder_interval.days) == Date.today
          reminder.update_attributes(:last_reminded => Date.today)
        end
      end
    end
    Reminder.where(:recurring => true).where('reminder_interval <> 0').each do |reminder|
      if reminder.reminder_date
        if ((Date.today - reminder.reminder_date).to_i % reminder.reminder_interval) == 0
          reminder.update_attributes(:last_reminded => Date.today)
        end
      else
        if ((Date.today - reminder.created_at).to_i % reminder.reminder_interval) == 0
          reminder.update_attributes(:last_reminded => Date.today)
        end
      end
    end
  end
end
