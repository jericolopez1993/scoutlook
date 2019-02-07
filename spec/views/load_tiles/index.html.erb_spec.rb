require 'rails_helper'

RSpec.describe "load_tiles/index", type: :view do
  before(:each) do
    assign(:load_tiles, [
      LoadTile.create!(
        :name => "Name",
        :status => "Status",
        :origin => "Origin",
        :destination => "Destination",
        :details => "MyText"
      ),
      LoadTile.create!(
        :name => "Name",
        :status => "Status",
        :origin => "Origin",
        :destination => "Destination",
        :details => "MyText"
      )
    ])
  end

  it "renders a list of load_tiles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Origin".to_s, :count => 2
    assert_select "tr>td", :text => "Destination".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
