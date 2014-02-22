require 'spec_helper'

describe "Lessons" do
  let!(:study)  { create(:study_w_lesson) }
  let(:lesson)  { study.lessons.first }
  
  describe "GET library/matthew-study-1/lessons" do  
    it "works! (now write some real specs)" do
      get study_lessons_path(study)
      response.status.should be(302)
    end
  end
  
  describe "GET library/matthew-study-1/lessons/1" do    
    it "works! (now write some real specs)" do
      get study_lesson_path(study, lesson)
      response.status.should be(200)
    end
  end
end
