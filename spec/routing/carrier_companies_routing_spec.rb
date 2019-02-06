require "rails_helper"

RSpec.describe CarrierCompaniesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/carrier_companies").to route_to("carrier_companies#index")
    end

    it "routes to #new" do
      expect(:get => "/carrier_companies/new").to route_to("carrier_companies#new")
    end

    it "routes to #show" do
      expect(:get => "/carrier_companies/1").to route_to("carrier_companies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/carrier_companies/1/edit").to route_to("carrier_companies#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/carrier_companies").to route_to("carrier_companies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/carrier_companies/1").to route_to("carrier_companies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/carrier_companies/1").to route_to("carrier_companies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/carrier_companies/1").to route_to("carrier_companies#destroy", :id => "1")
    end
  end
end
