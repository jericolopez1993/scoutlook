require 'rails_helper'

RSpec.describe "ShipperCompanies", type: :request do
  describe "GET /shipper_companies" do
    it "works! (now write some real specs)" do
      get shipper_companies_path
      expect(response).to have_http_status(200)
    end
  end
end
