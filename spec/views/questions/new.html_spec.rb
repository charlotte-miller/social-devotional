require 'spec_helper'

describe "questions/new" do
  before(:each) do
    assign(:study,  @study  = build_stubbed(:study_w_lesson))
    assign(:lesson, @lesson = @study.lessons.first)
    assign(:question, build_stubbed(:library_question, source:@lesson))
  end

  it "renders new question form" do
    render

    assert_select "form", :action => polymorphic_questions_path, :method => "post" do
      # assert_select "textarea#question_text", :name => "question[text]"
    end
  end
end
