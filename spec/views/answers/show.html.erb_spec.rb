require 'spec_helper'

describe "answers/show" do
  before(:each) do
    @question = assign(:question, build_stubbed(:question))
    @answer = assign(:answer, build_stubbed(:answer,
      :question => @question,
      # :author => nil,
      # :source_id => 1,
      # :source_type => "Source Type",
      :text => "MyText",
      :blocked_count => 2,
      :stared_count => 3
    ))
  end

  it "renders attributes in <p>" do
    pending 'better test/tempate'
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    # rendered.should match(/1/)
    # rendered.should match(/Source Type/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
