require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get clients_url
    assert_response :success
  end

  test "should get new" do
    get new_client_url
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post clients_url, params: { client: { address: @client.address, annual_revenue: @client.annual_revenue, city: @client.city, client_id: @client.client_id, client_type: @client.client_type, company_name: @client.company_name, country: @client.country, food_grade: @client.food_grade, freight_revenue: @client.freight_revenue, hazardous: @client.hazardous, industry: @client.industry, parent_id: @client.parent_id, phone: @client.phone, postal: @client.postal, primary_industry: @client.primary_industry, relationship_owner: @client.relationship_owner, sales_priority: @client.sales_priority, state: @client.state } }
    end

    assert_redirected_to client_url(Client.last)
  end

  test "should show client" do
    get client_url(@client)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_url(@client)
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: { client: { address: @client.address, annual_revenue: @client.annual_revenue, city: @client.city, client_id: @client.client_id, client_type: @client.client_type, company_name: @client.company_name, country: @client.country, food_grade: @client.food_grade, freight_revenue: @client.freight_revenue, hazardous: @client.hazardous, industry: @client.industry, parent_id: @client.parent_id, phone: @client.phone, postal: @client.postal, primary_industry: @client.primary_industry, relationship_owner: @client.relationship_owner, sales_priority: @client.sales_priority, state: @client.state } }
    assert_redirected_to client_url(@client)
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete client_url(@client)
    end

    assert_redirected_to clients_url
  end
end
