require 'test_helper'

class SControllerTest < ActionController::TestCase
  test "should get manage:get" do
    get :manage:get
    assert_response :success
  end

end
