# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
set :output, "log/cron.log"
# Learn more: http://github.com/javan/whenever

every :day, at: ['1:00am','6:00am', '10:00pm', '11:59pm'], roles: [:worker] do
  rake "computed_data:one_time"
  rake "computed_data:carr_news"
  rake "checks_new_carriers:check_and_move"
end

every :hour, roles: [:worker] do
  rake "computed_data:global_summaries"
  rake "computed_data:next_reminder_date"
end
