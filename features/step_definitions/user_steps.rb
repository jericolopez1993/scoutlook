When(/^I am on the login page$/) do
  visit "/"
end

And(/^there should be a login content$/) do
  page.has_content?('Please sign in your account')
end

Then(/^I should be able to login as admin$/) do
  fill_in 'user_email', :with => 'admin@test.com'
  fill_in 'user_password', :with => 'password'
  click_button('Sign me in')
end

And(/^there should be these items on my menu$/) do |table|
  data = table.raw
  data.each do |dt|
    page.has_content?(dt[0])
  end
end

Given(/^I login as administrator$/) do
  visit "/"
  page.has_content?('Please sign in your account')
  fill_in 'user_email', :with => 'admin@test.com'
  fill_in 'user_password', :with => 'password'
  click_button('Sign me in')
end

And(/^login with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  fill_in 'user_email', :with => 'admin@test.com'
  fill_in 'user_password', :with => 'password'
  click_button('Sign me in')
end

Then(/^there should be an invalid message "([^"]*)"$/) do |message|
  page.has_content?(message)
end
