require 'test_helper'

class ActivityOutcomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_outcome = activity_outcomes(:one)
  end

  test "should get index" do
    get activity_outcomes_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_outcome_url
    assert_response :success
  end

  test "should create activity_outcome" do
    assert_difference('ActivityOutcome.count') do
      post activity_outcomes_url, params: { activity_outcome: { notes: @activity_outcome.notes, outcome: @activity_outcome.outcome, reason: @activity_outcome.reason } }
    end

    assert_redirected_to activity_outcome_url(ActivityOutcome.last)
  end

  test "should show activity_outcome" do
    get activity_outcome_url(@activity_outcome)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_outcome_url(@activity_outcome)
    assert_response :success
  end

  test "should update activity_outcome" do
    patch activity_outcome_url(@activity_outcome), params: { activity_outcome: { notes: @activity_outcome.notes, outcome: @activity_outcome.outcome, reason: @activity_outcome.reason } }
    assert_redirected_to activity_outcome_url(@activity_outcome)
  end

  test "should destroy activity_outcome" do
    assert_difference('ActivityOutcome.count', -1) do
      delete activity_outcome_url(@activity_outcome)
    end

    assert_redirected_to activity_outcomes_url
  end
end
