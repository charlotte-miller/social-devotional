require 'spec_helper'

describe "admin/lessons/index" do
  before(:each) do
    @audio, @video = [audio_file, video_file]
    lessons = assign(:lessons, [
      build_stubbed(Lesson,
        :title => "Road to Damascus Part 1",
        :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
        :backlink => "http://www.church.org/sermon/1234",
        :video => @video,
        :audio => @audio,
      ),
      build_stubbed(Lesson,
        :title => "Road to Damascus Part 2",
        :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
        :backlink => "http://www.church.org/sermon/1235",
        :video => @video,
        :audio => @audio,
      )
    ])
    base_url = 'http://s3.amazonaws.com/social-devotional/test/lessons/\d+'
    @audio_url_matcher = %r`#{base_url}/audios/original/#{@audio.basename}\?\d{10}`
    @video_url_matcher = %r`#{base_url}/videos/original/#{@video.basename}\?\d{10}`
  end

  it "renders a list of lessons" do
    render
    assert_select('.lesson', count: 2)
    
    rendered.should have_content "Road to Damascus Part 1"
    rendered.should have_content "God famously meets us in the low places.  This is a study on God intersecting our high-points"
    rendered.should have_content "http://www.church.org/sermon/1234"
    
    rendered.should have_content @audio.basename
    rendered.should match @audio_url_matcher
    
    rendered.should have_content @video.basename
    rendered.should match @video_url_matcher
  end
end
