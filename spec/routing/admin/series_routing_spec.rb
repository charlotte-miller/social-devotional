require "spec_helper"

describe Admin::SeriesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/series").should route_to("admin/series#index")
    end

    it "routes to #new" do
      get("/admin/series/new").should route_to("admin/series#new")
    end

    it "routes to #show" do
      get("/admin/series/1").should route_to("admin/series#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/series/1/edit").should route_to("admin/series#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/series").should route_to("admin/series#create")
    end

    it "routes to #update" do
      put("/admin/series/1").should route_to("admin/series#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/series/1").should route_to("admin/series#destroy", :id => "1")
    end

  end
end
