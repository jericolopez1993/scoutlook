require 'rails_helper'

RSpec.describe "TruckTiles", type: :request do
  describe "GET /truck_tiles" do
    it "works! (now write some real specs)" do
      get truck_tiles_path
      expect(response).to have_http_status(200)
    end
  end
end
