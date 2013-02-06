source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'
gem 'mysql2'
gem 'configy'
gem 'oj'
gem 'celluloid'
gem 'whenever'
gem 'sunspot_rails'
gem 'sunspot_solr'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby, :require => false
  gem 'uglifier', '>= 1.0.3', :require => false
end

gem 'jquery-rails'



# To use Jbuilder templates for JSON
gem 'jbuilder'


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
  
  # Rspec
  gem 'rspec-rails', '~> 2.4'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem "ffaker", "0.3.5"
  gem 'capybara'
  
  # Debugger
  gem 'pry-rails'
  gem 'progress_bar'
  
  gem 'annotate', ">=2.5.0"
  gem 'quiet_assets'
  gem 'rails-backbone-generator'
end

group :test do
  gem 'rspec-rails-mocha', '~> 0.3.1', :require => false
  gem 'therubyracer', :platform => :ruby
  gem 'sunspot_test'
end

