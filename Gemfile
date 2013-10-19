source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'
gem 'mysql2'
gem 'configy'
gem 'hashie'
gem 'oj'
gem 'celluloid'
gem 'whenever',   :require => false
gem 'capistrano', :require => false
# gem 'ox'
# gem 'profanalyzer'
# gem 'activerecord-import', '~> 0.3.0'
# gem 'unicorn'
# gem 'puma'


# Model Extentions
# ================
gem 'state_machine'
gem 'acts_as_list'
gem 'acts_as_interface'
gem 'devise'
gem 'devise-encryptable'
gem "friendly_id", "~> 4.0.9" #'~> 5.0.0'
gem 'sunspot_rails'
gem 'sunspot_solr'


# Media Download/Processing/Storage
# =================================
gem 'typhoeus'
gem 'cocaine'
gem 'posix-spawn'
gem 'aws-sdk'
gem 'paperclip'
gem 'paperclip-ffmpeg'
# gem 'paperclip-optimizer'


# SideKiq Queue
# =============
gem 'sidekiq'
gem 'request_store'
# gem "thin", "~> 1.4.1"
gem 'slim', '<= 1.3.0'
gem 'sinatra', :require => nil



# Monitoring
# ==========
gem "newrelic_rpm"
gem 'airbrake'


# Not required in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3', :require => false
end

gem 'jquery-rails'
gem 'therubyracer', :platforms => :ruby, :require => false
gem 'less-rails'
gem 'twitter-bootstrap-rails', '~> 2.2.6'
# gem 'bootstrap-datepicker-rails'
gem "haml-rails"


group :development, :test do
  gem 'thin'
  gem 'capistrano', :require => nil
  gem 'html2haml'
  
  # Jasmine
  gem 'jasmine-rails'
  gem 'jasmine-headless-webkit', '~> 0.8.4'

  # Guard
  gem 'growl'
  gem 'rb-fsevent'
  gem 'guard-rspec'#, '~> 3.0.2'
  gem 'guard-jasmine-headless-webkit'  # brew install qt --build-from-source
  
  # Rspec
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem "faker"
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'rspec_candy'
  gem 'syntax'
  gem 'zeus'
  gem 'vcr'
  gem "parallel_tests"
  gem "zeus-parallel_tests"
  gem "rspec-instafail"
  
  # Debugger
  gem 'pry-rails'
  gem 'progress_bar'
  
  gem 'annotate', ">=2.5.0"
  gem 'quiet_assets'
  gem 'rails-backbone-generator', :require => false
  
  gem 'sunspot_test', :require => false
end

group :test do
  gem 'webmock'
  gem 'therubyracer', :platform => :ruby
  gem 'sunspot_test'
  gem 'simplecov', :require => false
  gem "activerecord-tableless", "~> 1.0"  #used by DummyClass when testing concerns
  gem "rspec-sidekiq"
end

