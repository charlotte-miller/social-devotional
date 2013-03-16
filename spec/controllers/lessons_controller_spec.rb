require 'spec_helper'

describe LessonsController do
  let(:study) { create(:study) }
  
  def valid_attributes
    { "study" => study, title: 'Salt and Light'} 
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LessonsController. Be sure to keep this updated too.
  def valid_session
    {}
  end
  
  describe "GET index" do
    it "loads" do
      get :index, {}, valid_session
      should respond_with(:success)
    end
    
    
    it "assigns all lessons as @lessons" do
      lesson = Lesson.create! valid_attributes
      get :index, {study_id: study.id}, valid_session
      assigns(:lessons).should eq([lesson])
    end
    
    it "doesn't include lessons from other study" do
      pending
    end
  end

  describe "GET show" do
    it "loads" do
      get :show, {}, valid_session
      should respond_with(:success)
    end
    
    
    it "assigns the requested lesson as @lesson" do
      lesson = Lesson.create! valid_attributes
      get :show, {study_id: study.id, :id => lesson.to_param}, valid_session
      assigns(:lesson).should eq(lesson)
    end
    
    it "@lesson is from the correct study" do
      pending
    end
  end


end
