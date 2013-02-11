require 'spec_helper'

describe "series/edit" do
  before(:each) do
    @series = assign(:series, stub_model(Series,
      :slug => "MyString",
      :title => "MyString",
      :description => "MyString",
      :ref_link => "MyString",
      :video_url => "MyString"
    ))
  end

  it "renders the edit series form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => series_index_path(@series), :method => "post" do
      assert_select "input#series_slug", :name => "series[slug]"
      assert_select "input#series_title", :name => "series[title]"
      assert_select "input#series_description", :name => "series[description]"
      assert_select "input#series_ref_link", :name => "series[ref_link]"
      assert_select "input#series_video_url", :name => "series[video_url]"
    end
  end
end
