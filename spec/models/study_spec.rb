# == Schema Information
#
# Table name: studies
#
#  id                      :integer          not null, primary key
#  slug                    :string(255)      not null
#  podcast_id              :integer          not null
#  title                   :string(255)      not null
#  description             :string(255)
#  ref_link                :string(255)
#  video_url               :string(255)
#  poster_img_file_name    :string(255)
#  poster_img_content_type :string(255)
#  poster_img_file_size    :integer
#  poster_img_updated_at   :datetime
#  lessons_count           :integer          default(0)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'spec_helper'

describe Study do
  it { should have_many(:lessons) }
  it { should belong_to(:podcast) }
  it { should have_one(:church).through(:podcast) }
    
  it "should build from factory" do
    lambda { create(:study) }.should_not raise_error
  end
  
  
end
