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
    before(:create, :stub) do
      Study.any_instance.stub({ save_attached_files: true }) if Rails.env.test?
      # DELETE prepare_for_destroy:true
      # OR stub all AWS calls: ``AWS.stub!``
    end
    
    ignore do
      lesson nil
    end
    
    podcast
    lessons { [lesson].compact }
    sequence( :slug ) {|n| "matthew-study#{n}"}
    title       "Matthew Study - Chapter by Chapter"
    description "We work through book of Matthew chapter by chapter using the inductive method"
    ref_link    "http://link.com/salt-and-light"
    poster_img  File.new(Rails.root.join('spec/files', 'poster_image.jpg'), 'r')
  end
  
  factory :study_w_lesson, parent: 'study' do
    lesson {FactoryGirl.create(:lesson)}
  end
  
  # has 'n' number of assocaiated lessons
  factory :study_w_lessons, aliases:[:study_with_n_lessons], parent: 'study' do
    ignore  { n 2 }
    lessons { n.times.map {FactoryGirl.create(:lesson)} }
  end
end
