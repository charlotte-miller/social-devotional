# Cocaine is a gem for wrapping command-line calls like: `curl http://foo.com`
# This puts +Cocaine::CommandLine+ in Fake mode
# - still records commands
# - still can tell if a command was run
#
require 'cocaine'
RSpec.configure do |config|
  config.before(:each) do
    Cocaine::CommandLine.fake!
  end
end