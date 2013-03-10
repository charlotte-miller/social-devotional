require 'spec_helper'

describe "questions/new" do
  before(:each) do
    assign(:question, stub_model(Question,
      :lesson_id => 1,
      :group_id => 1,
      :text => "MyText",
      :answers_count => 1
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path, :method => "post" do
      assert_select "input#question_lesson_id", :name => "question[lesson_id]"
      assert_select "input#question_group_id", :name => "question[group_id]"
      assert_select "textarea#question_text", :name => "question[text]"
      assert_select "input#question_answers_count", :name => "question[answers_count]"
    end
  end
end
