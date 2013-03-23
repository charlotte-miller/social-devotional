# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Run JS and CoffeeScript files in a typical Rails 3.1 fashion, placing Underscore templates in app/views/*.jst
# Your spec files end with _spec.{js,coffee}.

require 'active_support/core_ext'
spec_location = "spec/javascripts/%s_spec"


# guard 'jasmine-headless-webkit' do
#   watch(%r{^app/views/.*\.jst$})
#   
#   # Run All
#   watch(%r{^spec/javascripts/factories\..*}) { spec_location }
#   watch(%r{^spec/javascripts/helpers(.*)\.(js|coffee)$}) { spec_location }
#   watch(%r{^app/assets/javascripts/([^/]*)\.(js|coffee)$}) { spec_location }
#   watch(%r{^app/assets/javascripts/fixtures(.*)\.(js|coffee)$}) { spec_location }
# 
#   # Single Spec
#   watch(%r{^public/javascripts/(.*)\.js$}) { |m| newest_js_file(spec_location % m[1]) }
#   watch(%r{^app/assets/javascripts/(.*)\.(js|coffee)$}) { |m| newest_js_file(spec_location % m[1]) }
#   watch(%r{^spec/javascripts/(.*)_spec\..*}) { |m| newest_js_file(spec_location % m[1]) }
# end

# all_after_pass:false

guard 'rspec' do  
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/factories/(.+)\.rb$}) do |m|
    %W[
      spec/models/#{m[1].singularize}_spec.rb
      spec/controllers/#{m[1]}_controller_spec.rb
      spec/requests/#{m[1]}_spec.rb
    ]
  end

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }

end
