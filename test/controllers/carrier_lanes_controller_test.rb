require 'test_helper'

class CarrierLanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carrier_lane = carrier_lanes(:one)
  end

  test "should get index" do
    get carrier_lanes_url
    assert_response :success
  end

  test "should get new" do
    get new_carrier_lane_url
    assert_response :success
  end

  test "should create carrier_lane" do
    assert_difference('CarrierLane.count') do
      post carrier_lanes_url, params: { carrier_lane: { lane_destination: @carrier_lane.lane_destination, lane_origin: @carrier_lane.lane_origin, lane_priority: @carrier_lane.lane_priority, notes: @carrier_lane.notes, preferred_load_day: @carrier_lane.preferred_load_day, truck_per_week: @carrier_lane.truck_per_week } }
    end

    assert_redirected_to carrier_lane_url(CarrierLane.last)
  end

  test "should show carrier_lane" do
    get carrier_lane_url(@carrier_lane)
    assert_response :success
  end

  test "should get edit" do
    get edit_carrier_lane_url(@carrier_lane)
    assert_response :success
  end

  test "should update carrier_lane" do
    patch carrier_lane_url(@carrier_lane), params: { carrier_lane: { lane_destination: @carrier_lane.lane_destination, lane_origin: @carrier_lane.lane_origin, lane_priority: @carrier_lane.lane_priority, notes: @carrier_lane.notes, preferred_load_day: @carrier_lane.preferred_load_day, truck_per_week: @carrier_lane.truck_per_week } }
    assert_redirected_to carrier_lane_url(@carrier_lane)
  end

  test "should destroy carrier_lane" do
    assert_difference('CarrierLane.count', -1) do
      delete carrier_lane_url(@carrier_lane)
    end

    assert_redirected_to carrier_lanes_url
  end
end
