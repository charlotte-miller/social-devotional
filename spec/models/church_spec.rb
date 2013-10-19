# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  homepage   :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Church do
  it { should have_many :podcasts }
  it { should have_many :studies  }
  
  it { should validate_presence_of(:name)     }
  it { should validate_presence_of(:homepage) }
  
  it "builds from factory", :internal do
    lambda { create(:church) }.should_not raise_error
  end
end
