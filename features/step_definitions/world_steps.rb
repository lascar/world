When(/^I go on the world page$/) do
  visit "/world"
end

When(/^I click on the button "([^"]*)"$/) do |arg1|
  # page.execute_script("$('#destroy_world').click")
  click_button('Apocalypse')
end

Then(/^I see "([^"]*)"$/) do |arg1|
  # save_and_open_page
  expect(page).to have_content(arg1)
end

Then(/^I can not see any button "([^"]*)"$/) do |arg1|
  expect(page).to have_no_button('Apocalypse')
end
