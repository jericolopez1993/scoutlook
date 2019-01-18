require 'rails_helper'

RSpec.describe "reminders/edit", type: :view do
  before(:each) do
    @reminder = assign(:reminder, Reminder.create!(
      :carrier_id => 1,
      :shipper_id => 1,
      :activity_id => 1,
      :user_id => 1,
      :reminder_interval => 1,
      :recurring => false
    ))
  end

  it "renders the edit reminder form" do
    render

    assert_select "form[action=?][method=?]", reminder_path(@reminder), "post" do

      assert_select "input[name=?]", "reminder[carrier_id]"

      assert_select "input[name=?]", "reminder[shipper_id]"

      assert_select "input[name=?]", "reminder[activity_id]"

      assert_select "input[name=?]", "reminder[user_id]"

      assert_select "input[name=?]", "reminder[reminder_interval]"

      assert_select "input[name=?]", "reminder[recurring]"
    end
  end
end
