require 'rails_helper'

RSpec.describe "LoadTiles", type: :request do
  describe "GET /load_tiles" do
    it "works! (now write some real specs)" do
      get load_tiles_path
      expect(response).to have_http_status(200)
    end
  end
end
