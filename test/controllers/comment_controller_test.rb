require "test_helper"

class CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get comment_create_url
    assert_response :success
  end

  test "should get show" do
    get comment_show_url
    assert_response :success
  end

  test "should get accept" do
    get comment_accept_url
    assert_response :success
  end
end
