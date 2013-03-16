require 'spec_helper'

describe QuestionsController do

  def valid_attributes
    {text: 'Why did Jonnah try to avoid Gods command to and go to Ninevah'}
    # author = create(:author)
    # FactoryGirl.attributes_for(:question).merge(author: author)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuestionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "loads" do
      get :index, {}, valid_session
      should respond_with(:success)
    end
    
    
    it "assigns all questions as @questions" do
      question = create(:question, valid_attributes)
      get :index, {}, valid_session
      assigns(:questions).should eq([question])
    end
  end

  describe "GET show" do
    it "loads" do
      get :show, {}, valid_session
      should respond_with(:success)
    end
    
    it "assigns the requested question as @question" do
      question = create(:question, valid_attributes)
      get :show, {:id => question.to_param}, valid_session
      assigns(:question).should eq(question)
    end
  end

  describe "GET new" do
    it "loads" do
      get :new, {}, valid_session
      should respond_with(:success)
    end
    
    it "assigns a new question as @question" do
      get :new, {}, valid_session
      assigns(:question).should be_a_new(Question)
    end
  end

  describe "GET edit" do
    it "assigns the requested question as @question" do
      question = create(:question, valid_attributes)
      get :edit, {:id => question.to_param}, valid_session
      assigns(:question).should eq(question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Question" do
        expect {
          post :create, {:question => valid_attributes}, valid_session
        }.to change(Question, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, {:question => valid_attributes}, valid_session
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end

      it "redirects to the created question" do
        post :create, {:question => valid_attributes}, valid_session
        response.should redirect_to(Question.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        # Trigger the behavior that occurs when invalid params are submitted
        Question.any_instance.stub(:save).and_return(false)
        post :create, {:question => { "lesson_id" => "invalid value" }}, valid_session
        assigns(:question).should be_a_new(Question)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Question.any_instance.stub(:save).and_return(false)
        post :create, {:question => { "lesson_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

end
