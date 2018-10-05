require 'test_helper'

class MasterSignalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @master_signal = master_signals(:one)
  end

  test "should get index" do
    get master_signals_url
    assert_response :success
  end

  test "should get new" do
    get new_master_signal_url
    assert_response :success
  end

  test "should create master_signal" do
    assert_difference('MasterSignal.count') do
      post master_signals_url, params: { master_signal: { capacity_type: @master_signal.capacity_type, client_contact_id: @master_signal.client_contact_id, client_id: @master_signal.client_id, desired_rate: @master_signal.desired_rate, destination_city: @master_signal.destination_city, destination_country: @master_signal.destination_country, destination_state: @master_signal.destination_state, duration: @master_signal.duration, end_date: @master_signal.end_date, max_destination: @master_signal.max_destination, max_origin: @master_signal.max_origin, notes: @master_signal.notes, origin_city: @master_signal.origin_city, origin_country: @master_signal.origin_country, origin_state: @master_signal.origin_state, per: @master_signal.per, rate_id: @master_signal.rate_id, same_hoc: @master_signal.same_hoc, signal_date: @master_signal.signal_date, signal_type: @master_signal.signal_type, start_date: @master_signal.start_date, uom: @master_signal.uom, volume: @master_signal.volume } }
    end

    assert_redirected_to master_signal_url(MasterSignal.last)
  end

  test "should show master_signal" do
    get master_signal_url(@master_signal)
    assert_response :success
  end

  test "should get edit" do
    get edit_master_signal_url(@master_signal)
    assert_response :success
  end

  test "should update master_signal" do
    patch master_signal_url(@master_signal), params: { master_signal: { capacity_type: @master_signal.capacity_type, client_contact_id: @master_signal.client_contact_id, client_id: @master_signal.client_id, desired_rate: @master_signal.desired_rate, destination_city: @master_signal.destination_city, destination_country: @master_signal.destination_country, destination_state: @master_signal.destination_state, duration: @master_signal.duration, end_date: @master_signal.end_date, max_destination: @master_signal.max_destination, max_origin: @master_signal.max_origin, notes: @master_signal.notes, origin_city: @master_signal.origin_city, origin_country: @master_signal.origin_country, origin_state: @master_signal.origin_state, per: @master_signal.per, rate_id: @master_signal.rate_id, same_hoc: @master_signal.same_hoc, signal_date: @master_signal.signal_date, signal_type: @master_signal.signal_type, start_date: @master_signal.start_date, uom: @master_signal.uom, volume: @master_signal.volume } }
    assert_redirected_to master_signal_url(@master_signal)
  end

  test "should destroy master_signal" do
    assert_difference('MasterSignal.count', -1) do
      delete master_signal_url(@master_signal)
    end

    assert_redirected_to master_signals_url
  end
end
