require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "creating a Client" do
    visit clients_url
    click_on "New Client"

    fill_in "Address", with: @client.address
    fill_in "Annual Revenue", with: @client.annual_revenue
    fill_in "City", with: @client.city
    fill_in "Client", with: @client.client_id
    fill_in "Client Type", with: @client.client_type
    fill_in "Company Name", with: @client.company_name
    fill_in "Country", with: @client.country
    fill_in "Food Grade", with: @client.food_grade
    fill_in "Freight Revenue", with: @client.freight_revenue
    fill_in "Hazardous", with: @client.hazardous
    fill_in "Industry", with: @client.industry
    fill_in "Parent", with: @client.parent_id
    fill_in "Phone", with: @client.phone
    fill_in "Postal", with: @client.postal
    fill_in "Primary Industry", with: @client.primary_industry
    fill_in "Relationship Owner", with: @client.relationship_owner
    fill_in "Sales Priority", with: @client.sales_priority
    fill_in "State", with: @client.state
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "updating a Client" do
    visit clients_url
    click_on "Edit", match: :first

    fill_in "Address", with: @client.address
    fill_in "Annual Revenue", with: @client.annual_revenue
    fill_in "City", with: @client.city
    fill_in "Client", with: @client.client_id
    fill_in "Client Type", with: @client.client_type
    fill_in "Company Name", with: @client.company_name
    fill_in "Country", with: @client.country
    fill_in "Food Grade", with: @client.food_grade
    fill_in "Freight Revenue", with: @client.freight_revenue
    fill_in "Hazardous", with: @client.hazardous
    fill_in "Industry", with: @client.industry
    fill_in "Parent", with: @client.parent_id
    fill_in "Phone", with: @client.phone
    fill_in "Postal", with: @client.postal
    fill_in "Primary Industry", with: @client.primary_industry
    fill_in "Relationship Owner", with: @client.relationship_owner
    fill_in "Sales Priority", with: @client.sales_priority
    fill_in "State", with: @client.state
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "destroying a Client" do
    visit clients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client was successfully destroyed"
  end
end
