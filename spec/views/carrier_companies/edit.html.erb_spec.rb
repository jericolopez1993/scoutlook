require 'rails_helper'

RSpec.describe "carrier_companies/edit", type: :view do
  before(:each) do
    @carrier_company = assign(:carrier_company, CarrierCompany.create!(
      :name => "MyString",
      :city => "MyString",
      :state => "MyString",
      :company_type => "MyString",
      :phone_number => "MyString",
      :website => "MyString"
    ))
  end

  it "renders the edit carrier_company form" do
    render

    assert_select "form[action=?][method=?]", carrier_company_path(@carrier_company), "post" do

      assert_select "input[name=?]", "carrier_company[name]"

      assert_select "input[name=?]", "carrier_company[city]"

      assert_select "input[name=?]", "carrier_company[state]"

      assert_select "input[name=?]", "carrier_company[company_type]"

      assert_select "input[name=?]", "carrier_company[phone_number]"

      assert_select "input[name=?]", "carrier_company[website]"
    end
  end
end
