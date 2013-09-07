# ActiveSupport::Deprecation.silenced = true
ActiveSupport::Deprecation.behavior = [:log]

Celluloid.logger = Logger.new(Rails.root.join('log', 'celluloid.log'))