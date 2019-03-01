require 'rails_helper'

RSpec.describe "tile_tabs/edit", type: :view do
  before(:each) do
    @tile_tab = assign(:tile_tab, TileTab.create!(
      :name => "MyString",
      :notes => "MyText",
      :created_by => 1
    ))
  end

  it "renders the edit tile_tab form" do
    render

    assert_select "form[action=?][method=?]", tile_tab_path(@tile_tab), "post" do

      assert_select "input[name=?]", "tile_tab[name]"

      assert_select "textarea[name=?]", "tile_tab[notes]"

      assert_select "input[name=?]", "tile_tab[created_by]"
    end
  end
end
