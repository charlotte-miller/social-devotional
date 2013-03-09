require "spec_helper"

describe SeriesController do
  describe "routing" do

    it "routes to #index" do
      get("/library").should route_to("series#index")
    end

    it "routes to #show" do
      get("/library/1").should route_to("series#show", :id => "1")
    end
    
  end
end
