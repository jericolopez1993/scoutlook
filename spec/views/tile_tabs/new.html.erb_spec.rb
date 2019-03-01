require 'rails_helper'

RSpec.describe "tile_tabs/new", type: :view do
  before(:each) do
    assign(:tile_tab, TileTab.new(
      :name => "MyString",
      :notes => "MyText",
      :created_by => 1
    ))
  end

  it "renders new tile_tab form" do
    render

    assert_select "form[action=?][method=?]", tile_tabs_path, "post" do

      assert_select "input[name=?]", "tile_tab[name]"

      assert_select "textarea[name=?]", "tile_tab[notes]"

      assert_select "input[name=?]", "tile_tab[created_by]"
    end
  end
end
