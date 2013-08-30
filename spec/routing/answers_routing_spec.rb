require "spec_helper"

describe AnswersController do
  describe "routing" do

    it "routes to #index" do
      get("/questions/1/answers").should route_to("answers#index", :question_id => "1")
    end

    it "routes to #show" do
      get("/answers/1").should route_to("answers#show", :id => "1")
    end

    it "routes to #create" do
      post("/questions/1/answers").should route_to("answers#create", :question_id => "1")
    end

    it "routes to #update" do
      put("/answers/1").should route_to("answers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/answers/1").should route_to("answers#destroy", :id => "1")
    end

    it "routes to #block" do
      post("/answers/1/block").should route_to("answers#block", :id => "1")
    end

    it "routes to #star" do
      post("/answers/1/star").should route_to("answers#star", :id => "1")
    end
  end
end
