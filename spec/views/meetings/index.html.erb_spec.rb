require 'spec_helper'

describe "meetings/index" do
  before(:each) do
    assign(:meetings, [
      stub_model(Meeting),
      stub_model(Meeting)
    ])
    assign(:group, stub_model(Group))
  end

  it "renders a list of meetings" do
    render
  end
end
