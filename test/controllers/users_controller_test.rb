require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @jane = users(:jane)
  end

  test "get :show" do
    get :show, id: @jane

    assert_equal @jane, assigns(:user)
    assert_template :show
  end
end
