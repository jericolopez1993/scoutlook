require 'test_helper'

class ShipmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipment = shipments(:one)
  end

  test "should get index" do
    get shipments_url
    assert_response :success
  end

  test "should get new" do
    get new_shipment_url
    assert_response :success
  end

  test "should create shipment" do
    assert_difference('Shipment.count') do
      post shipments_url, params: { shipment: { billed_rate: @shipment.billed_rate, billed_rate_unit: @shipment.billed_rate_unit, billed_weight: @shipment.billed_weight, declared_weight: @shipment.declared_weight, destination_id: @shipment.destination_id, destination_location_id: @shipment.destination_location_id, distance: @shipment.distance, gst_hst_tax: @shipment.gst_hst_tax, header: @shipment.header, origin_id: @shipment.origin_id, origin_location_id: @shipment.origin_location_id, pallets: @shipment.pallets, pieces: @shipment.pieces, raw_weight: @shipment.raw_weight, service_mode: @shipment.service_mode, shipment_date: @shipment.shipment_date, surchange_multi_piece: @shipment.surchange_multi_piece, surcharge_fuel: @shipment.surcharge_fuel, surcharge_non_conveyables: @shipment.surcharge_non_conveyables, surcharge_non_vault: @shipment.surcharge_non_vault, surcharge_ontario: @shipment.surcharge_ontario, surcharge_weight: @shipment.surcharge_weight, terms: @shipment.terms, total_charge: @shipment.total_charge, total_charge_with_tax: @shipment.total_charge_with_tax, tracking_number: @shipment.tracking_number, unit_of_weight: @shipment.unit_of_weight } }
    end

    assert_redirected_to shipment_url(Shipment.last)
  end

  test "should show shipment" do
    get shipment_url(@shipment)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipment_url(@shipment)
    assert_response :success
  end

  test "should update shipment" do
    patch shipment_url(@shipment), params: { shipment: { billed_rate: @shipment.billed_rate, billed_rate_unit: @shipment.billed_rate_unit, billed_weight: @shipment.billed_weight, declared_weight: @shipment.declared_weight, destination_id: @shipment.destination_id, destination_location_id: @shipment.destination_location_id, distance: @shipment.distance, gst_hst_tax: @shipment.gst_hst_tax, header: @shipment.header, origin_id: @shipment.origin_id, origin_location_id: @shipment.origin_location_id, pallets: @shipment.pallets, pieces: @shipment.pieces, raw_weight: @shipment.raw_weight, service_mode: @shipment.service_mode, shipment_date: @shipment.shipment_date, surchange_multi_piece: @shipment.surchange_multi_piece, surcharge_fuel: @shipment.surcharge_fuel, surcharge_non_conveyables: @shipment.surcharge_non_conveyables, surcharge_non_vault: @shipment.surcharge_non_vault, surcharge_ontario: @shipment.surcharge_ontario, surcharge_weight: @shipment.surcharge_weight, terms: @shipment.terms, total_charge: @shipment.total_charge, total_charge_with_tax: @shipment.total_charge_with_tax, tracking_number: @shipment.tracking_number, unit_of_weight: @shipment.unit_of_weight } }
    assert_redirected_to shipment_url(@shipment)
  end

  test "should destroy shipment" do
    assert_difference('Shipment.count', -1) do
      delete shipment_url(@shipment)
    end

    assert_redirected_to shipments_url
  end
end
