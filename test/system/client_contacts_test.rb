require "application_system_test_case"

class ClientContactsTest < ApplicationSystemTestCase
  setup do
    @client_contact = client_contacts(:one)
  end

  test "visiting the index" do
    visit client_contacts_url
    assert_selector "h1", text: "Client Contacts"
  end

  test "creating a Client contact" do
    visit client_contacts_url
    click_on "New Client Contact"

    fill_in "Address", with: @client_contact.address
    fill_in "City", with: @client_contact.city
    fill_in "Client", with: @client_contact.client_id
    fill_in "Country", with: @client_contact.country
    fill_in "Email", with: @client_contact.email
    fill_in "Home Phone", with: @client_contact.home_phone
    fill_in "Postal", with: @client_contact.postal
    fill_in "State", with: @client_contact.state
    fill_in "Title", with: @client_contact.title
    fill_in "Work Phone", with: @client_contact.work_phone
    click_on "Create Client contact"

    assert_text "Client contact was successfully created"
    click_on "Back"
  end

  test "updating a Client contact" do
    visit client_contacts_url
    click_on "Edit", match: :first

    fill_in "Address", with: @client_contact.address
    fill_in "City", with: @client_contact.city
    fill_in "Client", with: @client_contact.client_id
    fill_in "Country", with: @client_contact.country
    fill_in "Email", with: @client_contact.email
    fill_in "Home Phone", with: @client_contact.home_phone
    fill_in "Postal", with: @client_contact.postal
    fill_in "State", with: @client_contact.state
    fill_in "Title", with: @client_contact.title
    fill_in "Work Phone", with: @client_contact.work_phone
    click_on "Update Client contact"

    assert_text "Client contact was successfully updated"
    click_on "Back"
  end

  test "destroying a Client contact" do
    visit client_contacts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client contact was successfully destroyed"
  end
end
