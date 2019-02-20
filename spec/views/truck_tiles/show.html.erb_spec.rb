require 'rails_helper'

RSpec.describe "truck_tiles/show", type: :view do
  before(:each) do
    @truck_tile = assign(:truck_tile, TruckTile.create!(
      :name => "Name",
      :status => "Status",
      :origin => "Origin",
      :destination => "Destination",
      :details => "MyText",
      :carrier_id => 2,
      :shipper_id => 3,
      :priority => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Origin/)
    expect(rendered).to match(/Destination/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
