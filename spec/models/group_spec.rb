# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  meeting_id       :integer
#  name             :string(255)      not null
#  desription       :text             default(""), not null
#  is_public        :boolean          default(TRUE)
#  meets_every_days :integer          default(7)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Group do
  it { should belong_to( :current_meeting ).class_name( :meeting )}
  it { should have_many( :members ).through( :group_memberships ) } #users
  it { should have_many( :questions ).through( :meetings ) }
  
  
  describe 'a public group' do
    it "cannot be public if the group is private" do
      group = create(:group, is_public: false)
      lambda { create(:group_membership, is_public:true) }.should raise_exception #validation error
    end
    
    it ".public scope filters by public " do
      Group.is_public.to_sql.should match(/`is_public` = 1/)
    end
  end
  
end
