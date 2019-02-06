require 'rails_helper'

RSpec.describe "load_lists/new", type: :view do
  before(:each) do
    assign(:load_list, LoadList.new(
      :name => "MyString"
    ))
  end

  it "renders new load_list form" do
    render

    assert_select "form[action=?][method=?]", load_lists_path, "post" do

      assert_select "input[name=?]", "load_list[name]"
    end
  end
end
