class GlobalSummaryServices
  def run
    reminder_total = Reminder.incomplete.length
    reminder_ids = Reminder.incomplete.limit(10).pluck(:id)
    log_total = Log.today.length
    log_ids = Log.today.limit(10).pluck(:id)

    GlobalSummary.delete_all
    summary = GlobalSummary.new
    summary.reminder_total = reminder_total
    summary.reminder_ids = reminder_ids
    summary.log_total = log_total
    summary.log_ids = log_ids
    summary.last_updated_by = nil
    summary.save
  end
end
