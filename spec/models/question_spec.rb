# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  source_id     :integer
#  source_type   :string(255)
#  text          :text
#  answers_count :integer
#  blocked_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Question do
  it { should have_many :answers  } 
  it { should belong_to( :meetings ) }
  it { should belong_to( :lessons  ) }
  
  
end
