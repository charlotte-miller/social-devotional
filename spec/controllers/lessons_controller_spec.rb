require 'spec_helper'

describe LessonsController do
  let!(:study)           { create(:study) }
  let!(:lesson)          { create(:lesson, study:study) }
  let(:valid_attributes) { attributes_for(:lesson, study:study) }
  let(:valid_session)    { {} }
  
  describe "GET index" do    
    describe "ALWAYS" do
      it "assigns all lessons as @lessons and @study" do
        get :index, {study_id: study.to_param}, valid_session
        should assign_to(:lessons).with([lesson])
        should assign_to(:study).with(study)
      end
    
      it "doesn't include lessons from other study" do
        other_lesson = create(:lesson)
        get :index, {study_id: study.to_param}, valid_session
        assigns(:lessons).should_not include(other_lesson)
      end
    end
    
    describe "HTML" do
      it "loads" do
        get :index, {study_id:study.to_param}, valid_session
        should respond_with(:redirect)
      end
      
      it "redirects to the first lesson" do
        get :index, {study_id:study.to_param}, valid_session
        should redirect_to study_lesson_url(study, lesson)
      end
    end
    
    describe "JSON" do
      it "loads" do
        get :index, {study_id:study.to_param, format:'json'}, valid_session
        should respond_with(:success)
      end
    end
  end

  describe "GET show" do
    describe "ALWAYS" do
      it "assigns the requested lesson as @lesson by :position" do
        get :show, {study_id: study.to_param, :id => lesson.to_param}, valid_session
        assigns(:lesson).should eq(lesson)
      end
    
      it "@lesson is from the correct study" do
        get :show, {study_id: study.to_param, :id => lesson.to_param}, valid_session
        assigns(:lesson).study.should eq study
      end
    
      it "follows an old friendly_id" do
        study = create(:study)
        old_title = study.to_param
        new_title = study.update_attributes(title:'New Title') && study.to_param
        get :show, {:study_id => old_title, id:lesson}, valid_session
        should respond_with(:moved_permanently)
        should redirect_to( study_lesson_url(study, lesson) )
      end
    end
    
    describe "HTML" do
      it "loads" do
        get :show, {study_id: study.to_param, :id => lesson.to_param}, valid_session
        should respond_with(:success)
      end
    end
    
    describe "JSON" do
      it "loads" do
        get :show, {study_id: study.to_param, :id => lesson.to_param, format:'json'}, valid_session
        should respond_with(:success)
      end
    end
  end


end
