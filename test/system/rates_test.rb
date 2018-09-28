require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
  end

  test "visiting the index" do
    visit rates_url
    assert_selector "h1", text: "Rates"
  end

  test "creating a Rate" do
    visit rates_url
    click_on "New Rate"

    fill_in "Client", with: @rate.client_id
    fill_in "Destination City", with: @rate.destination_city
    fill_in "Destination Country", with: @rate.destination_country
    fill_in "Destination State", with: @rate.destination_state
    fill_in "Effective From", with: @rate.effective_from
    fill_in "Effective To", with: @rate.effective_to
    fill_in "Freight Classification", with: @rate.freight_classification
    fill_in "Freight Desc", with: @rate.freight_desc
    fill_in "Minimum Density", with: @rate.minimum_density
    fill_in "Origin City", with: @rate.origin_city
    fill_in "Origin Country", with: @rate.origin_country
    fill_in "Origin State", with: @rate.origin_state
    fill_in "Parent", with: @rate.parent_id
    fill_in "Rate Level", with: @rate.rate_level
    fill_in "Rate Type", with: @rate.rate_type
    fill_in "Rep", with: @rate.rep_id
    fill_in "Transit Time", with: @rate.transit_time
    click_on "Create Rate"

    assert_text "Rate was successfully created"
    click_on "Back"
  end

  test "updating a Rate" do
    visit rates_url
    click_on "Edit", match: :first

    fill_in "Client", with: @rate.client_id
    fill_in "Destination City", with: @rate.destination_city
    fill_in "Destination Country", with: @rate.destination_country
    fill_in "Destination State", with: @rate.destination_state
    fill_in "Effective From", with: @rate.effective_from
    fill_in "Effective To", with: @rate.effective_to
    fill_in "Freight Classification", with: @rate.freight_classification
    fill_in "Freight Desc", with: @rate.freight_desc
    fill_in "Minimum Density", with: @rate.minimum_density
    fill_in "Origin City", with: @rate.origin_city
    fill_in "Origin Country", with: @rate.origin_country
    fill_in "Origin State", with: @rate.origin_state
    fill_in "Parent", with: @rate.parent_id
    fill_in "Rate Level", with: @rate.rate_level
    fill_in "Rate Type", with: @rate.rate_type
    fill_in "Rep", with: @rate.rep_id
    fill_in "Transit Time", with: @rate.transit_time
    click_on "Update Rate"

    assert_text "Rate was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate" do
    visit rates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate was successfully destroyed"
  end
end
