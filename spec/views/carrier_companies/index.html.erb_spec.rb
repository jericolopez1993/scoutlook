require 'rails_helper'

RSpec.describe "carrier_companies/index", type: :view do
  before(:each) do
    assign(:carrier_companies, [
      CarrierCompany.create!(
        :name => "Name",
        :city => "City",
        :state => "State",
        :company_type => "Company Type",
        :phone_number => "Phone Number",
        :website => "Website"
      ),
      CarrierCompany.create!(
        :name => "Name",
        :city => "City",
        :state => "State",
        :company_type => "Company Type",
        :phone_number => "Phone Number",
        :website => "Website"
      )
    ])
  end

  it "renders a list of carrier_companies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Company Type".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
  end
end
