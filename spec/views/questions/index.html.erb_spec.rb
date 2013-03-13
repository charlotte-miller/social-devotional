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
      # assert_select "tr>td", :text => 1.to_s, :count => 2
      # assert_select "tr>td", :text => 2.to_s, :count => 2
      # assert_select "tr>td", :text => "MyText".to_s, :count => 2
      # assert_select "tr>td", :text => 3.to_s, :count => 2
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
      # assert_select "tr>td", :text => 1.to_s, :count => 2
      # assert_select "tr>td", :text => 2.to_s, :count => 2
      # assert_select "tr>td", :text => "MyText".to_s, :count => 2
      # assert_select "tr>td", :text => 3.to_s, :count => 2
    end
    
  end
  
end
