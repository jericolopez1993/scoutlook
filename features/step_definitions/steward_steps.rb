When(/^I go to the new steward page$/) do
  visit "/stewards/new"
end
And(/^add a steward with these data$/) do |table|
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      fill_in "rep_#{hdr}", :with => tbl[hdr]
    end
  end
end
And(/^the steward "([^"]*)" should be on the show page$/) do |company_name|
    expect(page).to have_content(company_name)
end
And(/^edit the steward with these data$/) do |table|
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      fill_in "rep_#{hdr}", :with => tbl[hdr]
    end
  end
end
