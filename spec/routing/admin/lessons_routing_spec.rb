require "spec_helper"

describe Admin::LessonsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/lessons").should route_to("admin/lessons#index")
    end

    it "routes to #new" do
      get("/admin/lessons/new").should route_to("admin/lessons#new")
    end

    it "routes to #show" do
      get("/admin/lessons/1").should route_to("admin/lessons#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/lessons/1/edit").should route_to("admin/lessons#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/lessons").should route_to("admin/lessons#create")
    end

    it "routes to #update" do
      put("/admin/lessons/1").should route_to("admin/lessons#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/lessons/1").should route_to("admin/lessons#destroy", :id => "1")
    end

  end
end
