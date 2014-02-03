require 'spec_helper'

describe "groups/edit" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "MyString",
      :description => "MyText",
      :study_id => 1,
      :created_at => Time.now
    ))
  end

  it "renders the edit group form" do
    render

    assert_select "form", :action => groups_path(@group), :method => "post" do
      assert_select "input#group_name", :name => "group[name]"
      assert_select "textarea#group_description", :name => "group[description]"
      assert_select "input#group_study_id", :name => "group[study_id]"
    end
  end
end
