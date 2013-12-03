def vcr_lesson_web
  after(:each) { VCR.eject_cassette }
  before(:each) do
    VCR.insert_cassette('lesson_adapters_web', :record => :new_episodes) #:none
  end
end