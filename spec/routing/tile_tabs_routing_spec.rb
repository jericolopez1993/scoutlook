require "rails_helper"

RSpec.describe TileTabsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tile_tabs").to route_to("tile_tabs#index")
    end

    it "routes to #new" do
      expect(:get => "/tile_tabs/new").to route_to("tile_tabs#new")
    end

    it "routes to #show" do
      expect(:get => "/tile_tabs/1").to route_to("tile_tabs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tile_tabs/1/edit").to route_to("tile_tabs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tile_tabs").to route_to("tile_tabs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tile_tabs/1").to route_to("tile_tabs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tile_tabs/1").to route_to("tile_tabs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tile_tabs/1").to route_to("tile_tabs#destroy", :id => "1")
    end
  end
end
