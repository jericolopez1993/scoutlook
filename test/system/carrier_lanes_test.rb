require "application_system_test_case"

class CarrierLanesTest < ApplicationSystemTestCase
  setup do
    @carrier_lane = carrier_lanes(:one)
  end

  test "visiting the index" do
    visit carrier_lanes_url
    assert_selector "h1", text: "Carrier Lanes"
  end

  test "creating a Carrier lane" do
    visit carrier_lanes_url
    click_on "New Carrier Lane"

    fill_in "Lane Destination", with: @carrier_lane.lane_destination
    fill_in "Lane Origin", with: @carrier_lane.lane_origin
    fill_in "Lane Priority", with: @carrier_lane.lane_priority
    fill_in "Notes", with: @carrier_lane.notes
    fill_in "Preferred Load Day", with: @carrier_lane.preferred_load_day
    fill_in "Truck Per Week", with: @carrier_lane.truck_per_week
    click_on "Create Carrier lane"

    assert_text "Carrier lane was successfully created"
    click_on "Back"
  end

  test "updating a Carrier lane" do
    visit carrier_lanes_url
    click_on "Edit", match: :first

    fill_in "Lane Destination", with: @carrier_lane.lane_destination
    fill_in "Lane Origin", with: @carrier_lane.lane_origin
    fill_in "Lane Priority", with: @carrier_lane.lane_priority
    fill_in "Notes", with: @carrier_lane.notes
    fill_in "Preferred Load Day", with: @carrier_lane.preferred_load_day
    fill_in "Truck Per Week", with: @carrier_lane.truck_per_week
    click_on "Update Carrier lane"

    assert_text "Carrier lane was successfully updated"
    click_on "Back"
  end

  test "destroying a Carrier lane" do
    visit carrier_lanes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Carrier lane was successfully destroyed"
  end
end
