require 'spec_helper'

describe "studies/edit" do
  before(:each) do
    @studies = assign(:studies, stub_model(Study,
      :slug => "MyString",
      :title => "MyString",
      :description => "MyString",
      :ref_link => "MyString",
      :video_url => "MyString"
    ))
  end

  it "renders the edit studies form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => studies_path(@studies), :method => "post" do
      assert_select "input#studies_slug", :name => "studies[slug]"
      assert_select "input#studies_title", :name => "studies[title]"
      assert_select "input#studies_description", :name => "studies[description]"
      assert_select "input#studies_ref_link", :name => "studies[ref_link]"
      assert_select "input#studies_video_url", :name => "studies[video_url]"
    end
  end
end
