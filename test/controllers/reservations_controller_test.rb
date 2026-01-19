require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:room_one)
    @reservation = reservations(:one)
    log_in_as(@user)
  end

  test "should get new" do
    # GET /rooms/:room_id/reservation/new
    get new_room_reservation_url(@room)
    assert_response :success
  end

  test "should create reservation" do
    # POST /rooms/:room_id/reservation
    post room_reservation_url(@room), params: { reservation: { check_in: Date.today, check_out: Date.today + 1.day, people: 2 } }
    assert_response :success
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end
end
