require 'rails_helper'

RSpec.describe "planning_sheets/show", type: :view do
  before(:each) do
    @planning_sheet = assign(:planning_sheet, PlanningSheet.create!(
      :sheet_url => "Sheet Url",
      :created_by => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sheet Url/)
    expect(rendered).to match(/2/)
  end
end
