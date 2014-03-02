# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  church_id       :integer          not null
#  title           :string(100)      not null
#  build_options   :text
#  last_checked_at :datetime
#  last_updated_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Channel do
  it "builds from factory" do
    lambda { create :channel }.should_not raise_error
  end
end
