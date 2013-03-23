require 'spec_helper'

describe "Lessons" do
  describe "GET /admin/lessons" do
    login_admin_user
    
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_lessons_path
      response.status.should be(200)
    end
  end
end
