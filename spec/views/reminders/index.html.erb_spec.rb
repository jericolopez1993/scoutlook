require 'rails_helper'

RSpec.describe "reminders/index", type: :view do
  before(:each) do
    assign(:reminders, [
      Reminder.create!(
        :carrier_id => 2,
        :shipper_id => 3,
        :activity_id => 4,
        :user_id => 5,
        :reminder_interval => 6,
        :recurring => false
      ),
      Reminder.create!(
        :carrier_id => 2,
        :shipper_id => 3,
        :activity_id => 4,
        :user_id => 5,
        :reminder_interval => 6,
        :recurring => false
      )
    ])
  end

  it "renders a list of reminders" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
