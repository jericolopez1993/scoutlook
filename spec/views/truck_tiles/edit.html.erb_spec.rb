require 'rails_helper'

RSpec.describe "truck_tiles/edit", type: :view do
  before(:each) do
    @truck_tile = assign(:truck_tile, TruckTile.create!(
      :name => "MyString",
      :status => "MyString",
      :origin => "MyString",
      :destination => "MyString",
      :details => "MyText",
      :carrier_id => 1,
      :shipper_id => 1,
      :priority => 1
    ))
  end

  it "renders the edit truck_tile form" do
    render

    assert_select "form[action=?][method=?]", truck_tile_path(@truck_tile), "post" do

      assert_select "input[name=?]", "truck_tile[name]"

      assert_select "input[name=?]", "truck_tile[status]"

      assert_select "input[name=?]", "truck_tile[origin]"

      assert_select "input[name=?]", "truck_tile[destination]"

      assert_select "textarea[name=?]", "truck_tile[details]"

      assert_select "input[name=?]", "truck_tile[carrier_id]"

      assert_select "input[name=?]", "truck_tile[shipper_id]"

      assert_select "input[name=?]", "truck_tile[priority]"
    end
  end
end
