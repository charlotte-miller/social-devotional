require 'spec_helper'

describe Admin::LessonsController do
  login_admin_user
  
  before(:each) do
    # https://github.com/thoughtbot/paperclip/issues/197
    AWS.stub!
  end
  
  let!(:study) { create(:study) }
  let!(:lesson){ create(:lesson, study:study)}
  let(:valid_attributes){ 
    attributes_for(:lesson).merge( study_id:study.id)
    .tap {|hash| [:audio, :video, :poster_img].each {|media| hash[media]= fixture_file_upload(hash[media].to_path)} }
  }
  
  describe "GET index" do
    before(:each) { get :index, {} }
    
    it { should respond_with(:success) }
    it "assigns all lessons as @lessons" do
      should assign_to(:lessons).with([lesson])
      # assigns(:lessons).should eq([lesson])
    end
  end

  describe "GET show" do
    before(:each) { get :show, {:id => lesson.to_param} }
    
    it { should respond_with(:success) }    
    it "assigns the requested lesson as @lesson" do
      assigns(:lesson).should eq(lesson)
    end
  end

  describe "GET new" do
    before(:each) { get :new, {} }
    
    it { should respond_with(:success) }
    it "assigns a new lesson as @lesson" do
      assigns(:lesson).should be_a_new(Lesson)
    end
  end

  describe "GET edit" do
    before(:each) { get :edit, {:id => lesson.to_param} }
    
    it { should respond_with(:success) }
    it "assigns the requested lesson as @lesson" do
      assigns(:lesson).should eq(lesson)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Lesson" do
        expect {
          post :create, {:lesson => valid_attributes}
        }.to change(Lesson, :count).by(1)
      end

      it "assigns a newly created lesson as @lesson" do
        post :create, {:lesson => valid_attributes}
        assigns(:lesson).should be_a(Lesson)
        assigns(:lesson).should be_persisted
      end

      it "redirects to the created lesson" do
        post :create, {:lesson => valid_attributes}
        response.should redirect_to([:admin, Lesson.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved lesson as @lesson" do
        # Trigger the behavior that occurs when invalid params are submitted
        Lesson.any_instance.stub(:save).and_return(false)
        post :create, {:lesson => { "study_id" => "invalid value" }}
        assigns(:lesson).should be_a_new(Lesson)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Lesson.any_instance.stub(:save).and_return(false)
        post :create, {:lesson => { "study_id" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested lesson" do
        # Assuming there are no other lessons in the database, this
        # specifies that the Lesson created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Lesson.any_instance.should_receive(:update_attributes).with({ "study_id" => "1" })
        put :update, {:id => lesson.to_param, :lesson => { "study_id" => "1" }}
      end

      it "assigns the requested lesson as @lesson" do
        put :update, {:id => lesson.to_param, :lesson => valid_attributes}
        assigns(:lesson).should eq(lesson)
      end

      it "redirects to the lesson" do
        put :update, {:id => lesson.to_param, :lesson => valid_attributes}
        response.should redirect_to([:admin, lesson])
      end
    end

    describe "with invalid params" do
      it "assigns the lesson as @lesson" do
        # Trigger the behavior that occurs when invalid params are submitted
        Lesson.any_instance.stub(:save).and_return(false)
        put :update, {:id => lesson.to_param, :lesson => { "study_id" => "invalid value" }}
        assigns(:lesson).should eq(lesson)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Lesson.any_instance.stub(:save).and_return(false)
        put :update, {:id => lesson.to_param, :lesson => { "study_id" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested lesson" do
      expect {
        delete :destroy, {:id => lesson.to_param}
      }.to change(Lesson, :count).by(-1)
    end

    it "redirects to the lessons list" do
      delete :destroy, {:id => lesson.to_param}
      response.should redirect_to(admin_lessons_url)
    end
  end

end
