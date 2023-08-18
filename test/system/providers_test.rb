require "application_system_test_case"

class ProvidersTest < ApplicationSystemTestCase
  setup do
    @provider = providers(:one)
  end

  test "visiting the index" do
    visit providers_url
    assert_selector "h1", text: "Providers"
  end

  test "should create provider" do
    visit providers_url
    click_on "New provider"

    fill_in "Description", with: @provider.description
    fill_in "Instagram", with: @provider.instagram
    fill_in "Location", with: @provider.location
    fill_in "Name", with: @provider.name
    fill_in "Service", with: @provider.service
    fill_in "Tiktok", with: @provider.tiktok
    fill_in "User", with: @provider.user
    fill_in "Website", with: @provider.website
    click_on "Create Provider"

    assert_text "Provider was successfully created"
    click_on "Back"
  end

  test "should update Provider" do
    visit provider_url(@provider)
    click_on "Edit this provider", match: :first

    fill_in "Description", with: @provider.description
    fill_in "Instagram", with: @provider.instagram
    fill_in "Location", with: @provider.location
    fill_in "Name", with: @provider.name
    fill_in "Service", with: @provider.service
    fill_in "Tiktok", with: @provider.tiktok
    fill_in "User", with: @provider.user
    fill_in "Website", with: @provider.website
    click_on "Update Provider"

    assert_text "Provider was successfully updated"
    click_on "Back"
  end

  test "should destroy Provider" do
    visit provider_url(@provider)
    click_on "Destroy this provider", match: :first

    assert_text "Provider was successfully destroyed"
  end
end
