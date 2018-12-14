Then(/^go to the "([^"]*)" page$/) do |menu|
 visit "/#{menu.downcase}"
end
And(/^there should be "([^"]*)" header title$/) do |header_title|
  within(:xpath, "/html/body/div/div[3]/div/div/div[1]/h4") do
      expect(page).to have_content(header_title)
  end
end
When(/^I go to the new carrier page$/) do
  visit "/carriers/new"
end
Then(/^there should be an success message "([^"]*)"$/) do |message|
  expect(page).to have_content(message)
end
Then(/^submit the form$/) do
  find("//input[@type='submit']").click
end
And(/^the carrier "([^"]*)" should be on the show page$/) do |company_name|
    expect(page).to have_content(company_name)
end
When(/^I clicked the edit button$/) do
  click_link('Edit')
end
When(/^I clicked the delete button$/) do
  click_link('Delete')
end
When(/^I click the first edit button on the "([^"]*)" table$/) do |tbl|
  if tbl == "location"
    find(:xpath, "//*[@id='#{tbl}_table']/tbody/tr[1]/td[7]/a[1]").click
  elsif tbl == "contact"
    find(:xpath, "//*[@id='#{tbl}_table']/tbody/tr/td[8]/a[1]").click
  else
    find(:xpath, "//*[@id='#{tbl}_table']/tbody/tr[1]/td[7]/a[2]").click
  end
end
When(/^I click the first delete button on the "([^"]*)" table$/) do |tbl|
  if tbl == "location"
    find(:xpath, "//*[@id='#{tbl}_table']/tbody/tr[1]/td[7]/a[2]").click
  elsif tbl == "contact"
    find(:xpath, "//*[@id='#{tbl}_table']/tbody/tr/td[8]/a[2]").click
  else
    find(:xpath, "//*[@id='#{tbl}_table']/tbody/tr[1]/td[7]/a[3]").click
  end
end
Then(/^there should have "([^"]*)" on the table$/) do |name|
  expect(page).to have_content(name)
end
Then(/^there should not have "([^"]*)" on the table$/) do |name|
  expect(page).to have_no_content(name)
end
Then(/^click the "([^"]*)" tab$/) do |tab|
  page.all(:css, ".#{tab}-btn").each do |elem|
    elem.click
  end
end
And(/^click the new "([^"]*)" button$/) do |btn|
  find(:css, ".new-#{btn}-btn").click
end
And(/^add a "([^"]*)" with these data$/) do |model, table|
  if model == "steward"
    model = "rep"
  end
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      if hdr == "sales_priority" || hdr == "contract_rates" || hdr == "total_fleet_size" || hdr == "sales_priority" || hdr == "shipper_type" || hdr == "loads_per_month" || hdr == "spend_per_year" || hdr == "buying_criteria" || hdr == "price_sensitivity" || hdr == "rep_id" || hdr == "annual_value" || hdr == "lane_priority" || hdr == "contact_type"
        select(tbl[hdr], :from => "#{model}_#{hdr}")
      elsif hdr == "engagement_type"
        select(tbl[hdr], :from => "#{hdr}")
      else
        fill_in "#{model}_#{hdr}", :with => tbl[hdr]
      end
    end
  end
end
And(/^edit the "([^"]*)" with these data$/) do |model,table|
  if model == "steward"
    model = "rep"
  end
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      if hdr == "sales_priority" || hdr == "contract_rates" || hdr == "total_fleet_size" || hdr == "sales_priority" || hdr == "shipper_type" || hdr == "loads_per_month" || hdr == "spend_per_year" || hdr == "buying_criteria" || hdr == "price_sensitivity" || hdr == "rep_id" || hdr == "annual_value" || hdr == "lane_priority" || hdr == "contact_type"
        select(tbl[hdr], :from => "#{model}_#{hdr}")
      elsif hdr == "engagement_type"
        select(tbl[hdr], :from => "#{hdr}")
      else
        fill_in "#{model}_#{hdr}", :with => tbl[hdr]
      end
    end
  end
end
