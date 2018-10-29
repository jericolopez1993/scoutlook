require "application_system_test_case"

class MasterInvoicesTest < ApplicationSystemTestCase
  setup do
    @master_invoice = master_invoices(:one)
  end

  test "visiting the index" do
    visit master_invoices_url
    assert_selector "h1", text: "Master Invoices"
  end

  test "creating a Master invoice" do
    visit master_invoices_url
    click_on "New Master Invoice"

    fill_in "Carrier", with: @master_invoice.carrier_id
    fill_in "Invoicing Period End", with: @master_invoice.invoicing_period_end
    fill_in "Invoicing Period Start", with: @master_invoice.invoicing_period_start
    fill_in "Master Account", with: @master_invoice.master_account
    fill_in "Shipment Type", with: @master_invoice.shipment_type
    fill_in "Shipper", with: @master_invoice.shipper_id
    fill_in "Invoice Date", with: @master_invoice.single_invoice_date
    fill_in "Total Charge", with: @master_invoice.total_charge
    fill_in "Variance", with: @master_invoice.variance
    fill_in "Variance Approved", with: @master_invoice.variance_approved
    click_on "Create Master invoice"

    assert_text "Master invoice was successfully created"
    click_on "Back"
  end

  test "updating a Master invoice" do
    visit master_invoices_url
    click_on "Edit", match: :first

    fill_in "Carrier", with: @master_invoice.carrier_id
    fill_in "Invoicing Period End", with: @master_invoice.invoicing_period_end
    fill_in "Invoicing Period Start", with: @master_invoice.invoicing_period_start
    fill_in "Master Account", with: @master_invoice.master_account
    fill_in "Shipment Type", with: @master_invoice.shipment_type
    fill_in "Shipper", with: @master_invoice.shipper_id
    fill_in "Invoice Date", with: @master_invoice.single_invoice_date
    fill_in "Total Charge", with: @master_invoice.total_charge
    fill_in "Variance", with: @master_invoice.variance
    fill_in "Variance Approved", with: @master_invoice.variance_approved
    click_on "Update Master invoice"

    assert_text "Master invoice was successfully updated"
    click_on "Back"
  end

  test "destroying a Master invoice" do
    visit master_invoices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Master invoice was successfully destroyed"
  end
end
