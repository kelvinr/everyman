def set_current_user(user=nil)
  session[:user_id] = (user ||= Fabricate(:user)).id
end

def login(a_user=nil)
  user = a_user ||= Fabricate(:user)
  visit login_path
  fill_in "Username / Email", with: user.username
  fill_in "Password", with: user.password
  click_button "Login"
end
