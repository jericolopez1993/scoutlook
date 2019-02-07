require 'rails_helper'

RSpec.describe "load_tiles/new", type: :view do
  before(:each) do
    assign(:load_tile, LoadTile.new(
      :name => "MyString",
      :status => "MyString",
      :origin => "MyString",
      :destination => "MyString",
      :details => "MyText"
    ))
  end

  it "renders new load_tile form" do
    render

    assert_select "form[action=?][method=?]", load_tiles_path, "post" do

      assert_select "input[name=?]", "load_tile[name]"

      assert_select "input[name=?]", "load_tile[status]"

      assert_select "input[name=?]", "load_tile[origin]"

      assert_select "input[name=?]", "load_tile[destination]"

      assert_select "textarea[name=?]", "load_tile[details]"
    end
  end
end
