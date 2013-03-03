require 'spec_helper'

describe Group do
  it { should belong_to( :current_meeting ).class( :meeting )}
  it { should have_many( :members ).through( :group_membership ) } #users
  it { should have_many( :questions ).through( :meetings ) }
  
  
  describe 'a public group' do
    it "cannot be public if the group is private" do
      group = create(:group, public: false)
      lambda { create(:group_membership, public:true) }.should raise_exception #validation error
    end
    
    it ".public scope filters by public " do
      Group.public.to_sql.should match(/`public` = 1/)
    end
  end
  
end
