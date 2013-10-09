require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "get index" do
    get :index
    assert_template :index
  end
end
