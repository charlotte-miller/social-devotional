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
    ignore do
      lesson nil    # create an associated @lesson 
      slug   false  # override the generated slug
    end
          
    podcast
    lessons { [lesson].compact }
    title       "Matthew Study - Chapter by Chapter"
    description "We work through book of Matthew chapter by chapter using the inductive method"
    ref_link    "http://link.com/salt-and-light"
    poster_img  File.new(Rails.root.join('spec/files', 'poster_image.jpg'), 'r')
    
    before(:create, :stub) do
      Study.any_instance.stub({ save_attached_files: true }) if Rails.env.test?
      # DELETE prepare_for_destroy:true OR stub all AWS calls: ``AWS.stub!``
    end
    after(:create, :stub) do |study, context|
      stubbing = context.instance_variable_get('@build_strategy').is_a? FactoryGirl::Strategy::Stub
      if slug = context.slug
        study.slug = slug
        study.save! unless stubbing
      end
    end
  end
  
  # creates a study w/ a single lesson
  factory :study_w_lesson, parent: 'study' do
    lesson {FactoryGirl.create(:lesson, study:build_stubbed(:study) )}
  end
  
  # creates a study w/ 'n' number of assocaiated lessons
  factory :study_w_lessons, aliases:[:study_with_n_lessons], parent: 'study' do
    ignore  { n 2 }
    lessons { n.times.map {FactoryGirl.create(:lesson, study:build_stubbed(:study) )} }
  end
end
