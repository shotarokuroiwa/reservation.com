require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:room_one)
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get show" do
    get room_url(@room)
    assert_response :success
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end

  test "should create room" do
    post rooms_url, params: { room: { name: "New Room", price: 1000, address: "Test", user_id: @room.user_id } }
    assert_response :success
  end

  test "should get edit" do
    get edit_room_url(@room)
    assert_response :success
    log_in_as(@user)
  end

  test "should update room" do
    patch room_url(@room), params: { room: { name: "Updated" } }
    assert_response :success
  end

  test "should destroy room" do
    delete room_url(@room)
    assert_response :redirect
  end
end
