require 'rails_helper'

RSpec.describe "planning_sheets/edit", type: :view do
  before(:each) do
    @planning_sheet = assign(:planning_sheet, PlanningSheet.create!(
      :sheet_url => "MyString",
      :created_by => 1
    ))
  end

  it "renders the edit planning_sheet form" do
    render

    assert_select "form[action=?][method=?]", planning_sheet_path(@planning_sheet), "post" do

      assert_select "input[name=?]", "planning_sheet[sheet_url]"

      assert_select "input[name=?]", "planning_sheet[created_by]"
    end
  end
end
