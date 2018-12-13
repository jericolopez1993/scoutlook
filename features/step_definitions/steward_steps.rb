When(/^I go to the new steward page$/) do
  visit "/stewards/new"
end
And(/^the steward "([^"]*)" should be on the show page$/) do |company_name|
    expect(page).to have_content(company_name)
end
