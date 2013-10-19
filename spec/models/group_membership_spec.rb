# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  is_public  :boolean          default(TRUE)
#  role_level :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe GroupMembership do
  it { should belong_to( :member ).class_name( 'User' )}
  it { should belong_to :group }
  
  it "builds from factory", :internal do
    lambda { create(:group_membership) }.should_not raise_error
  end
  
  
  describe 'a public membership' do
    it "cannot be public if the group is private" do
      @group = create(:group,   is_public: false)
      create(:group_membership, is_public:true, group:@group).reload.is_public.should be_false #validation error
    end
    
    it ".is_public scope filters by is_public " do
      GroupMembership.is_public.to_sql.should match(/`is_public` = 1/)
    end
  end
  
  
end
