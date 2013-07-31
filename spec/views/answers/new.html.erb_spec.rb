require 'spec_helper'

describe "answers/new" do
  before(:each) do
    assign(:answer, stub_model(Answer,
      :question => nil,
      :author => nil,
      :source_id => 1,
      :source_type => "MyString",
      :text => "MyText",
      :blocked_count => 1,
      :stared_count => 1
    ).as_new_record)
  end

  it "renders new answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_path, :method => "post" do
      assert_select "input#answer_question", :name => "answer[question]"
      assert_select "input#answer_author", :name => "answer[author]"
      assert_select "input#answer_source_id", :name => "answer[source_id]"
      assert_select "input#answer_source_type", :name => "answer[source_type]"
      assert_select "textarea#answer_text", :name => "answer[text]"
      assert_select "input#answer_blocked_count", :name => "answer[blocked_count]"
      assert_select "input#answer_stared_count", :name => "answer[stared_count]"
    end
  end
end
