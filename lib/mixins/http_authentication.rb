require 'sidekiq/web'

## Usage:
## require 'mixins/http_authentication'
## before_filter :authenticate_developer
module HttpAuthentication

  CREDENTIALS = [AppConfig.dev_user, AppConfig.dev_pass]

  def authenticate_developer
    authenticate_or_request_with_http_basic('Restricted Area') do |username, password|
      [username, password] == CREDENTIALS
    end
  end

  # interface for sidekiq
  class Sidekiq < Sidekiq::Web
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      [username, password] == CREDENTIALS
    end
  end
end

include HttpAuthentication