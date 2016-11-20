Given(/^I am "([^"]*)"$/) do |arg1|
  @current_user = create(:user, email: arg1)
  login_as(@current_user, :scope => :user)
end
