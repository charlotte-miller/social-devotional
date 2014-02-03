require 'spec_helper'

describe "admin/studies/edit" do
  before(:each) do
    @study = assign(:study, stub_model(Study,
      :slug => "MyString",
      :title => "MyString",
      :description => "MyString",
      :ref_link => "MyString",
      :created_at => Time.now
    ))
  end

  it "renders the edit studies form" do
    render

    assert_select "form", :action => admin_studies_path(@studies), :method => "post" do
      assert_select "input#study_slug", :name => "studies[slug]"
      assert_select "input#study_title", :name => "studies[title]"
      assert_select "input#study_description", :name => "studies[description]"
      assert_select "input#study_ref_link", :name => "studies[ref_link]"
      # assert_select "input#study_video_url", :name => "studies[video_url]"
    end
  end
end
