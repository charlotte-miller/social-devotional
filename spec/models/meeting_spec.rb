# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  lesson_id  :integer          not null
#  position   :integer          default(0), not null
#  state      :string(50)       not null
#  date_of    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Meeting do
  it { should belong_to :group  }
  it { should belong_to :lesson }
  
  it "builds from factory", :internal do
    lambda { create(:meeting) }.should_not raise_error
  end
end
