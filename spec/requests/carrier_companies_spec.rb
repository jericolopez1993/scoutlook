require 'rails_helper'

RSpec.describe "CarrierCompanies", type: :request do
  describe "GET /carrier_companies" do
    it "works! (now write some real specs)" do
      get carrier_companies_path
      expect(response).to have_http_status(200)
    end
  end
end
