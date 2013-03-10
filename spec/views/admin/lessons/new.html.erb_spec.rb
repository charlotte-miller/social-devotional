require 'spec_helper'

describe "lessons/new" do
  before(:each) do
    assign(:lesson, stub_model(Lesson,
      :series_id => 1,
      :position => 1,
      :title => "MyString",
      :description => "MyText",
      :backlink => "",
      :video_url => "MyString",
      :audio_url => "MyString"
    ).as_new_record)
  end

  it "renders new lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lessons_path, :method => "post" do
      assert_select "input#lesson_series_id", :name => "lesson[series_id]"
      assert_select "input#lesson_position", :name => "lesson[position]"
      assert_select "input#lesson_title", :name => "lesson[title]"
      assert_select "textarea#lesson_description", :name => "lesson[description]"
      assert_select "input#lesson_backlink", :name => "lesson[backlink]"
      assert_select "input#lesson_video_url", :name => "lesson[video_url]"
      assert_select "input#lesson_audio_url", :name => "lesson[audio_url]"
    end
  end
end