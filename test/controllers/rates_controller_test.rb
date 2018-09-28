require 'test_helper'

class RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate = rates(:one)
  end

  test "should get index" do
    get rates_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_url
    assert_response :success
  end

  test "should create rate" do
    assert_difference('Rate.count') do
      post rates_url, params: { rate: { client_id: @rate.client_id, destination_city: @rate.destination_city, destination_country: @rate.destination_country, destination_state: @rate.destination_state, effective_from: @rate.effective_from, effective_to: @rate.effective_to, freight_classification: @rate.freight_classification, freight_desc: @rate.freight_desc, minimum_density: @rate.minimum_density, origin_city: @rate.origin_city, origin_country: @rate.origin_country, origin_state: @rate.origin_state, parent_id: @rate.parent_id, rate_level: @rate.rate_level, rate_type: @rate.rate_type, rep_id: @rate.rep_id, transit_time: @rate.transit_time } }
    end

    assert_redirected_to rate_url(Rate.last)
  end

  test "should show rate" do
    get rate_url(@rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_url(@rate)
    assert_response :success
  end

  test "should update rate" do
    patch rate_url(@rate), params: { rate: { client_id: @rate.client_id, destination_city: @rate.destination_city, destination_country: @rate.destination_country, destination_state: @rate.destination_state, effective_from: @rate.effective_from, effective_to: @rate.effective_to, freight_classification: @rate.freight_classification, freight_desc: @rate.freight_desc, minimum_density: @rate.minimum_density, origin_city: @rate.origin_city, origin_country: @rate.origin_country, origin_state: @rate.origin_state, parent_id: @rate.parent_id, rate_level: @rate.rate_level, rate_type: @rate.rate_type, rep_id: @rate.rep_id, transit_time: @rate.transit_time } }
    assert_redirected_to rate_url(@rate)
  end

  test "should destroy rate" do
    assert_difference('Rate.count', -1) do
      delete rate_url(@rate)
    end

    assert_redirected_to rates_url
  end
end
