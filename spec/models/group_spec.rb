# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  state            :string(50)       not null
#  name             :string(255)      not null
#  desription       :text             default(""), not null
#  is_public        :boolean          default(TRUE)
#  meets_every_days :integer          default(7)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Group do
  it { should have_one(  :current_meeting )}
  it { should have_many( :meetings )}
  it { should have_many( :group_memberships )}
  it { should have_many( :members ).through( :group_memberships ) } #users
  it { should have_many( :questions ) } 
  it { should delegate_method(:meetings=).to(:group_memberships) }
  
  
  describe 'a public group' do
    it "cannot be public if the group is private" do
      group = create(:group, is_public: false)
      lambda { create(:group_membership, is_public:true) }.should raise_exception #validation error
    end
    
    it ".publicly_searchable scope filters by public " do
      sql = Group.publicly_searchable.to_sql
      sql.should match(/`is_public` = 1/)
      sql.should match(/`state` = 'open'/)
    end
  end
  
  describe 'state_machine' do
    describe '.is_currently(:state) scope' do
      it "matches on state" do
        Group.is_currently(:foo).to_sql.should match /`state` = 'foo'/
      end
    end
    
    describe 'open' do
      it "is .accepting_members?" do
        create(:group, state:'open').accepting_members?.should be_true
      end
      

    end
    
  end
  
  
end
