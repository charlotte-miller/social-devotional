module Devise
  module ControllerHelper
    def login_user
      let(:current_user){ @user }
      before(:each) do       
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user = create(:user)                                 
      end                                                             
    end                                                               
                                                                      
    def login_admin_user                                              
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:admin_user]
        sign_in @admin_user = create(:admin_user)
      end
    end
  end

  module RequestHelper
    def login_user
      let(:current_user){ @user }
      before(:each) do
        @user ||= FactoryGirl.create :user
        post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password      
      end
    end
    
    def login_admin_user
      let(:current_admin_user){ @admin_user }
      before(:each) do
        @admin_user ||= FactoryGirl.create :admin_user
        post_via_redirect admin_user_session_path, 'admin_user[email]' => @admin_user.email, 'admin_user[password]' => @admin_user.password      
      end
    end
  end
end