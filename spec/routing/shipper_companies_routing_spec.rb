require "rails_helper"

RSpec.describe ShipperCompaniesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/shipper_companies").to route_to("shipper_companies#index")
    end

    it "routes to #new" do
      expect(:get => "/shipper_companies/new").to route_to("shipper_companies#new")
    end

    it "routes to #show" do
      expect(:get => "/shipper_companies/1").to route_to("shipper_companies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shipper_companies/1/edit").to route_to("shipper_companies#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/shipper_companies").to route_to("shipper_companies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shipper_companies/1").to route_to("shipper_companies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shipper_companies/1").to route_to("shipper_companies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shipper_companies/1").to route_to("shipper_companies#destroy", :id => "1")
    end
  end
end
