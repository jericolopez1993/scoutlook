require 'test_helper'

class MasterInvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @master_invoice = master_invoices(:one)
  end

  test "should get index" do
    get master_invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_master_invoice_url
    assert_response :success
  end

  test "should create master_invoice" do
    assert_difference('MasterInvoice.count') do
      post master_invoices_url, params: { master_invoice: { carrier_id: @master_invoice.carrier_id, invoicing_period_end: @master_invoice.invoicing_period_end, invoicing_period_start: @master_invoice.invoicing_period_start, master_account: @master_invoice.master_account, shipment_type: @master_invoice.shipment_type, shipper_id: @master_invoice.shipper_id, single_invoice_date: @master_invoice.single_invoice_date, total_charge: @master_invoice.total_charge, variance: @master_invoice.variance, variance_approved: @master_invoice.variance_approved } }
    end

    assert_redirected_to master_invoice_url(MasterInvoice.last)
  end

  test "should show master_invoice" do
    get master_invoice_url(@master_invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_master_invoice_url(@master_invoice)
    assert_response :success
  end

  test "should update master_invoice" do
    patch master_invoice_url(@master_invoice), params: { master_invoice: { carrier_id: @master_invoice.carrier_id, invoicing_period_end: @master_invoice.invoicing_period_end, invoicing_period_start: @master_invoice.invoicing_period_start, master_account: @master_invoice.master_account, shipment_type: @master_invoice.shipment_type, shipper_id: @master_invoice.shipper_id, single_invoice_date: @master_invoice.single_invoice_date, total_charge: @master_invoice.total_charge, variance: @master_invoice.variance, variance_approved: @master_invoice.variance_approved } }
    assert_redirected_to master_invoice_url(@master_invoice)
  end

  test "should destroy master_invoice" do
    assert_difference('MasterInvoice.count', -1) do
      delete master_invoice_url(@master_invoice)
    end

    assert_redirected_to master_invoices_url
  end
end
