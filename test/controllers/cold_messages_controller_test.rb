require "test_helper"

class ColdMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cold_messages_new_url
    assert_response :success
  end
end
