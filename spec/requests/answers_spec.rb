require 'spec_helper'

describe "Answers" do
  describe "GET /answers" do
    login_user
    let(:question) {create(:question)}
    
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get question_answers_path(question)
      response.status.should be(200)
    end
  end
end
