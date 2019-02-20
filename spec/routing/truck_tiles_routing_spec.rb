require "rails_helper"

RSpec.describe TruckTilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/truck_tiles").to route_to("truck_tiles#index")
    end

    it "routes to #new" do
      expect(:get => "/truck_tiles/new").to route_to("truck_tiles#new")
    end

    it "routes to #show" do
      expect(:get => "/truck_tiles/1").to route_to("truck_tiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/truck_tiles/1/edit").to route_to("truck_tiles#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/truck_tiles").to route_to("truck_tiles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/truck_tiles/1").to route_to("truck_tiles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/truck_tiles/1").to route_to("truck_tiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/truck_tiles/1").to route_to("truck_tiles#destroy", :id => "1")
    end
  end
end
