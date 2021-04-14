require 'rails_helper'

RSpec.describe "planning_sheets/new", type: :view do
  before(:each) do
    assign(:planning_sheet, PlanningSheet.new(
      :sheet_url => "MyString",
      :created_by => 1
    ))
  end

  it "renders new planning_sheet form" do
    render

    assert_select "form[action=?][method=?]", planning_sheets_path, "post" do

      assert_select "input[name=?]", "planning_sheet[sheet_url]"

      assert_select "input[name=?]", "planning_sheet[created_by]"
    end
  end
end
