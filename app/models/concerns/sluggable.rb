# === Adds FriendlyId and adds #slug_candidates interface
#
module Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    # friendly_id :slug_candidates  #update after v 5.0.0
  end
  
  module ClassMethods
    
    # Usage: slug_candidates :title, [:title, :church_name]
    # Becomes:
    #
    #   def slug_candidates
    #     [:title, [:title, :church_name]]
    #   end
    #
    def slug_candidates *args
      define_method(:slug_candidates) {args}
    end
  end
end