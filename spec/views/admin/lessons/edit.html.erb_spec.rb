require 'spec_helper'

describe "admin/lessons/edit" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :study_id => 1,
      :position => 1,
      :title => "MyString",
      :description => "MyText",
      :backlink => "",
      :video_url => "MyString",
      :audio_url => "MyString",
      :created_at => Time.now
    ))
  end

  it "renders the edit lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_lessons_path(@lesson), :method => "post" do
      assert_select "input#lesson_study_id", :name => "lesson[study_id]"
      assert_select "input#lesson_position", :name => "lesson[position]"
      assert_select "input#lesson_title", :name => "lesson[title]"
      assert_select "textarea#lesson_description", :name => "lesson[description]"
      assert_select "input#lesson_backlink", :name => "lesson[backlink]"
      assert_select "input#lesson_video_url", :name => "lesson[video_url]"
      assert_select "input#lesson_audio_url", :name => "lesson[audio_url]"
    end
  end
end
