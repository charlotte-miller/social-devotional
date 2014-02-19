require 'spec_helper'

describe StudiesController do
  let!(:study)  { create(:study_w_lesson) }
  let(:podcast) { study.podcast  }
  let(:valid_attributes) { attributes_for(:study, podcast: podcast).merge({podcast_id: podcast.id}) }
  let(:valid_session) { {} }

  describe "GET index" do
    it "loads" do
      get :index, {}, valid_session
      should respond_with(:success)
    end
    
    it "assigns all studies as @studies" do
      get :index, {}, valid_session
      assigns(:studies).should eq([study])
    end
    
    describe 'search=keyswords' do
      
    end
  end

  describe "GET show" do
    describe "ALWAYS" do
      it "assigns the requested study as @study" do
        get :show, {:id => study.to_param}, valid_session
        assigns(:study).should eq(study)
      end
    
      it "follows an old friendly_id" do
        study = create(:study)
        old_title = study.to_param
        new_title = study.update_attributes(title:'New Title') && study.to_param
        get :show, {:id => old_title}, valid_session
        should redirect_to( study_url(study) )
      end
    end
    
    describe "HTML" do
      it "loads" do
        get :show, {:id => study.to_param}, valid_session
        should respond_with(:redirect)
      end
    
      it "redirects to the first lesson in the study" do
        get :show, {:id => study.to_param}, valid_session
        should redirect_to(study_lesson_url(study, study.lessons.first))
      end
    
      it "redirects to current_user's last viewed lesson" do
        pending
      end
    end
    
    describe "JSON" do
      it "loads" do
        get :index, {study_id:study.to_param, format:'json'}, valid_session
        should respond_with(:success)
      end
    end
  end

end
