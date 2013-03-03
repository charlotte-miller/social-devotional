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
