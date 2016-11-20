RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.before do
    Warden.test_mode!
  end

  config.after do
    Warden.test_reset!
  end
end
