# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  user_id    :integer
#  public     :boolean
#  role_level :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe GroupMembership do
  it { should belong_to( :user ).as( :member )}
  it { should belong_to :group }
  
  
  describe 'a public membership' do
    it "cannot be public if the group is private" do
      group = create(:group, public: false)
      lambda { create(:group_membership, public:true) }.should raise_exception #validation error
    end
    
    it ".public scope filters by public " do
      GroupMembership.public.to_sql.should match(/`public` = 1/)
    end
  end
  
  
end
