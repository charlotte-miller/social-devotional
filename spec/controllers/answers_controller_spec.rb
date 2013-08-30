require 'spec_helper'

describe AnswersController do
  login_user
  
  let(:question) { create(:question) }
  let(:answer)   { create(:answer, question:question)}
  let(:valid_attributes) { attributes_for(:answer).slice(:text) }
  let(:valid_session) { {} }

  describe "GET index" do
    before(:each) { answer } #create
    
    it "loads" do
      get :index, {question_id:question.id}
      should respond_with(:success)
    end
    
    it "requires authentication" do
      get :index, {question_id:question.id}, {}#clears current_user
      should redirect_to '/login'
    end
    
    it "assigns all answers as @answers" do
      get :index, {question_id:question.id}
      assigns(:answers).should eq([answer])
    end
  end

  describe "GET show" do
    before(:each) { answer } #create
    
    it "loads" do
      get :show, {:id => answer.to_param}
      should respond_with(:success)
    end

    it "requires authentication" do
      get :show, {:id => answer.to_param}, {}#clears current_user
      should redirect_to '/login'
    end
    
    it "assigns the requested answer as @answer" do
      get :show, {:id => answer.to_param}
      assigns(:answer).should eq(answer)
    end
  end

  describe "POST create" do
    it "requires authentication" do
      post :create, {question_id:question.id, :answer => valid_attributes}, {}#clears current_user
      should redirect_to '/login'
    end
    
    describe "with valid params" do
      it "creates a new Answer" do
        expect {
          post :create, {question_id:question.id, :answer => valid_attributes}
        }.to change(Answer, :count).by(1)
      end

      it "assigns a newly created answer as @answer" do
        post :create, {question_id:question.id, :answer => valid_attributes}
        assigns(:answer).should be_a(Answer)
        assigns(:answer).should be_persisted
      end

      it "redirects to the created answer" do
        post :create, {question_id:question.id, :answer => valid_attributes}
        response.should redirect_to(Answer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved answer as @answer" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        post :create, {question_id:question.id, :answer => { "text" => "" }}
        assigns(:answer).should be_a_new(Answer)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        post :create, {question_id: question.id, :answer => { "text" => "" }}
        response.should render_template("show")
      end
    end
  end

  describe "PUT update" do
    it "requires authentication" do
      put :update, {:id => answer.to_param, :answer => { "text" => "foo" }}, {}#clears current_user
      should redirect_to '/login'
    end
    
    it "is accessable only by the original author" do
      pending
      put :update, {:id => answer.to_param, :answer => { "text" => "foo" }}
    end
    
    describe "with valid params" do
      before(:each) { answer } #create
      
      it "updates the requested answer" do
        Answer.any_instance.should_receive(:update_attributes).with({ "text" => "foo" })
        put :update, {:id => answer.to_param, :answer => { "text" => "foo" }}
      end

      it "assigns the requested answer as @answer" do
        put :update, {:id => answer.to_param, :answer => valid_attributes}
        assigns(:answer).should eq(answer)
      end

      it "redirects to the answer" do
        put :update, {:id => answer.to_param, :answer => valid_attributes}
        response.should redirect_to(answer)
      end
    end

    describe "with invalid params" do
      it "assigns the answer as @answer" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        put :update, {:id => answer.to_param, :answer => { "text" => "" }}
        assigns(:answer).should eq(answer)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        put :update, {:id => answer.to_param, :answer => { "text" => "" }}
        response.should render_template("show")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) { answer } #create
    
    it "requires authentication" do
      delete :destroy, {:id => answer.to_param}, {}#clears current_user
      should redirect_to '/login'
    end
    
    it "is accessable only by the original author" do
      pending
      delete :destroy, {:id => answer.to_param}
    end
    
    it "destroys the requested answer" do
      expect {
        delete :destroy, {:id => answer.to_param}
      }.to change(Answer, :count).by(-1)
    end

    it "redirects to the answers list" do
      delete :destroy, {:id => answer.to_param}
      response.should redirect_to(question_answers_url(question))
    end
  end

end
