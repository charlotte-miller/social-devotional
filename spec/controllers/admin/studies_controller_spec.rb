require 'spec_helper'

describe Admin::StudiesController do
  login_admin_user
  
  before(:each) do
    # https://github.com/thoughtbot/paperclip/issues/197
    AWS.stub!
  end
  
  let!(:podcast){ create(:podcast) }
  let!(:study){ create(:study, podcast:podcast) }
  let(:valid_attributes){ 
    attributes_for(:study)
    .merge({ podcast_id:podcast.id, title:study.slug })
    .except(:lessons)
    .tap {|hash| hash[:poster_img]= fixture_file_upload(hash[:poster_img].to_path) }
  }
  
  describe "GET index" do
    before(:each) { get :index, {} }
    
    it { should respond_with(:success) }
    it "assigns all studies as @studies" do
      assigns(:studies).should eq([study])
    end
  end

  describe "GET show" do
    before(:each) { get :show, {:id => study.to_param} }
    
    it { should respond_with(:success) }
    it "assigns the requested study as @study" do
      assigns(:study).should eq(study)
    end
  end

  describe "GET new" do
    before(:each) { get :new, {} }
    
    it { should respond_with(:success) }
    it "assigns a new study as @study" do
      assigns(:study).should be_a_new(Study)
    end
  end

  describe "GET edit" do
    before(:each) { get :edit, {:id => study.to_param} }
    
    it { should respond_with(:success) }
    it "assigns the requested study as @study" do
      assigns(:study).should eq(study)
    end
  end

  describe "POST create" do
    describe "with valid params" do    
      it "creates a new Study" do
        expect {
          post :create, {:study => valid_attributes} 
        }.to change(Study, :count).by(1)
      end

      it "assigns a newly created study as @study" do
        post :create, {:study => valid_attributes}
        assigns(:study).should be_a(Study)
        assigns(:study).should be_persisted
      end

      it "redirects to the created study" do
        post :create, {:study => valid_attributes}
        response.should redirect_to( [:admin, Study.last] )
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved study as @study" do
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        post :create, {:study => { "title" => "" }}
        assigns(:study).should be_a_new(Study)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        post :create, {:study => { "title" => "" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do    
      it "updates the requested study" do
        # Assuming there are no other study in the database, this
        # specifies that the Study created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Study.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => study.to_param, :study => { "title" => "MyString" }}
      end

      it "assigns the requested study as @study" do
        put :update, {:id => study.to_param, :study => valid_attributes}
        assigns(:study).should eq(study)
      end

      it "redirects to the study" do
        put :update, {:id => study.to_param, :study => valid_attributes}
        response.should redirect_to( [:admin, study] )
      end
    end

    describe "with invalid params" do
            
      it "assigns the study as @study" do
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        put :update, {:id => study.to_param, :study => { "title" => "" }}
        assigns(:study).should eq(study)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        put :update, {:id => study.to_param, :study => { "title" => "" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested study" do
      expect {
        delete :destroy, {:id => study.to_param}
      }.to change(Study, :count).by(-1)
    end

    it "redirects to the study list" do
      delete :destroy, {:id => study.to_param}
      response.should redirect_to(admin_studies_url) #index
    end
  end

end
