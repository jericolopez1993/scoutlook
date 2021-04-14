require 'rails_helper'

RSpec.describe "PlanningSheets", type: :request do
  describe "GET /planning_sheets" do
    it "works! (now write some real specs)" do
      get planning_sheets_path
      expect(response).to have_http_status(200)
    end
  end
end
