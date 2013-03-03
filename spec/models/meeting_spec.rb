# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  lesson_id  :integer
#  date_of    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Meeting do
  it { should belong_to :group  }
  it { should belong_to :lesson }
  
end
