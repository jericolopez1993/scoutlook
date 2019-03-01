require 'rails_helper'

RSpec.describe "tile_tabs/index", type: :view do
  before(:each) do
    assign(:tile_tabs, [
      TileTab.create!(
        :name => "Name",
        :notes => "MyText",
        :created_by => 2
      ),
      TileTab.create!(
        :name => "Name",
        :notes => "MyText",
        :created_by => 2
      )
    ])
  end

  it "renders a list of tile_tabs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
