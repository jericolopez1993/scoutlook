require "application_system_test_case"

class ActivityOutcomesTest < ApplicationSystemTestCase
  setup do
    @activity_outcome = activity_outcomes(:one)
  end

  test "visiting the index" do
    visit activity_outcomes_url
    assert_selector "h1", text: "Activity Outcomes"
  end

  test "creating a Activity outcome" do
    visit activity_outcomes_url
    click_on "New Activity Outcome"

    fill_in "Notes", with: @activity_outcome.notes
    fill_in "Outcome", with: @activity_outcome.outcome
    fill_in "Reason", with: @activity_outcome.reason
    click_on "Create Activity outcome"

    assert_text "Activity outcome was successfully created"
    click_on "Back"
  end

  test "updating a Activity outcome" do
    visit activity_outcomes_url
    click_on "Edit", match: :first

    fill_in "Notes", with: @activity_outcome.notes
    fill_in "Outcome", with: @activity_outcome.outcome
    fill_in "Reason", with: @activity_outcome.reason
    click_on "Update Activity outcome"

    assert_text "Activity outcome was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity outcome" do
    visit activity_outcomes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity outcome was successfully destroyed"
  end
end
