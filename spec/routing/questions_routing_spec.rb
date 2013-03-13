require "spec_helper"

describe QuestionsController do
  describe "routing" do
    context "within lessons" do
      it "routes to #index" do
        get("/library/1/lessons/1/questions").should route_to("questions#index", study_id:'1', lesson_id:'1')
      end

      it "routes to #new" do
        get("/library/1/lessons/1/questions/new").should route_to("questions#new", study_id:'1', lesson_id:'1')
      end

      it "routes to #show" do
        get("/questions/1").should route_to("questions#show", :id => "1")
      end

      it "routes to #create" do
        post("/library/1/lessons/1/questions").should route_to("questions#create", study_id:'1', lesson_id:'1')
      end

      it "routes to #block" do
        post("/questions/1/block").should route_to("questions#block", :id => "1")
      end
      
      it "routes to #star" do
        post("/questions/1/star").should route_to("questions#star", :id => "1")
      end
    end
    
    context "within meetings" do
      it "routes to #index" do
        get("/groups/1/meetings/1/questions").should route_to("questions#index", :meeting_id => '1', :group_id => '1')
      end

      it "routes to #new" do
        get("/groups/1/meetings/1/questions/new").should route_to("questions#new", :meeting_id => '1', :group_id => '1')
      end

      it "routes to #show" do
        get("/questions/1").should route_to("questions#show", :id => "1")
      end

      it "routes to #create" do
        post("/groups/1/meetings/1/questions").should route_to("questions#create", :meeting_id => '1', :group_id => '1')
      end

      it "routes to #block" do
        post("/questions/1/block").should route_to("questions#block", :id => "1")
      end

      it "routes to #star" do
        post("/questions/1/star").should route_to("questions#star", :id => "1")
      end

    end
  end
end
