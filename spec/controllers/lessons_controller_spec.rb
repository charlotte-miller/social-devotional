require 'spec_helper'

describe LessonsController do
  let!(:study)           { create(:study) }
  let!(:lesson)          { create(:lesson, study:study) }
  let(:valid_attributes) { attributes_for(:lesson, study:study) }
  let(:valid_session)    { {} }
  
  describe "GET index" do
    it "loads" do
      get :index, {study_id:study.id}, valid_session
      should respond_with(:success)
    end
    
    
    it "assigns all lessons as @lessons and @study" do
      get :index, {study_id: study.id}, valid_session
      should assign_to(:lessons).with([lesson])
      should assign_to(:study).with(study)
    end
    
    it "doesn't include lessons from other study" do
      pending
    end
  end

  describe "GET show" do
    it "loads" do
      get :show, {study_id: study.id, :id => lesson.to_param}, valid_session
      should respond_with(:success)
    end
    
    
    it "assigns the requested lesson as @lesson by :position" do
      get :show, {study_id: study.id, :id => lesson.to_param}, valid_session
      assigns(:lesson).should eq(lesson)
    end
    
    it "@lesson is from the correct study" do
      pending
    end
  end


end
