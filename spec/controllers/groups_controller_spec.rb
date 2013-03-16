require 'spec_helper'

describe GroupsController do
  
  
  let!(:group){ create(:group) }

  def valid_attributes
    { "name"        => "Weekly Matthew Study",
      "desription" => 'Go throught the book of Matthew using the inductive method'
    } 
  end
  
  describe 'new or logged-out user' do
    
    describe "GET index" do
      it "loads" do
        get :index, {}
        should respond_with(:success)
      end


      it "assigns all groups as @groups" do
        get :index, {}
        assigns(:groups).should eq([group])
      end
    end

    describe "GET show" do
      it "loads" do
        get :show, {}
        should respond_with(:success)
      end


      it "assigns the requested group as @group" do
        get :show, {:id => group.to_param}
        assigns(:group).should eq(group)
      end
    end

    describe "trying to access logged_in content" do
      it ":new redirects to :index" do
        get :new, {}
        should redirect_to(groups_url)
      end
      
      it ":edit redirects to :index" do
        get :edit, {}
        should redirect_to(groups_url)
      end
      
      it ":create redirects to :index" do
        post :create, {:group => valid_attributes}
        should redirect_to(groups_url)
      end
      
      it ":update redirects to :index" do
        put :update, {:id => group.to_param, :group => { "name" => "MyString" }}
        should redirect_to(groups_url)
      end
      
      it ":destroy redirects to :index" do
        delete :destroy, {:id => group.to_param}
        should redirect_to(groups_url)
      end
    end

  end
  
  describe 'logged-in user' do
    login_user
    
    describe "GET index" do
      it "loads" do
        get :index, {}
        should respond_with(:success)
      end


      it "assigns all groups as @groups" do
        get :index, {}
        assigns(:groups).should eq([group])
      end
      
      it "scopes queries to the current_user" do
        pending
      end
    end

    describe "GET show" do
      it "loads" do
        get :show, {}
        should respond_with(:success)
      end


      it "assigns the requested group as @group" do
        get :show, {:id => group.to_param}
        assigns(:group).should eq(group)
      end
      
      it "scopes queries to the current_user" do
        pending
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
        get :edit, {}
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
        
        it "scopes @groups to the current user" do
          not_user_group = create(:group)
          user_group     = create(:group, member:@user)
          helper.params[:id] = user_group.id
          should assign_to(:groups)
          assigns(:group).should     include(user_group)
          assigns(:group).should_not include(not_user_group) 

        end
        
        it "prevents horizontal privilage escilation from params[:id]" do
          not_user_group = create(:group)
          user_group     = create(:group, member:@user)
          
          helper.params[:id] = create(:group).id
          should assign_to(:groups).with([user_group])
          should assign_to(:group).with(user_group)
        end
      end
      
    end
    
  end
end
