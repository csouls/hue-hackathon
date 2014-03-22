require "spec_helper"

describe BeaconsController do
  describe "routing" do

    it "routes to #index" do
      get("/beacons").should route_to("beacons#index")
    end

    it "routes to #new" do
      get("/beacons/new").should route_to("beacons#new")
    end

    it "routes to #show" do
      get("/beacons/1").should route_to("beacons#show", :id => "1")
    end

    it "routes to #edit" do
      get("/beacons/1/edit").should route_to("beacons#edit", :id => "1")
    end

    it "routes to #create" do
      post("/beacons").should route_to("beacons#create")
    end

    it "routes to #update" do
      put("/beacons/1").should route_to("beacons#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/beacons/1").should route_to("beacons#destroy", :id => "1")
    end

  end
end
