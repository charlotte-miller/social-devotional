require 'spec_helper'

describe StudiesController do
  let(:podcast) { create(:podcast) }

  def valid_attributes
    attributes_for(:study, podcast: podcast).merge({podcast_id: podcast.id})
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StudiesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "loads" do
      get :index, {}, valid_session
      should respond_with(:success)
    end
    
    it "assigns all studies as @studies" do
      studies = Study.create! valid_attributes
      get :index, {}, valid_session
      assigns(:studies).should eq([studies])
    end
    
    describe 'search=keyswords' do
      
    end
  end

  describe "GET show" do
    it "loads" do
      get :show, {}, valid_session
      should respond_with(:success)
    end
    
    it "assigns the requested study as @study" do
      study = Study.create! valid_attributes
      get :show, {:id => study.to_param}, valid_session
      assigns(:study).should eq(study)
    end
    
    it "follows an old friendly_id" do
      pending
    end
  end

end
