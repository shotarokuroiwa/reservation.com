require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    @user = users(:one)
    post session_url, params: { email: @user.email, password: "password" }
    assert_response :success
  end

  test "should destroy session" do
    delete session_url
    assert_response :redirect 
  end
end