require 'rails_helper'

RSpec.describe "planning_sheets/index", type: :view do
  before(:each) do
    assign(:planning_sheets, [
      PlanningSheet.create!(
        :sheet_url => "Sheet Url",
        :created_by => 2
      ),
      PlanningSheet.create!(
        :sheet_url => "Sheet Url",
        :created_by => 2
      )
    ])
  end

  it "renders a list of planning_sheets" do
    render
    assert_select "tr>td", :text => "Sheet Url".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
