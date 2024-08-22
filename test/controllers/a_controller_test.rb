require "test_helper"

class AControllerTest < ActionDispatch::IntegrationTest
  test "should get admin/posts" do
    get a_admin/posts_url
    assert_response :success
  end
end
