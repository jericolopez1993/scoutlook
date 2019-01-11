class MoveShipperAndCarrierActivities < ActiveRecord::Migration[5.2]
  def change
    # CarrierActivity.all.each do |ca|
    #   Activity.create(:outcome => ca.outcome.outcome, :reason  => ca.outcome.reason, :reason_other  => ca.outcome.reason_other, :notes  => ca.outcome.notes, :date_stamp => ca.date_stamp, :activity_type => ca.activity_type, :engagement_type => ca.engagement_type, :carrier_id => ca.carrier_id, :carrier_contact_id => ca.loads_per_week, :user_id => ca.user_id, :annual_value => ca.annual_value, :loads_per_week => ca.loads_per_week, :status => ca.status, :date_opened => ca.date_opened, :date_closed => ca.date_closed, :other_notes => ca.activity_type, :campaign_name => ca.campaign_name)
    # end
    # ShipperActivity.all.each do |ca|
    #   Activity.create(:outcome => ca.outcome.outcome, :reason  => ca.outcome.reason, :reason_other  => ca.outcome.reason_other, :notes  => ca.outcome.notes, :date_stamp => ca.date_stamp, :activity_type => ca.activity_type, :engagement_type => ca.engagement_type, :shipper_id => ca.shipper_id, :shipper_contact_id => ca.loads_per_week, :user_id => ca.user_id, :annual_value => ca.annual_value, :loads_per_week => ca.loads_per_week, :status => ca.status, :date_opened => ca.date_opened, :date_closed => ca.date_closed, :other_notes => ca.activity_type, :campaign_name => ca.campaign_name)
    # end
    drop_table :carrier_activities
    drop_table :shipper_activities
    drop_table :carrier_activity_outcomes
    drop_table :shipper_activity_outcomes
  end
end
