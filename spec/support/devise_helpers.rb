def login_user
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