require 'spec_helper'

describe "Meetings" do
  describe "GET groups/:group_id/meetings" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get group_meetings_path(@group)
      response.status.should be(200)
    end
  end
end
