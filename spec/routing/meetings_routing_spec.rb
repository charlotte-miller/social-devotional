require "spec_helper"

describe MeetingsController do
  describe "routing" do

    it "routes to #index" do
      get("/groups/1/meetings").should route_to("meetings#index", :group_id => '1')
    end

    it "routes to #new" do
      get("/groups/1/meetings/new").should route_to("meetings#new", :group_id => '1')
    end

    it "routes to #show" do
      get("/groups/1/meetings/1").should route_to("meetings#show", :id => "1", :group_id => '1')
    end

    it "routes to #edit" do
      get("/groups/1/meetings/1/edit").should route_to("meetings#edit", :id => "1", :group_id => '1')
    end

    it "routes to #create" do
      post("/groups/1/meetings").should route_to("meetings#create", :group_id => '1')
    end

    it "routes to #update" do
      put("/groups/1/meetings/1").should route_to("meetings#update", :id => "1", :group_id => '1')
    end

    it "routes to #destroy" do
      delete("/groups/1/meetings/1").should route_to("meetings#destroy", :id => "1", :group_id => '1')
    end

  end
end
