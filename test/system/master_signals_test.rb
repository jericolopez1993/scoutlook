require "application_system_test_case"

class MasterSignalsTest < ApplicationSystemTestCase
  setup do
    @master_signal = master_signals(:one)
  end

  test "visiting the index" do
    visit master_signals_url
    assert_selector "h1", text: "Master Signals"
  end

  test "creating a Master signal" do
    visit master_signals_url
    click_on "New Master Signal"

    fill_in "Capacity Type", with: @master_signal.capacity_type
    fill_in "Client Contact", with: @master_signal.client_contact_id
    fill_in "Client", with: @master_signal.client_id
    fill_in "Desired Rate", with: @master_signal.desired_rate
    fill_in "Destination City", with: @master_signal.destination_city
    fill_in "Destination Country", with: @master_signal.destination_country
    fill_in "Destination State", with: @master_signal.destination_state
    fill_in "Duration", with: @master_signal.duration
    fill_in "End Date", with: @master_signal.end_date
    fill_in "Max Destination", with: @master_signal.max_destination
    fill_in "Max Origin", with: @master_signal.max_origin
    fill_in "Notes", with: @master_signal.notes
    fill_in "Origin City", with: @master_signal.origin_city
    fill_in "Origin Country", with: @master_signal.origin_country
    fill_in "Origin State", with: @master_signal.origin_state
    fill_in "Per", with: @master_signal.per
    fill_in "Rate", with: @master_signal.rate_id
    fill_in "Same Hoc", with: @master_signal.same_hoc
    fill_in "Signal Date", with: @master_signal.signal_date
    fill_in "Signal Type", with: @master_signal.signal_type
    fill_in "Start Date", with: @master_signal.start_date
    fill_in "Uom", with: @master_signal.uom
    fill_in "Volume", with: @master_signal.volume
    click_on "Create Master signal"

    assert_text "Master signal was successfully created"
    click_on "Back"
  end

  test "updating a Master signal" do
    visit master_signals_url
    click_on "Edit", match: :first

    fill_in "Capacity Type", with: @master_signal.capacity_type
    fill_in "Client Contact", with: @master_signal.client_contact_id
    fill_in "Client", with: @master_signal.client_id
    fill_in "Desired Rate", with: @master_signal.desired_rate
    fill_in "Destination City", with: @master_signal.destination_city
    fill_in "Destination Country", with: @master_signal.destination_country
    fill_in "Destination State", with: @master_signal.destination_state
    fill_in "Duration", with: @master_signal.duration
    fill_in "End Date", with: @master_signal.end_date
    fill_in "Max Destination", with: @master_signal.max_destination
    fill_in "Max Origin", with: @master_signal.max_origin
    fill_in "Notes", with: @master_signal.notes
    fill_in "Origin City", with: @master_signal.origin_city
    fill_in "Origin Country", with: @master_signal.origin_country
    fill_in "Origin State", with: @master_signal.origin_state
    fill_in "Per", with: @master_signal.per
    fill_in "Rate", with: @master_signal.rate_id
    fill_in "Same Hoc", with: @master_signal.same_hoc
    fill_in "Signal Date", with: @master_signal.signal_date
    fill_in "Signal Type", with: @master_signal.signal_type
    fill_in "Start Date", with: @master_signal.start_date
    fill_in "Uom", with: @master_signal.uom
    fill_in "Volume", with: @master_signal.volume
    click_on "Update Master signal"

    assert_text "Master signal was successfully updated"
    click_on "Back"
  end

  test "destroying a Master signal" do
    visit master_signals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Master signal was successfully destroyed"
  end
end
