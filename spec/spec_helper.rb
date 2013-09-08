# require 'simplecov'
# SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "paperclip/matchers"
require 'rspec_candy/all'
require 'sunspot_test/rspec'
require 'capybara/rspec'
# require 'sidekiq/testing'
require 'webmock/rspec'
require 'vcr'
require 'pry'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Devise::TestHelpers,      :type => :controller
  config.extend  Devise::ControllerHelper, :type => :controller
  config.extend  Devise::RequestHelper,    :type => :request
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers
  
  # ## Mock Framework
  config.mock_with :rspec #:mocha

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  config.order = "random"
  
  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
  
  # http://railscasts.com/episodes/413-fast-tests?view=asciicast
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end