# require 'simplecov'
# SimpleCov.start 'rails' # if ENV["COVERAGE"]

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require "paperclip/matchers" # /support
# require 'sidekiq/testing'    # /support
require 'rspec_candy/all'
require 'sunspot_test/rspec'
require 'capybara/rspec'
require 'webmock/rspec'
require 'vcr'
require 'pry'

# Requires supporting ruby files with custom matchers and macros, etc,
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Requires shared_examples using the convention: _shared_example_name.rb (similar to view partials)
Dir.glob(Rails.root.join('spec/**/_*.rb')).each {|f| require f}

RSpec.configure do |config|
  config.include Devise::TestHelpers,      :type => :controller
  config.extend  Devise::ControllerHelper, :type => :controller
  config.extend  Devise::RequestHelper,    :type => :request
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers
  
  # ## Mock Framework
  config.mock_with :rspec #:mocha

  VCR.configure do |c|
    c.default_cassette_options = { :record => :none } # :new_episodes
    c.allow_http_connections_when_no_cassette = false
    c.cassette_library_dir = "#{Rails.root}/spec/files/vcr_cassettes"
    c.hook_into :webmock
  end
  
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.order = "random"
  
  # http://railscasts.com/episodes/413-fast-tests?view=asciicast
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end