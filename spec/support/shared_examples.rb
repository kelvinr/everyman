shared_examples "require login" do
  it "redirects to the login page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to :login
  end
end

shared_examples "require correct user" do
  it "redirects to root and sets flash message" do
    set_current_user
    action
    expect(flash[:danger]).not_to be_nil
    expect(response).to redirect_to :root
  end
end
