# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  admin_user_id :integer
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  text          :text
#  answers_count :integer          default(0)
#  blocked_count :integer          default(0)
#  stared_count  :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Question do
  it { should have_many  :answers  } 
  it { should belong_to( :source             )}
  it { should belong_to( :author             )}
  it { should belong_to( :permanent_approver )}
  
  describe 'lesson' do
    context "source is a lesson" do
      it "should have a lesson" do
        pending
      end
    end
    
    context "source is a meeting" do
      it "should have a lesson through meeting" do
        pending
      end
    end
  end

  describe 'scopes' do
    describe 'meetings' do
      
    end
    
    describe 'lessons' do
      
    end
    
    describe 'groups' do
      
    end
    
  end
end
