require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  setup do
    @activity = activities(:one)
  end

  test "visiting the index" do
    visit activities_url
    assert_selector "h1", text: "Activities"
  end

  test "creating a Activity" do
    visit activities_url
    click_on "New Activity"

    fill_in "Annual Value", with: @activity.annual_value
    fill_in "Client", with: @activity.client_id
    fill_in "Date Closed", with: @activity.date_closed
    fill_in "Date Opened", with: @activity.date_opened
    fill_in "Engagement Type", with: @activity.engagement_type
    fill_in "Notes", with: @activity.notes
    fill_in "Outcome", with: @activity.outcome_id
    fill_in "Rep", with: @activity.rep_id
    fill_in "Status", with: @activity.status
    fill_in "Type", with: @activity.type
    click_on "Create Activity"

    assert_text "Activity was successfully created"
    click_on "Back"
  end

  test "updating a Activity" do
    visit activities_url
    click_on "Edit", match: :first

    fill_in "Annual Value", with: @activity.annual_value
    fill_in "Client", with: @activity.client_id
    fill_in "Date Closed", with: @activity.date_closed
    fill_in "Date Opened", with: @activity.date_opened
    fill_in "Engagement Type", with: @activity.engagement_type
    fill_in "Notes", with: @activity.notes
    fill_in "Outcome", with: @activity.outcome_id
    fill_in "Rep", with: @activity.rep_id
    fill_in "Status", with: @activity.status
    fill_in "Type", with: @activity.type
    click_on "Update Activity"

    assert_text "Activity was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity" do
    visit activities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity was successfully destroyed"
  end
end
