require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'paperclip/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.include Devise::Test::ControllerHelpers, type: :controller
	config.include Devise::Test::IntegrationHelpers, type: :feature
	config.include RequestSpecHelper, type: :request
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
	config.after(:suite) do
		FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_uploads/"])
	end
	config.include Paperclip::Shoulda::Matchers
end

Shoulda::Matchers.configure do |config|
	config.integrate do |with|
		with.test_framework :rspec
		with.library :rails
	end
end
