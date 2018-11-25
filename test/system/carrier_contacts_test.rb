require "application_system_test_case"

class CarrierContactsTest < ApplicationSystemTestCase
  setup do
    @carrier_contact = carrier_contacts(:one)
  end

  test "visiting the index" do
    visit carrier_contacts_url
    assert_selector "h1", text: "Carrier Contacts"
  end

  test "creating a Carrier contact" do
    visit carrier_contacts_url
    click_on "New Carrier Contact"

    fill_in "Address", with: @carrier_contact.address
    fill_in "City", with: @carrier_contact.city
    fill_in "Carrier", with: @carrier_contact.carrier_id
    fill_in "Country", with: @carrier_contact.country
    fill_in "Email", with: @carrier_contact.email
    fill_in "Home Phone", with: @carrier_contact.home_phone
    fill_in "Postal", with: @carrier_contact.postal
    fill_in "State", with: @carrier_contact.state
    fill_in "Title", with: @carrier_contact.title
    fill_in "Work Phone", with: @carrier_contact.work_phone
    click_on "Create Carrier contact"

    assert_text "Carrier contact was successfully created"
    click_on "Back"
  end

  test "updating a Carrier contact" do
    visit carrier_contacts_url
    click_on "Edit", match: :first

    fill_in "Address", with: @carrier_contact.address
    fill_in "City", with: @carrier_contact.city
    fill_in "Carrier", with: @carrier_contact.carrier_id
    fill_in "Country", with: @carrier_contact.country
    fill_in "Email", with: @carrier_contact.email
    fill_in "Home Phone", with: @carrier_contact.home_phone
    fill_in "Postal", with: @carrier_contact.postal
    fill_in "State", with: @carrier_contact.state
    fill_in "Title", with: @carrier_contact.title
    fill_in "Work Phone", with: @carrier_contact.work_phone
    click_on "Update Carrier contact"

    assert_text "Carrier contact was successfully updated"
    click_on "Back"
  end

  test "destroying a Carrier contact" do
    visit carrier_contacts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Carrier contact was successfully destroyed"
  end
end
