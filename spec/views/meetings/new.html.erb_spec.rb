require 'spec_helper'

describe "meetings/new" do
  before(:each) do
    @group = assign(:group, stub_model(Group))
    assign(:meeting, stub_model(Meeting).as_new_record)
  end

  it "renders new meeting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_meetings_path(@group), :method => "post" do
    end
  end
end
