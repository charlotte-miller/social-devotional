require 'spec_helper'

describe StudiesController do

  def valid_attributes
    podcast = create(:podcast)
    attributes_for(:study, podcast: podcast).merge({podcast_id: podcast.id})
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StudiesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all studies as @studies" do
      studies = Study.create! valid_attributes
      get :index, {}, valid_session
      assigns(:studies).should eq([studies])
    end
  end

  describe "GET show" do
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
