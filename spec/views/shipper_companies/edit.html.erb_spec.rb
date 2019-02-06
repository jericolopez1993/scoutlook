require 'rails_helper'

RSpec.describe "shipper_companies/edit", type: :view do
  before(:each) do
    @shipper_company = assign(:shipper_company, ShipperCompany.create!(
      :name => "MyString",
      :city => "MyString",
      :state => "MyString",
      :company_type => "MyString",
      :phone_number => "MyString",
      :website => "MyString"
    ))
  end

  it "renders the edit shipper_company form" do
    render

    assert_select "form[action=?][method=?]", shipper_company_path(@shipper_company), "post" do

      assert_select "input[name=?]", "shipper_company[name]"

      assert_select "input[name=?]", "shipper_company[city]"

      assert_select "input[name=?]", "shipper_company[state]"

      assert_select "input[name=?]", "shipper_company[company_type]"

      assert_select "input[name=?]", "shipper_company[phone_number]"

      assert_select "input[name=?]", "shipper_company[website]"
    end
  end
end
