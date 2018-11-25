require "application_system_test_case"

class CarriersTest < ApplicationSystemTestCase
  setup do
    @carrier = carriers(:one)
  end

  test "visiting the index" do
    visit carriers_url
    assert_selector "h1", text: "Carriers"
  end

  test "creating a Carrier" do
    visit carriers_url
    click_on "New Carrier"

    fill_in "Address", with: @carrier.address
    fill_in "Annual Revenue", with: @carrier.annual_revenue
    fill_in "City", with: @carrier.city
    fill_in "Carrier", with: @carrier.carrier_id
    fill_in "Company Name", with: @carrier.company_name
    fill_in "Country", with: @carrier.country
    fill_in "Food Grade", with: @carrier.food_grade
    fill_in "Freight Revenue", with: @carrier.freight_revenue
    fill_in "Hazardous", with: @carrier.hazardous
    fill_in "Industry", with: @carrier.industry
    fill_in "Parent", with: @carrier.parent_id
    fill_in "Phone", with: @carrier.phone
    fill_in "Postal", with: @carrier.postal
    fill_in "Primary Industry", with: @carrier.primary_industry
    fill_in "Relationship Owner", with: @carrier.relationship_owner
    fill_in "Sales Priority", with: @carrier.sales_priority
    fill_in "State", with: @carrier.state
    click_on "Create Carrier"

    assert_text "Carrier was successfully created"
    click_on "Back"
  end

  test "updating a Carrier" do
    visit carriers_url
    click_on "Edit", match: :first

    fill_in "Address", with: @carrier.address
    fill_in "Annual Revenue", with: @carrier.annual_revenue
    fill_in "City", with: @carrier.city
    fill_in "Carrier", with: @carrier.carrier_id
    fill_in "Company Name", with: @carrier.company_name
    fill_in "Country", with: @carrier.country
    fill_in "Food Grade", with: @carrier.food_grade
    fill_in "Freight Revenue", with: @carrier.freight_revenue
    fill_in "Hazardous", with: @carrier.hazardous
    fill_in "Industry", with: @carrier.industry
    fill_in "Parent", with: @carrier.parent_id
    fill_in "Phone", with: @carrier.phone
    fill_in "Postal", with: @carrier.postal
    fill_in "Primary Industry", with: @carrier.primary_industry
    fill_in "Relationship Owner", with: @carrier.relationship_owner
    fill_in "Sales Priority", with: @carrier.sales_priority
    fill_in "State", with: @carrier.state
    click_on "Update Carrier"

    assert_text "Carrier was successfully updated"
    click_on "Back"
  end

  test "destroying a Carrier" do
    visit carriers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Carrier was successfully destroyed"
  end
end
