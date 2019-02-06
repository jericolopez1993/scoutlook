require 'rails_helper'

RSpec.describe "LoadLists", type: :request do
  describe "GET /load_lists" do
    it "works! (now write some real specs)" do
      get load_lists_path
      expect(response).to have_http_status(200)
    end
  end
end
