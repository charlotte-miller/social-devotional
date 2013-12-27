require 'spec_helper'

describe GroupsController do  
  let!(:group){ create(:group) }
  let(:valid_attributes) { attributes_for(:group) }

  describe 'new or logged-out user' do
    
    describe "GET index" do
      let(:load_page!) { get :index, {} }
      
      it "loads" do
        load_page!
        should assign_to(:groups)
        should respond_with(:success)
      end


      it "assigns all groups as @groups" do
        load_page!
        should assign_to(:groups)
        assigns(:groups).should eq([group])
      end
    end

    describe "GET show" do
      let(:load_page!) { get :show, {:id => group.to_param} }
      
      it "loads" do
        load_page!
        should respond_with(:success)
      end


      it "assigns the requested group as @group" do
        load_page!
        assigns(:group).should eq(group)
      end
    end

    describe "trying to access logged_in content" do
      it ":new redirects to :index" do
        get :new, {}
        should redirect_to(new_user_session_url)
      end
      
      it ":show redirects to :index if a non-public group is attempted" do
        group = create(:group, is_public:false)
        get :show, {:id => group.to_param}
        should redirect_to(new_user_session_url)
      end
      
      it ":edit redirects to :index" do
        get :edit, { :id => group.to_param }
        should redirect_to(new_user_session_url)
      end
      
      it ":create redirects to :index" do
        post :create, {:group => valid_attributes}
        should redirect_to(new_user_session_url)
      end
      
      it ":update redirects to :index" do
        put :update, {:id => group.to_param, :group => { "name" => "MyString" }}
        should redirect_to(new_user_session_url)
      end
      
      it ":destroy redirects to :index" do
        delete :destroy, {:id => group.to_param}
        should redirect_to(new_user_session_url)
      end
    end

  end
  
  describe 'logged-in user' do
    login_user
    before(:each){  group.members << current_user }
    
    describe "GET index" do
      let(:load_page!) { get :index, {} }
      
      it "loads" do
        load_page!
        should respond_with(:success)
      end

      it "assigns all groups as @groups" do
        load_page!
        assigns(:groups).should eq([group])
      end
      
      it "scopes queries to the current_user" do
        load_page!
        pending
      end
    end

    describe "GET show" do
      let(:load_page!) { get :show, { :id => group.to_param } }
      
      it "loads" do
        load_page!
        should respond_with(:success)
      end


      it "assigns the requested @group and @membership" do
        load_page!
        assigns(:group).should eq(group)
        assigns(:membership).should eq(group.group_memberships.first)
      end
      
      it "scopes queries to the current_user" do
        pending
      end
      
      it "updates the users GroupMembership#last_attended_at" do
        Timecop.freeze('12/12/2012') { load_page! }
        current_user.membership_in(group.id).last_attended_at.should eql Time.parse('12/12/2012')
      end
    end

    describe "GET new" do
      it "loads" do
        get :new, {}
        should respond_with(:success)
      end


      it "assigns a new group as @group" do
        get :new, {}
        assigns(:group).should be_a_new(Group)
      end
    end

    describe "GET edit" do
      it "loads" do
        get :edit, { :id => group.to_param }
        should respond_with(:success)
      end


      it "assigns the requested group as @group" do
        get :edit, {:id => group.to_param}
        assigns(:group).should eq(group)
      end
      
      it "scopes queries to the current_user" do
        pending
      end
    end

    describe "POST create" do
      it "sets current_user as 'leader'" do
        pending
        # assigns(:group).leader.should eql current_user
      end
      
      describe "with valid params" do
        it "creates a new Group" do
          expect {
            post :create, {:group => valid_attributes}
          }.to change(Group, :count).by(1)
        end

        it "assigns a newly created group as @group" do
          post :create, {:group => valid_attributes}
          assigns(:group).should be_a(Group)
          assigns(:group).should be_persisted
        end

        it "redirects to the created group" do
          post :create, {:group => valid_attributes}
          response.should redirect_to(Group.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          post :create, {:group => { "name" => "invalid value" }}
          assigns(:group).should be_a_new(Group)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          post :create, {:group => { "name" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested group" do
          # Assuming there are no other groups in the database, this
          # specifies that the Group created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Group.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
          put :update, {:id => group.to_param, :group => { "name" => "MyString" }}
        end

        it "assigns the requested group as @group" do
          put :update, {:id => group.to_param, :group => valid_attributes}
          assigns(:group).should eq(group)
        end

        it "redirects to the group" do
          put :update, {:id => group.to_param, :group => valid_attributes}
          response.should redirect_to(group)
        end
        
        it "scopes updates to the current_user" do
          pending
        end
      end

      describe "with invalid params" do
        it "assigns the group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          put :update, {:id => group.to_param, :group => { "name" => "invalid value" }}
          assigns(:group).should eq(group)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          put :update, {:id => group.to_param, :group => { "name" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested group" do
        expect {
          delete :destroy, {:id => group.to_param}
        }.to change(Group, :count).by(-1)
      end

      it "redirects to the groups list" do
        delete :destroy, {:id => group.to_param}
        response.should redirect_to(groups_url)
      end
    end
    
    it "scopes deletes to the current_user" do
      pending
    end
  end

  describe 'private methods' do

    describe '.safe_select_group' do
      
      it "rejects new or logged out users" do
        controller.stub('user_signed_in?'=>false )
        controller.send( :safe_select_group      )
        should_not assign_to(:groups)
        should_not assign_to(:group)
      end
      
      describe 'logged in users' do
        login_user
        let(:run_private_methods) { [:safe_select_groups, :safe_select_group].each {|meth| controller.send( meth ) } }
        # before(:each){  group.members << current_user }
        
        it "scopes @groups to the current user" do
          not_user_group = group
          user_group     = create(:group_w_member, new_member:@user)
          
          controller.params[:id] = user_group.id
          run_private_methods
          
          should assign_to(:groups)
          assigns(:groups).should     include(user_group)
          assigns(:groups).should_not include(not_user_group) 

        end
        
        it "prevents horizontal privilage escilation from params[:id]" do
          not_user_group = group
          user_group     = create(:group_w_member, new_member:@user)
          
          controller.params[:id] = user_group
          run_private_methods
          
          should assign_to(:groups).with([user_group])
          should assign_to(:group).with(user_group)
        end
      end
      
    end
    
  end
end
