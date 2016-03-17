require "rails_helper"

RSpec.describe HospitalProfilesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hospital_profiles").to route_to("hospital_profiles#index")
    end

    it "routes to #new" do
      expect(:get => "/hospital_profiles/new").to route_to("hospital_profiles#new")
    end

    it "routes to #show" do
      expect(:get => "/hospital_profiles/1").to route_to("hospital_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hospital_profiles/1/edit").to route_to("hospital_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hospital_profiles").to route_to("hospital_profiles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hospital_profiles/1").to route_to("hospital_profiles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hospital_profiles/1").to route_to("hospital_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hospital_profiles/1").to route_to("hospital_profiles#destroy", :id => "1")
    end

  end
end
