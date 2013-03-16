require 'spec_helper'

describe MeetingsController do
  let(:group)  { create(:group) }
  let(:lesson) { create(:lesson)}
  
  def valid_attributes
    attributes_for(:meeting).merge(group_id: group.id, lesson_id: lesson.id)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MeetingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all meetings as @meetings" do
      meeting = Meeting.create! valid_attributes
      get :index, {:group_id => group.id}, valid_session
      assigns(:meetings).should eq([meeting])
    end
  end

  describe "GET show" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :show, {:group_id => group.id, :id => meeting.to_param}, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "GET new" do
    it "assigns a new meeting as @meeting" do
      get :new, {:group_id => group.id}, valid_session
      assigns(:meeting).should be_a_new(Meeting)
    end
  end

  describe "GET edit" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :edit, {:group_id => group.id, :id => meeting.to_param}, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Meeting" do
        expect {
          post :create, {:group_id => group.id, :meeting => valid_attributes}, valid_session
        }.to change(Meeting, :count).by(1)
      end

      it "assigns a newly created meeting as @meeting" do
        post :create, {:group_id => group.id, :meeting => valid_attributes}, valid_session
        assigns(:meeting).should be_a(Meeting)
        assigns(:meeting).should be_persisted
      end

      it "redirects to the created meeting" do
        post :create, {:group_id => group.id, :meeting => valid_attributes}, valid_session
        response.should redirect_to([group, Meeting.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved meeting as @meeting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:group_id => group.id, :meeting => {  }}, valid_session
        assigns(:meeting).should be_a_new(Meeting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:group_id => group.id, :meeting => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested meeting" do
        meeting = Meeting.create! valid_attributes
        # Assuming there are no other meetings in the database, this
        # specifies that the Meeting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Meeting.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => { "these" => "params" }}, valid_session
      end

      it "assigns the requested meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => valid_attributes}, valid_session
        assigns(:meeting).should eq(meeting)
      end

      it "redirects to the meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => valid_attributes}, valid_session
        response.should redirect_to([group, meeting])
      end
    end

    describe "with invalid params" do
      it "assigns the meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => {  }}, valid_session
        assigns(:meeting).should eq(meeting)
      end

      it "re-renders the 'edit' template" do
        meeting = Meeting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:group_id => group.id, :id => meeting.to_param, :meeting => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested meeting" do
      meeting = Meeting.create! valid_attributes
      expect {
        delete :destroy, {:group_id => group.id, :id => meeting.to_param}, valid_session
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the meetings list" do
      meeting = Meeting.create! valid_attributes
      delete :destroy, {:group_id => group.id, :id => meeting.to_param}, valid_session
      response.should redirect_to(group_meetings_url(group))
    end
  end

end
