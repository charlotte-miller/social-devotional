require 'spec_helper'

describe "questions/index" do

  context "library" do
    before(:each) do
      assign(:questions, 2.times.map { build_stubbed(:question) })
      assign(:study, build_stubbed(:study, slug: 'matthew-study'))
      assign(:lesson, build_stubbed(:lesson, id: 1))
    end

    it "renders a list of questions" do
      render :template => 'questions/index.html.erb'
      assert_select '#new_question_button', :href => '/library/matthew-study/lessons/1/questions'
    end
    
  end
  
  context "group" do
    before(:each) do
      assign(:questions, 2.times.map { build_stubbed(:question) })
      assign(:group,   build_stubbed(:group,   id: 1))
      assign(:meeting, build_stubbed(:meeting, id: 1))
    end

    it "renders a list of questions" do
      render :template => 'questions/index.html.erb'
      
      assert_select '#new_question_button', :href => '/groups/1/meetings/1/questions'
    end
    
  end
  
end
