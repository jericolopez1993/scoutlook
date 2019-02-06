require 'rails_helper'

RSpec.describe "load_lists/show", type: :view do
  before(:each) do
    @load_list = assign(:load_list, LoadList.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
