require 'rails_helper'

RSpec.describe "TileTabs", type: :request do
  describe "GET /tile_tabs" do
    it "works! (now write some real specs)" do
      get tile_tabs_path
      expect(response).to have_http_status(200)
    end
  end
end
