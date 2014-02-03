require 'spec_helper'

describe "meetings/edit" do
  before(:each) do
    @group   = assign(:group, stub_model(Group))
    @meeting = assign(:meeting, stub_model(Meeting))
  end

  it "renders the edit meeting form" do
    render

    assert_select "form", :action => group_meetings_path(@group, @meeting), :method => "post" do
    end
  end
end
