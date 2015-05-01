shared_examples "require login" do
  it "redirects to the login page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to :login
  end
end
