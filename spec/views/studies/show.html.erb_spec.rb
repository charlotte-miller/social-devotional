require 'spec_helper'

describe "studies/show" do
  before(:each) do
    @lessons = assign(:lessons, [
      stub_model(Lesson,
        :study_id => 1,
        :position => 1,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video => video_file,
        :audio => audio_file,
        :created_at => Time.now,
        :study_title => 'Matthew Study'
      ),
      stub_model(Lesson,
        :study_id => 1,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video => video_file,
        :audio => audio_file,
        :created_at => Time.now,
        :study_title => 'Matthew Study'
      )
    ])
    @study = assign(:study, build_stubbed(Study,
      :slug => "Slug",
      :title => "Title",
      :description => "Description",
      :ref_link => "Ref Link",
      :lessons => @lessons
    ))
    # @study.stub(lessons:@lessons)
  end

  it "renders attributes in <p>" do
    render
    assert_select "#study"
    
    # rendered.should match(/Slug/)
    # rendered.should match(/Title/)
    # rendered.should match(/Description/)
    # rendered.should match(/Ref Link/)
    rendered.should match(url_to_regex @lessons.first.video.url)
  end
end
