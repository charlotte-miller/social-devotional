require "spec_helper"

describe Admin::StudiesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/studies").should route_to("admin/studies#index")
    end

    it "routes to #new" do
      get("/admin/studies/new").should route_to("admin/studies#new")
    end

    it "routes to #show" do
      get("/admin/studies/1").should route_to("admin/studies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/studies/1/edit").should route_to("admin/studies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/studies").should route_to("admin/studies#create")
    end

    it "routes to #update" do
      put("/admin/studies/1").should route_to("admin/studies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/studies/1").should route_to("admin/studies#destroy", :id => "1")
    end

  end
end
