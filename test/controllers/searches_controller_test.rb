require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searches_url
    assert_response :success
  end
end
