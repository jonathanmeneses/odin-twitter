require "test_helper"

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get feeds_show_url
    assert_response :success
  end
end
