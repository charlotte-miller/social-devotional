# module Describable
#   extend ActiveSupport::Concern
#   
#   included do
#     belongs_to :long_description
#     delegates :description, :to => :long_description
#   end
#   
# end