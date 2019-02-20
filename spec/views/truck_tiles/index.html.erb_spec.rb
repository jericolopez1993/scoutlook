require 'rails_helper'

RSpec.describe "truck_tiles/index", type: :view do
  before(:each) do
    assign(:truck_tiles, [
      TruckTile.create!(
        :name => "Name",
        :status => "Status",
        :origin => "Origin",
        :destination => "Destination",
        :details => "MyText",
        :carrier_id => 2,
        :shipper_id => 3,
        :priority => 4
      ),
      TruckTile.create!(
        :name => "Name",
        :status => "Status",
        :origin => "Origin",
        :destination => "Destination",
        :details => "MyText",
        :carrier_id => 2,
        :shipper_id => 3,
        :priority => 4
      )
    ])
  end

  it "renders a list of truck_tiles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Origin".to_s, :count => 2
    assert_select "tr>td", :text => "Destination".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
