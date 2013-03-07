require "spec_helper"

describe Admin::GroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/groups").should route_to("admin/groups#index")
    end

    it "routes to #new" do
      get("/admin/groups/new").should route_to("admin/groups#new")
    end

    it "routes to #show" do
      get("/admin/groups/1").should route_to("admin/groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/groups/1/edit").should route_to("admin/groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/groups").should route_to("admin/groups#create")
    end

    it "routes to #update" do
      put("/admin/groups/1").should route_to("admin/groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/groups/1").should route_to("admin/groups#destroy", :id => "1")
    end

  end
end
