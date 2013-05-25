require 'spec_helper'

describe "admin/lessons/edit" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :study_id => 1,
      :position => 1,
      :title => "MyString",
      :description => "MyText",
      :backlink => "",
      :video => video_file,
      :audio => audio_file,
      :created_at => Time.now
    ))
  end

  it "renders the edit lesson form" do
    render

    assert_select "form", :action => admin_lessons_path(@lesson), :method => "post" do
      assert_select "input#lesson_study_id", :name => "lesson[study_id]"
      assert_select "input#lesson_position", :name => "lesson[position]"
      assert_select "input#lesson_title", :name => "lesson[title]"
      assert_select "textarea#lesson_description", :name => "lesson[description]"
      assert_select "input#lesson_backlink", :name => "lesson[backlink]"
      assert_select "input#lesson_video", :name => "lesson[video]"
      assert_select "input#lesson_audio", :name => "lesson[audio]"
    end
  end
end
