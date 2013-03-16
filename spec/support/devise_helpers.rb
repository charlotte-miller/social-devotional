def login_user
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end
end

def login_admin_user
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin_user]
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end
end