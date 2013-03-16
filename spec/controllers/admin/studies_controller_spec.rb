require 'spec_helper'


describe Admin::StudiesController do

  def valid_attributes
    { "slug" => "MyString" }
  end

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end
  
  describe "GET index" do
    it "assigns all studies as @studies" do
      studies = Study.create! valid_attributes
      get :index, {}
      assigns(:studies).should eq([studies])
    end
  end

  describe "GET show" do
    it "assigns the requested study as @study" do
      study = Study.create! valid_attributes
      get :show, {:id => study.to_param}
      assigns(:study).should eq(study)
    end
  end

  describe "GET new" do
    it "assigns a new study as @study" do
      get :new, {}
      assigns(:study).should be_a_new(Study)
    end
  end

  describe "GET edit" do
    it "assigns the requested study as @study" do
      study = Study.create! valid_attributes
      get :edit, {:id => study.to_param}
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
        response.should redirect_to(Study.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved study as @study" do
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        post :create, {:study => { "slug" => "invalid value" }}
        assigns(:study).should be_a_new(Study)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        post :create, {:study => { "slug" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested study" do
        study = Study.create! valid_attributes
        # Assuming there are no other study in the database, this
        # specifies that the Study created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Study.any_instance.should_receive(:update_attributes).with({ "slug" => "MyString" })
        put :update, {:id => study.to_param, :study => { "slug" => "MyString" }}
      end

      it "assigns the requested study as @study" do
        study = Study.create! valid_attributes
        put :update, {:id => study.to_param, :study => valid_attributes}
        assigns(:study).should eq(study)
      end

      it "redirects to the study" do
        study = Study.create! valid_attributes
        put :update, {:id => study.to_param, :study => valid_attributes}
        response.should redirect_to(study)
      end
    end

    describe "with invalid params" do
      it "assigns the study as @study" do
        study = Study.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        put :update, {:id => study.to_param, :study => { "slug" => "invalid value" }}
        assigns(:study).should eq(study)
      end

      it "re-renders the 'edit' template" do
        study = Study.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Study.any_instance.stub(:save).and_return(false)
        put :update, {:id => study.to_param, :study => { "slug" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested study" do
      study = Study.create! valid_attributes
      expect {
        delete :destroy, {:id => study.to_param}
      }.to change(Study, :count).by(-1)
    end

    it "redirects to the study list" do
      study = Study.create! valid_attributes
      delete :destroy, {:id => study.to_param}
      response.should redirect_to(study_index_url)
    end
  end

end
