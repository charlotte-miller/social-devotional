require 'spec_helper'

describe "questions/show" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :lesson_id => 1,
      :group_id => 2,
      :text => "MyText",
      :answers_count => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    assert_select "#question"

    # rendered.should match(/1/)
    # rendered.should match(/2/)
    # rendered.should match(/MyText/)
    # rendered.should match(/3/)
  end
end
