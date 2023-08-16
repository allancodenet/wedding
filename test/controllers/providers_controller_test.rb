require "test_helper"

class ProvidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @provider = providers(:one)
  end

  test "should get index" do
    get providers_url
    assert_response :success
  end

  test "should get new" do
    get new_provider_url
    assert_response :success
  end

  test "should create provider" do
    assert_difference("Provider.count") do
      post providers_url, params: {provider: {description: @provider.description, instagram: @provider.instagram, location: @provider.location, name: @provider.name, service: @provider.service, tiktok: @provider.tiktok, user: @provider.user, website: @provider.website}}
    end

    assert_redirected_to provider_url(Provider.last)
  end

  test "should show provider" do
    get provider_url(@provider)
    assert_response :success
  end

  test "should get edit" do
    get edit_provider_url(@provider)
    assert_response :success
  end

  test "should update provider" do
    patch provider_url(@provider), params: {provider: {description: @provider.description, instagram: @provider.instagram, location: @provider.location, name: @provider.name, service: @provider.service, tiktok: @provider.tiktok, user: @provider.user, website: @provider.website}}
    assert_redirected_to provider_url(@provider)
  end

  test "should destroy provider" do
    assert_difference("Provider.count", -1) do
      delete provider_url(@provider)
    end

    assert_redirected_to providers_url
  end
end
