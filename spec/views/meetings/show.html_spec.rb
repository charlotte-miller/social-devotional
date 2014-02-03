require 'spec_helper'

describe "meetings/show" do
  before(:each) do
    @meeting = assign(:meeting, stub_model(Meeting))
    assign(:group, stub_model(Group))
  end

  it "renders attributes in <p>" do
    render
  end
end
