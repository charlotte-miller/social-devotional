require "spec_helper"

describe StudiesController do
  describe "routing" do

    it "routes to #index" do
      get("/library").should route_to("studies#index")
    end

    it "routes to #show" do
      get("/library/1").should route_to("studies#show", :id => "1")
    end
    
  end
end
