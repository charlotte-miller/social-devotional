require "spec_helper"

describe LessonsController do
  describe "routing" do

    it "routes to #index" do
      get("/library/1/lessons").should route_to("lessons#index", :series_id => '1')
    end

    it "routes to #show" do
      get("/library/1/lessons/1").should route_to("lessons#show", :series_id => '1', :id => "1")
    end
    
  end
end
