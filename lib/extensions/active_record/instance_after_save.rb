# Define an after_save method for a single instance
#
#   def eigen.after_save
#     ...
#   end
#
module InstanceAfterSave
  extend ActiveSupport::Concern
  
  included do
    after_save :run_instance_after_save
  end
  
  def run_instance_after_save
    self.after_save if respond_to? :after_save
  end
end

# include the extension 
ActiveRecord::Base.send(:include, InstanceAfterSave)