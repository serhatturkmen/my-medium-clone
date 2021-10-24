require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = User.find(1)
    get user_detail_url user
    assert_response :success
  end

  test "should get feed" do
    get user_feed_url
    assert_response :success
  end
end
