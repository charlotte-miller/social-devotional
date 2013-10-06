# Converts an obj into a 'polymorphic' hash and back into the @obj_instance
#
#   @lesson.to_findable_hash        #=> {klass:'Lesson', id:12}
#   {klass:'Lesson', id:12}.to_obj  #=> @lesson
#
# [Tip] Use w/ Sidekiq to serialize objects into primative arguments
#
module FindableHash
  extend ActiveSupport::Concern
  
  def to_findable_hash
    { :klass => self.class.name,
      :id    => self.id }
  end
end

require 'hashie/mash'
class Hash
  def to_obj
    hash = Hashie::Mash.new(self)
    raise NoMethodError unless hash.klass? && hash.id?
    hash.klass.classify.constantize.find( hash.id )
  end
end

# include the extension 
ActiveRecord::Base.send(:include, FindableHash)