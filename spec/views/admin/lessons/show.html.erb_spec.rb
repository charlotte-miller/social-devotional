require 'spec_helper'

describe "admin/lessons/show" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :study_id => 1,
      :position => 2,
      :title => "Title",
      :description => "MyText",
      :backlink => "backlink",
      :video => video_file,
      :audio => audio_file,
      :created_at => Time.now
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/backlink/)
    rendered.should match( url_to_regex(@lesson.video.url) )
    rendered.should match( url_to_regex(@lesson.audio.url) )
  end
end
