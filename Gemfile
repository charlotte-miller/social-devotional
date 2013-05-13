source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'
gem 'mysql2'
gem 'unicorn'
gem 'configy'
gem 'oj'
gem 'celluloid'
gem 'whenever', :require => false
gem 'paperclip'
gem 'aws-sdk'
gem 'devise'
gem 'devise-encryptable'
gem "friendly_id", "~> 4.0.9"
gem 'acts_as_list'
gem 'state_machine'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'typhoeus'
gem 'profanalyzer'
gem 'airbrake'

# SideKiq Monitoring
# gem 'sidekiq'
# gem "thin", "~> 1.4.1"
# gem 'slim', '<= 1.3.0'
# gem 'sinatra', :require => nil
# gem 'ox'
# gem 'jbuilder'
# gem 'acts_as_interface'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3', :require => false
end

gem 'jquery-rails'
gem 'therubyracer', :platforms => :ruby, :require => false
gem 'less-rails'
gem 'twitter-bootstrap-rails', '~> 2.2.6'
gem 'bootstrap-datepicker-rails'



gem "newrelic_rpm"

group :development, :test do
  gem 'thin'
  gem 'capistrano', :require => nil
  
  # Jasmine
  gem 'jasmine-rails'
  gem 'jasmine-headless-webkit', '~> 0.8.4'

  # Guard
  gem 'growl'
  gem 'rb-fsevent'
  gem 'guard-rspec'
  gem 'guard-jasmine-headless-webkit'  # brew install qt --build-from-source
  gem 'guard-spin' # consider spring instead
  
  # Rspec
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem "ffaker"
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'shoulda-matchers'
  gem 'syntax'
  gem 'zeus'
  
  # Debugger
  gem 'pry-rails'
  gem 'progress_bar'
  
  gem 'annotate', ">=2.5.0"
  gem 'quiet_assets'
  gem 'rails-backbone-generator', :require => false
end

group :test do
  gem 'webmock'
  gem 'therubyracer', :platform => :ruby
  gem 'sunspot_test'
end

