class Activity < ApplicationRecord
  has_one_attached :proposal_pdf
  has_one_attached :credit_application
  before_save :set_open_and_close_date

  def set_open_and_close_date
    if self.status
      self.date_opened = Time.now.getutc
    else
      self.date_closed = Time.now.getutc
    end
  end

  def outcome
    if !self.outcome_id.nil?
      ActivityOutcome.find(self.outcome_id)
    else
      ActivityOutcome.new
    end
  end
end
