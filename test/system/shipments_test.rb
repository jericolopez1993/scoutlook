require "application_system_test_case"

class ShipmentsTest < ApplicationSystemTestCase
  setup do
    @shipment = shipments(:one)
  end

  test "visiting the index" do
    visit shipments_url
    assert_selector "h1", text: "Shipments"
  end

  test "creating a Shipment" do
    visit shipments_url
    click_on "New Shipment"

    fill_in "Billed Rate", with: @shipment.billed_rate
    fill_in "Billed Rate Unit", with: @shipment.billed_rate_unit
    fill_in "Billed Weight", with: @shipment.billed_weight
    fill_in "Declared Weight", with: @shipment.declared_weight
    fill_in "Destination", with: @shipment.destination_id
    fill_in "Destination Location", with: @shipment.destination_location_id
    fill_in "Distance", with: @shipment.distance
    fill_in "Gst Hst Tax", with: @shipment.gst_hst_tax
    fill_in "Header", with: @shipment.header
    fill_in "Origin", with: @shipment.origin_id
    fill_in "Origin Location", with: @shipment.origin_location_id
    fill_in "Pallets", with: @shipment.pallets
    fill_in "Pieces", with: @shipment.pieces
    fill_in "Raw Weight", with: @shipment.raw_weight
    fill_in "Service Mode", with: @shipment.service_mode
    fill_in "Shipment Date", with: @shipment.shipment_date
    fill_in "Surchange Multi Piece", with: @shipment.surchange_multi_piece
    fill_in "Surcharge Fuel", with: @shipment.surcharge_fuel
    fill_in "Surcharge Non Conveyables", with: @shipment.surcharge_non_conveyables
    fill_in "Surcharge Non Vault", with: @shipment.surcharge_non_vault
    fill_in "Surcharge Ontario", with: @shipment.surcharge_ontario
    fill_in "Surcharge Weight", with: @shipment.surcharge_weight
    fill_in "Terms", with: @shipment.terms
    fill_in "Total Charge", with: @shipment.total_charge
    fill_in "Total Charge With Tax", with: @shipment.total_charge_with_tax
    fill_in "Tracking Number", with: @shipment.tracking_number
    fill_in "Unit Of Weight", with: @shipment.unit_of_weight
    click_on "Create Shipment"

    assert_text "Shipment was successfully created"
    click_on "Back"
  end

  test "updating a Shipment" do
    visit shipments_url
    click_on "Edit", match: :first

    fill_in "Billed Rate", with: @shipment.billed_rate
    fill_in "Billed Rate Unit", with: @shipment.billed_rate_unit
    fill_in "Billed Weight", with: @shipment.billed_weight
    fill_in "Declared Weight", with: @shipment.declared_weight
    fill_in "Destination", with: @shipment.destination_id
    fill_in "Destination Location", with: @shipment.destination_location_id
    fill_in "Distance", with: @shipment.distance
    fill_in "Gst Hst Tax", with: @shipment.gst_hst_tax
    fill_in "Header", with: @shipment.header
    fill_in "Origin", with: @shipment.origin_id
    fill_in "Origin Location", with: @shipment.origin_location_id
    fill_in "Pallets", with: @shipment.pallets
    fill_in "Pieces", with: @shipment.pieces
    fill_in "Raw Weight", with: @shipment.raw_weight
    fill_in "Service Mode", with: @shipment.service_mode
    fill_in "Shipment Date", with: @shipment.shipment_date
    fill_in "Surchange Multi Piece", with: @shipment.surchange_multi_piece
    fill_in "Surcharge Fuel", with: @shipment.surcharge_fuel
    fill_in "Surcharge Non Conveyables", with: @shipment.surcharge_non_conveyables
    fill_in "Surcharge Non Vault", with: @shipment.surcharge_non_vault
    fill_in "Surcharge Ontario", with: @shipment.surcharge_ontario
    fill_in "Surcharge Weight", with: @shipment.surcharge_weight
    fill_in "Terms", with: @shipment.terms
    fill_in "Total Charge", with: @shipment.total_charge
    fill_in "Total Charge With Tax", with: @shipment.total_charge_with_tax
    fill_in "Tracking Number", with: @shipment.tracking_number
    fill_in "Unit Of Weight", with: @shipment.unit_of_weight
    click_on "Update Shipment"

    assert_text "Shipment was successfully updated"
    click_on "Back"
  end

  test "destroying a Shipment" do
    visit shipments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shipment was successfully destroyed"
  end
end
