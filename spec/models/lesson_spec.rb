# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  series_id   :integer          not null
#  position    :integer          default(0)
#  title       :string(255)      not null
#  description :text
#  backlink    :string(255)
#  video_url   :string(255)
#  audio_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Lesson do
  
  describe 'scopes' do
    describe 'for_series(:series_id)' do
      pending
    end
  end
end
