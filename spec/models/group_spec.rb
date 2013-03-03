require 'spec_helper'

describe Group do
  
  it { should have_many( :members ).through(:group_membership) } #users
  it { should have_many( :questions ) }
  
  
  describe '.public scope' do
    it "filters by public " do
      Group.public.to_sql.should match(/`public` = 1/)
    end
  end
  
end
