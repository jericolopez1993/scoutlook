require 'rails_helper'

RSpec.describe "tile_tabs/show", type: :view do
  before(:each) do
    @tile_tab = assign(:tile_tab, TileTab.create!(
      :name => "Name",
      :notes => "MyText",
      :created_by => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
