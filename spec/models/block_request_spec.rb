# == Schema Information
#
# Table name: block_requests
#
#  id            :integer          not null, primary key
#  admin_user_id :integer
#  user_id       :integer          not null
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe BlockRequest do
  
  it { should belong_to( :requester ).class_name('User')    }
  it { should belong_to( :approver ).class_name('AdminUser  ')}
  it { should belong_to :source }
  
end
