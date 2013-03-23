require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the QuestionsHelper. For example:
#
# describe QuestionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe QuestionsHelper do
  
  describe 'polymorphic_questions_path' do
    let(:question) { create(:question, id:100) }
    
    it "requires @lesson or @meeting" do
      lambda { helper.polymorphic_questions_path }.should raise_error(ArgumentError)
    end
    
    context "library" do
      before(:each) do
        assign :study, build_stubbed(:study, slug: 'matthew-study')
        assign :lesson, build_stubbed(:lesson, id: 1)
      end
      
      it "should build index/create" do
        helper.polymorphic_questions_path.should == '/library/matthew-study/lessons/1/questions' #match %r{ /library/matthew-study/lessons/\d/questions }
      end

      it "should build new" do
        helper.polymorphic_questions_path('new').should == '/library/matthew-study/lessons/1/questions/new'
      end
      
      it "should build show" do
        helper.polymorphic_questions_path(question).should == '/questions/100' #match %r{ /library/matthew-study/lessons/\d/questions }
      end
      
    end
    
    context "groups" do
      before(:each) do
        assign :group,   build_stubbed(:group,    id: 1)
        assign :meeting, build_stubbed(:meeting,  id: 1)
      end
      
      it "should build index/create" do
        helper.polymorphic_questions_path.should == '/groups/1/meetings/1/questions' #match %r{ /library/matthew-study/lessons/\d/questions }
      end

      it "should build new" do
        helper.polymorphic_questions_path('new').should == '/groups/1/meetings/1/questions/new'
      end
      
      it "should build show" do
        helper.polymorphic_questions_path(question).should == '/questions/100' #match %r{ /library/matthew-study/lessons/\d/questions }
      end

    end
    
  end
end
