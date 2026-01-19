require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_sessions_url
    assert_response :success
  end

  test "should get create" do
    get session_url
    assert_response :success
  end

  test "should get destroy" do
    get sessions_url
    assert_response :success
  end
end
