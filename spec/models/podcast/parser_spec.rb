# == Schema Information
#
# Table name: studies
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
#  podcast_id    :integer          not null
#  title         :string(255)      not null
#  description   :string(255)
#  ref_link      :string(255)
#  video_url     :string(255)
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Podcast::Parser do
  
  describe 'new' do
    
  end
  
  describe 'run' do
    
  end
  
end