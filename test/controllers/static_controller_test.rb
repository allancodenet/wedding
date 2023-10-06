require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get terms_of_service" do
    get static_terms_of_service_url
    assert_response :success
  end

  test "should get privacy_policy" do
    get static_privacy_policy_url
    assert_response :success
  end
end
