require 'test_helper'

class ClientContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_contact = client_contacts(:one)
  end

  test "should get index" do
    get client_contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_client_contact_url
    assert_response :success
  end

  test "should create client_contact" do
    assert_difference('ClientContact.count') do
      post client_contacts_url, params: { client_contact: { address: @client_contact.address, city: @client_contact.city, client_id: @client_contact.client_id, country: @client_contact.country, email: @client_contact.email, home_phone: @client_contact.home_phone, postal: @client_contact.postal, state: @client_contact.state, title: @client_contact.title, work_phone: @client_contact.work_phone } }
    end

    assert_redirected_to client_contact_url(ClientContact.last)
  end

  test "should show client_contact" do
    get client_contact_url(@client_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_contact_url(@client_contact)
    assert_response :success
  end

  test "should update client_contact" do
    patch client_contact_url(@client_contact), params: { client_contact: { address: @client_contact.address, city: @client_contact.city, client_id: @client_contact.client_id, country: @client_contact.country, email: @client_contact.email, home_phone: @client_contact.home_phone, postal: @client_contact.postal, state: @client_contact.state, title: @client_contact.title, work_phone: @client_contact.work_phone } }
    assert_redirected_to client_contact_url(@client_contact)
  end

  test "should destroy client_contact" do
    assert_difference('ClientContact.count', -1) do
      delete client_contact_url(@client_contact)
    end

    assert_redirected_to client_contacts_url
  end
end
