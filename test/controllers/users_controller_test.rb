require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_users_url
    assert_response :success
  end

  test "should get create" do
    get create_users_url
    assert_response :success
  end

  test "should get edit" do
    get edit_users_url
    assert_response :success
  end

  test "should get update" do
    get update_users_url
    assert_response :success
  end
end
