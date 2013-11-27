# == Paperclip without ActiveRecord
#
# Simple and lightweight object that can use Paperclip
#
# 
# Customized part can be extracted in another class which
# would inherit from SimplePaperclip.
#
#   class MyClass < SimplePaperclip
#     attr_accessor :image_file_name # :<atached_file_name>_file_name
#     has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
#   end
#
# author : Bastien Gysler <basgys@gmail.com>
# https://gist.github.com/basgys/5712426
class SimplePaperclip
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks

  include ActiveModel::Validations
  include Paperclip::Glue

  # Paperclip required callbacks
  define_model_callbacks :save, only: [:after]
  define_model_callbacks :destroy, only: [:before, :after]  

  # Paperclip attached file example
  # -- Customize here --
  # attr_accessor :image_file_name # :<atached_file_name>_file_name
  # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  # -- /Customize here --

  # ActiveModel requirements  
  def to_model
    self
  end
 
  def id;           1    end
  def valid?()      true end
  def new_record?() true end
  def destroyed?()  true end

  def errors
    obj = Object.new
    def obj.[](key)         [] end
    def obj.full_messages() [] end
    def obj.any?()       false end
    obj
  end  
end