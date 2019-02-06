require 'rails_helper'

RSpec.describe "load_lists/edit", type: :view do
  before(:each) do
    @load_list = assign(:load_list, LoadList.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit load_list form" do
    render

    assert_select "form[action=?][method=?]", load_list_path(@load_list), "post" do

      assert_select "input[name=?]", "load_list[name]"
    end
  end
end
