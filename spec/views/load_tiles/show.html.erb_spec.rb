require 'rails_helper'

RSpec.describe "load_tiles/show", type: :view do
  before(:each) do
    @load_tile = assign(:load_tile, LoadTile.create!(
      :name => "Name",
      :status => "Status",
      :load_list_id => 2,
      :origin => "Origin",
      :destination => "Destination",
      :details => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Origin/)
    expect(rendered).to match(/Destination/)
    expect(rendered).to match(/MyText/)
  end
end
