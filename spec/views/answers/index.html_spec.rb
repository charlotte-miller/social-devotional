require 'spec_helper'

describe "answers/index" do
  before(:each) do
    @answers = assign(:answers, 2.times.map do
      stub_model(Answer,
        :question => build_stubbed(:question, text:'Hello Foo'),
        :author => build_stubbed(:author, first_name:'Foo'),
        :text => "MyText",
        :blocked_count => 2,
        :stared_count => 3
      )
    end )
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 'Hello Foo', :count => 2
    assert_select "tr>td", :text => 'Foo', :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
