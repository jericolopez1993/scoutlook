class CarrierActivity < ApplicationRecord
  audited
  has_many_attached :proposal_pdf
  has_one_attached :credit_application
  before_save :set_open_and_close_date
  after_destroy :remove_children

  def display_name
    if self.client.nil?
      "Carrier Activity to #{self.client.display_name}"
    else
      "<a href='/activities/#{self.id}'>Carrier Activity</a>"
    end
  end

  def set_open_and_close_date
    if self.status
      self.date_opened = Time.now.getutc
    else
      self.date_closed = Time.now.getutc
    end
  end

  def outcome
    if !self.outcome_id.nil?
      CarrierActivityOutcome.find(self.outcome_id)
    else
      CarrierActivityOutcome.new
    end
  end

  def user
    begin
      User.find(self.user_id)
    rescue
      nil
    end
  end

  def carrier
    begin
      Carrier.find(self.carrier_id)
    rescue
      nil
    end
  end

  private
    def remove_children
      CarrierActivityOutcome.where(:id => self.outcome_id).destroy_all
    end
end
