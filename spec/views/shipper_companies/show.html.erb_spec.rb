require 'rails_helper'

RSpec.describe "shipper_companies/show", type: :view do
  before(:each) do
    @shipper_company = assign(:shipper_company, ShipperCompany.create!(
      :name => "Name",
      :city => "City",
      :state => "State",
      :company_type => "Company Type",
      :phone_number => "Phone Number",
      :website => "Website"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Company Type/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Website/)
  end
end
