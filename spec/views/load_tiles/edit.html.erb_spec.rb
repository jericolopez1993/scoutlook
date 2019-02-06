require 'rails_helper'

RSpec.describe "load_tiles/edit", type: :view do
  before(:each) do
    @load_tile = assign(:load_tile, LoadTile.create!(
      :name => "MyString",
      :status => "MyString",
      :load_list_id => 1,
      :origin => "MyString",
      :destination => "MyString",
      :details => "MyText"
    ))
  end

  it "renders the edit load_tile form" do
    render

    assert_select "form[action=?][method=?]", load_tile_path(@load_tile), "post" do

      assert_select "input[name=?]", "load_tile[name]"

      assert_select "input[name=?]", "load_tile[status]"

      assert_select "input[name=?]", "load_tile[load_list_id]"

      assert_select "input[name=?]", "load_tile[origin]"

      assert_select "input[name=?]", "load_tile[destination]"

      assert_select "textarea[name=?]", "load_tile[details]"
    end
  end
end
