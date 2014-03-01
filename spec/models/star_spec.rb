# == Schema Information
#
# Table name: stars
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  source_id   :integer          not null
#  source_type :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Star do
  it "builds from factory" do
    lambda { create(:star) }.should_not raise_error
  end
end
