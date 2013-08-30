require 'spec_helper'

describe QuestionsController do
  login_user
  
  let!(:question)        { create(:question) }
  let(:valid_attributes) { attributes_for(:question).merge(author: current_user) }

  describe 'from Lesson' do
    let!(:study) { create(:study)}
    let(:lesson) { create(:lesson, study_id:study.id) }
    
    describe "GET index" do
      it "loads" do
        get :index, {study_id:study.id, lesson_id:lesson.id}
        should respond_with(:success)
      end

      it "requires authentication" do
        get :index, {study_id:study.id, lesson_id:lesson.id}, {}#clears current_user
        should redirect_to '/login'
      end

      it "assigns all questions as @questions" do
        get :index, {study_id:study.id, lesson_id:lesson.id}
        assigns(:questions).should eq([question])
      end
    end

    describe "GET show" do
      it "loads" do
        get :show, {study_id:study.id, lesson_id:lesson.id, :id => question.to_param}
        should respond_with(:success)
      end

      it "requires authentication" do
        get :show, {study_id:study.id, lesson_id:lesson.id, :id => question.to_param}, {}#clears current_user
        should redirect_to '/login'
      end

      it "assigns the requested question as @question" do
        get :show, {study_id:study.id, lesson_id:lesson.id, :id => question.to_param}
        assigns(:question).should eq(question)
      end
    end

    describe "GET new" do
      it "loads" do
        get :new, {study_id:study.id, lesson_id:lesson.id}
        should respond_with(:success)
      end

      it "requires authentication" do
        get :index, {study_id:study.id, lesson_id:lesson.id}, {}#clears current_user
        should redirect_to '/login'
      end

      it "assigns a new question as @question" do
        get :new, {study_id:study.id, lesson_id:lesson.id}
        assigns(:question).should be_a_new(Question)
      end
    end

    describe "POST create" do
      it "requires authentication" do
        post :create, {study_id:study.id, lesson_id:lesson.id, :question => valid_attributes}, {}#clears current_user
        should redirect_to '/login'
      end
      
      describe "with valid params" do        
        it "creates a new Question" do
          expect {
            post :create, {study_id:study.id, lesson_id:lesson.id, :question => valid_attributes}
          }.to change(Question, :count).by(1)
        end

        it "assigns a newly created question as @question" do
          post :create, {study_id:study.id, lesson_id:lesson.id, :question => valid_attributes}
          assigns(:question).should be_a(Question)
          assigns(:question).should be_persisted
        end

        it "redirects to the created question" do
          post :create, {study_id:study.id, lesson_id:lesson.id, :question => valid_attributes}
          response.should redirect_to(assigns(:question))
        end
      end

      describe "with invalid params" do        
        it "assigns a newly created but unsaved question as @question" do
          # Trigger the behavior that occurs when invalid params are submitted
          Question.any_instance.stub(:save).and_return(false)
          post :create, {study_id:study.id, lesson_id:lesson.id, :question => { "text" => "" }}
          assigns(:question).should be_a_new(Question)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Question.any_instance.stub(:save).and_return(false)
          post :create, {study_id:study.id, lesson_id:lesson.id, :question => { "text" => "" }}
          response.should render_template("new")
        end
      end
    end

    describe '#current_source' do
      it "should be a Lesson" do
        get :index, {study_id:study.id, lesson_id:lesson.id}
        controller.send(:current_source).should eql lesson
      end 
    end
  end

  describe 'from Group' do
    let!(:group)   { create(:group) }
    let!(:meeting) { create(:meeting) }
      
    describe "GET index" do
      it "loads" do
        get :index, {group_id:group.id, meeting_id:meeting.id}
        should respond_with(:success)
      end

      it "requires authentication" do
        get :index, {group_id:group.id, meeting_id:meeting.id}, {}#clears current_user
        should redirect_to '/login'
      end

      it "assigns all questions as @questions" do
        get :index, {group_id:group.id, meeting_id:meeting.id}
        assigns(:questions).should eq([question])
      end
    end

    describe "GET show" do
      it "loads" do
        get :show, {group_id:group.id, meeting_id:meeting.id, :id => question.to_param}
        should respond_with(:success)
      end

      it "requires authentication" do
        get :show, {group_id:group.id, meeting_id:meeting.id, :id => question.to_param}, {}#clears current_user
        should redirect_to '/login'
      end
      
      it "assigns the requested question as @question" do
        get :show, {group_id:group.id, meeting_id:meeting.id, :id => question.to_param}
        assigns(:question).should eq(question)
      end
    end

    describe "GET new" do
      it "loads" do
        get :new, {group_id:group.id, meeting_id:meeting.id}
        should respond_with(:success)
      end
      
      it "requires authentication" do
        get :new, {group_id:group.id, meeting_id:meeting.id}, {}#clears current_user
        should redirect_to '/login'
      end

      it "assigns a new question as @question" do
        get :new, {group_id:group.id, meeting_id:meeting.id}
        assigns(:question).should be_a_new(Question)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "requires authentication" do
          post :create, {group_id:group.id, meeting_id:meeting.id, :question => valid_attributes}, {}#clears current_user
          should redirect_to '/login'
        end
        
        it "creates a new Question" do
          expect {
            post :create, {group_id:group.id, meeting_id:meeting.id, :question => valid_attributes}
          }.to change(Question, :count).by(1)
        end

        it "assigns a newly created question as @question" do
          post :create, {group_id:group.id, meeting_id:meeting.id, :question => valid_attributes}
          assigns(:question).should be_a(Question)
          assigns(:question).should be_persisted
        end

        it "redirects to the created question" do
          post :create, {group_id:group.id, meeting_id:meeting.id, :question => valid_attributes}
          response.should redirect_to(assigns(:question))
        end
      end

      describe "with invalid params" do
        it "requires authentication" do
          post :create, {group_id:group.id, meeting_id:meeting.id, :question => {"text" => "" } }, {}#clears current_user
          should redirect_to '/login'
        end
        
        it "assigns a newly created but unsaved question as @question" do
          # Trigger the behavior that occurs when invalid params are submitted
          Question.any_instance.stub(:save).and_return(false)
          post :create, {group_id:group.id, meeting_id:meeting.id, :question => { "text" => "" }}
          assigns(:question).should be_a_new(Question)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Question.any_instance.stub(:save).and_return(false)
          post :create, {group_id:group.id, meeting_id:meeting.id, :question => { "text" => "" }}
          response.should render_template("new")
        end
      end
    end

    describe '#current_source' do
      it "should be a Meeting" do
        get :index, {group_id:group.id, meeting_id:meeting.id}
        controller.send(:current_source).should eql meeting 
      end
      
      it "MUST belong to the current_user" do
        pending "something like: return current_user.meetings.find( params.delete(:meeting_id) ) if params[:meeting_id]"
        # could also use something like:
        # current_user.group_memberships.map(&:group_id).include? params[:group_id] 
        # but we should check the users rights to a given meeting not just group :(
      end
    end
  end
  
  describe 'prevent horizontal privalage escalation' do
    it "should only return questions a user has access to" do
      pending('not sure weather to go back to nesting (user has ownership of upstream info) 
               or create a query for checking a users privlages') # leaning toward nesting
    end
  end
  
  # describe 'private methods' do
  #   describe 'before_filters' do
  #     
  #     describe '#merge_author_and_source' do
  #       pending
  #     end
  #     
  #   end
  #   
  # end
end
