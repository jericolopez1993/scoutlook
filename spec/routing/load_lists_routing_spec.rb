require "rails_helper"

RSpec.describe LoadListsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/load_lists").to route_to("load_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/load_lists/new").to route_to("load_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/load_lists/1").to route_to("load_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/load_lists/1/edit").to route_to("load_lists#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/load_lists").to route_to("load_lists#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/load_lists/1").to route_to("load_lists#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/load_lists/1").to route_to("load_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/load_lists/1").to route_to("load_lists#destroy", :id => "1")
    end
  end
end
