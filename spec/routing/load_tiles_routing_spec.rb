require "rails_helper"

RSpec.describe LoadTilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/load_tiles").to route_to("load_tiles#index")
    end

    it "routes to #new" do
      expect(:get => "/load_tiles/new").to route_to("load_tiles#new")
    end

    it "routes to #show" do
      expect(:get => "/load_tiles/1").to route_to("load_tiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/load_tiles/1/edit").to route_to("load_tiles#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/load_tiles").to route_to("load_tiles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/load_tiles/1").to route_to("load_tiles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/load_tiles/1").to route_to("load_tiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/load_tiles/1").to route_to("load_tiles#destroy", :id => "1")
    end
  end
end
