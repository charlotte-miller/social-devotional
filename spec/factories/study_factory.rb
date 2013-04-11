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



FactoryGirl.define do
  factory :study do
    podcast
    sequence( :slug ) {|n| "matthew-study#{n}"}
    title "Matthew Study - Chapter by Chapter"
    description "We work through book of Matthew chapter by chapter using the inductive method"
    ref_link "http://link.com/salt-and-light"
    # video_url "https://s3.amazonaws.com/CornerstoneMedia/121125_SPECIAL.m4v"
    # poster_img 'http://media.cornerstone-sf.org/uploads/tv/series/media_player_master_music_1.jpg'
  end
  
  factory :study_w_lesson, parent: 'study' do
    ignore do
      new_lesson {FactoryGirl.create(:lesson)}
    end
    lessons {[new_lesson]}
  end
end
