require 'rails_helper'

RSpec.describe "truck_tiles/new", type: :view do
  before(:each) do
    assign(:truck_tile, TruckTile.new(
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

  it "renders new truck_tile form" do
    render

    assert_select "form[action=?][method=?]", truck_tiles_path, "post" do

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
