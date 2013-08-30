require 'spec_helper'

describe "groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :name => "MyString",
      :description => "MyText",
      :study_id => 1,
      :created_at => Time.now
    ).as_new_record)
  end

  it "renders new group form" do
    render

    assert_select "form", :action => groups_path, :method => "post" do
      assert_select "input#group_name", :name => "group[name]"
      assert_select "textarea#group_description", :name => "group[description]"
      assert_select "input#group_study_id", :name => "group[study_id]"
    end
  end
end
