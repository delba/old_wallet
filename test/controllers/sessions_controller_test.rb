require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "delete destroy" do
    session[:user_id] = 42

    delete :destroy

    assert_nil session[:user_id]
    assert_redirected_to root_url
  end
end
