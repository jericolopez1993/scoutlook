class Activity < ApplicationRecord
  audited
  has_many_attached :proposal_pdf
  has_one_attached :credit_application
  before_save :set_open_and_close_date
  after_destroy :remove_children

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

  def rep
    if !self.rep_id.nil?
      Rep.find(self.rep_id)
    else
      nil
    end
  end

  def client
    if !self.client_id.nil?
      Client.find(self.client_id)
    else
      nil
    end
  end

  private
    def remove_children
      ActivityOutcome.where(:id => self.outcome_id).destroy_all
    end
end
