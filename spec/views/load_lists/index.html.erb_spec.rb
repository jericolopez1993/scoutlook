require 'rails_helper'

RSpec.describe "load_lists/index", type: :view do
  before(:each) do
    assign(:load_lists, [
      LoadList.create!(
        :name => "Name"
      ),
      LoadList.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of load_lists" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
