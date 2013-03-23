require 'spec_helper'

describe MeetingsController do
  login_user
  let!(:group)  { create(:group)  }
  let!(:meeting){ create(:meeting, group:group) }
  let(:lesson)  { create(:lesson) }
  let(:valid_attributes) { attributes_for(:meeting).merge(group_id: group.id, lesson_id: lesson.id) }
  
  before(:each) do
    group.members << current_user
  end
  
  describe "trying to access logged_in content" do
    it ":index redirects to :index" do
      get :index, {:group_id => group.id}, {}
      should redirect_to(new_user_session_url)
    end
    
    it ":show redirects to :index" do
      get :show, {:group_id => group.id, :id => meeting.to_param}, {}
      should redirect_to(new_user_session_url)
    end

    it ":new redirects to :index" do
      get :new, {:group_id => group.id}, {}
      should redirect_to(new_user_session_url)
    end
    
    it ":edit redirects to :index" do
      get :edit, {:group_id => group.id, :id => meeting.to_param}, {}
      should redirect_to(new_user_session_url)
    end
    
    it ":create redirects to :index" do
      post :create, {:group_id => group.id, :meeting => valid_attributes}, {}
      should redirect_to(new_user_session_url)
    end
    
    it ":update redirects to :index" do
      put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => { "these" => "params" }}, {}
      should redirect_to(new_user_session_url)
    end
    
    it ":destroy redirects to :index" do
      delete :destroy, {:group_id => group.id, :id => meeting.to_param}, {}
      should redirect_to(new_user_session_url)
    end
  end

  describe "GET index" do
    it "loads" do
      get :index, {:group_id => group.id}
      should respond_with(:success)
    end
    
    it "assigns all meetings as @meetings" do
      get :index, {:group_id => group.id}
      assigns(:meetings).should eq([meeting])
    end
  end

  describe "GET show" do
    it "loads" do
      get :show, {:group_id => group.id, :id => meeting.to_param}
      should respond_with(:success)
    end
    
    it "assigns the requested meeting as @meeting" do
      get :show, {:group_id => group.id, :id => meeting.to_param}
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "GET new" do
    it "loads" do
      get :new, {:group_id => group.id}
      should respond_with(:success)
    end
    
    it "assigns a new meeting as @meeting" do
      get :new, {:group_id => group.id}
      assigns(:meeting).should be_a_new(Meeting)
    end
  end

  describe "GET edit" do
    it "assigns the requested meeting as @meeting" do
      get :edit, {:group_id => group.id, :id => meeting.to_param}
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Meeting" do
        expect {
          post :create, {:group_id => group.id, :meeting => valid_attributes}
        }.to change(Meeting, :count).by(1)
      end

      it "assigns a newly created meeting as @meeting" do
        post :create, {:group_id => group.id, :meeting => valid_attributes}
        assigns(:meeting).should be_a(Meeting)
        assigns(:meeting).should be_persisted
      end

      it "redirects to the created meeting" do
        post :create, {:group_id => group.id, :meeting => valid_attributes}
        response.should redirect_to([group, Meeting.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved meeting as @meeting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:group_id => group.id, :meeting => {  }}
        assigns(:meeting).should be_a_new(Meeting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:group_id => group.id, :meeting => {  }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested meeting" do
        # Assuming there are no other meetings in the database, this
        # specifies that the Meeting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Meeting.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => { "these" => "params" }}
      end

      it "assigns the requested meeting as @meeting" do
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => valid_attributes}
        assigns(:meeting).should eq(meeting)
      end

      it "redirects to the meeting" do
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => valid_attributes}
        response.should redirect_to([group, meeting])
      end
    end

    describe "with invalid params" do
      it "assigns the meeting as @meeting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => {  }}
        assigns(:meeting).should eq(meeting)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => {  }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested meeting" do
      expect {
        delete :destroy, {:group_id => group.id, :id => meeting.to_param}
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the meetings list" do
      delete :destroy, {:group_id => group.id, :id => meeting.to_param}
      response.should redirect_to(group_meetings_url(group))
    end
  end

  describe 'private methods' do

    describe '.safe_select_group' do
      
      it "rejects new or logged out users" do
        controller.stub('user_signed_in?'=>false  )
        controller.send( :safe_select_group_and_meeting  )
        should_not assign_to(:meetings)
        should_not assign_to(:meeting)
      end

      describe 'logged in users' do
        login_user
        before(:each) do
          @not_user_group    = group
          @user_group        = create(:group_w_member_and_meeting, new_member:@user)
          @not_user_meeting  = meeting
          @user_meeting      = @user_group.meetings.first
          controller.params[:group_id] = @user_group.id
        end

        it "scopes @group & @meetings to the current user" do      
          controller.send( :safe_select_group_and_meeting )

          assigns(:group).should  eql   @user_group
          assigns(:meetings).should     include(@user_meeting)
          assigns(:meetings).should_not include(@not_user_meeting) 
        end

        it "prevents horizontal privilage escilation from params[:id]" do
          controller.params[:id] = @user_meeting.id
          controller.send( :safe_select_group_and_meeting )

          should assign_to(:group).with(@user_group)
          should assign_to(:meetings).with([@user_meeting])
          should assign_to(:meeting).with(@user_meeting)
        end
      end


    end
    
  end
  
end
