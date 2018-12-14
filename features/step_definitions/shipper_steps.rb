When(/^I go to the new shipper page$/) do
  visit "/shippers/new"
end
And(/^the shipper "([^"]*)" should be on the show page$/) do |company_name|
    expect(page).to have_content(company_name)
end
