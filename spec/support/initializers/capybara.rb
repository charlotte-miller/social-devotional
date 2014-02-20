# MUCH EASIER TO DEBUG, BUT NOISIER OUTPUT
# require 'capybara/poltergeist'
# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, { debug: false, js_errors: false, inspector:false })
# end


Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(app, debug:true, stderr: WarningSuppressor)
end
class WarningSuppressor
  class << self
    def write(message)
      if message =~ /QFont::setPixelSize: Pixel size <= 0/ || message =~/CoreText performance note:/ then 0 else puts(message);1;end
    end
  end
end

Capybara.match = :prefer_exact
Capybara.default_driver = Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 3
Capybara::Screenshot.append_timestamp = false
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
end

