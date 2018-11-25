require 'test_helper'

class CarrierContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carrier_contact = carrier_contacts(:one)
  end

  test "should get index" do
    get carrier_contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_carrier_contact_url
    assert_response :success
  end

  test "should create carrier_contact" do
    assert_difference('CarrierContact.count') do
      post carrier_contacts_url, params: { carrier_contact: { address: @carrier_contact.address, city: @carrier_contact.city, carrier_id: @carrier_contact.carrier_id, country: @carrier_contact.country, email: @carrier_contact.email, home_phone: @carrier_contact.home_phone, postal: @carrier_contact.postal, state: @carrier_contact.state, title: @carrier_contact.title, work_phone: @carrier_contact.work_phone } }
    end

    assert_redirected_to carrier_contact_url(CarrierContact.last)
  end

  test "should show carrier_contact" do
    get carrier_contact_url(@carrier_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_carrier_contact_url(@carrier_contact)
    assert_response :success
  end

  test "should update carrier_contact" do
    patch carrier_contact_url(@carrier_contact), params: { carrier_contact: { address: @carrier_contact.address, city: @carrier_contact.city, carrier_id: @carrier_contact.carrier_id, country: @carrier_contact.country, email: @carrier_contact.email, home_phone: @carrier_contact.home_phone, postal: @carrier_contact.postal, state: @carrier_contact.state, title: @carrier_contact.title, work_phone: @carrier_contact.work_phone } }
    assert_redirected_to carrier_contact_url(@carrier_contact)
  end

  test "should destroy carrier_contact" do
    assert_difference('CarrierContact.count', -1) do
      delete carrier_contact_url(@carrier_contact)
    end

    assert_redirected_to carrier_contacts_url
  end
end
