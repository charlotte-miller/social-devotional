module Uuidable
  extend ActiveSupport::Concern
  
  # Creates a unique <= 16-diget ID
  def create_uuid(prefix=nil)
    time   = (Time.now.to_f * 10_000_000).to_i
    jitter = rand(10_000_000) 
    key    = "#{jitter}#{time}".to_i.to_s(36)
    [prefix, key].compact.join('-')
  end
  
  
  module ClassMethods
    
    def has_public_id( public_id_column=:public_id, options={})
      options = {
        prefix:nil,
        length:20
      }.merge(options)
      
      class_eval do
        before_validation :generate_missing_public_id, :on => :create
        validates_uniqueness_of public_id_column, :on => :create
        validates_presence_of public_id_column,   :on => :create
        validates_length_of public_id_column,     :on => :create, :within => 1..options[:length]
      end
      
      define_method(:generate_missing_public_id) do
        self.send("#{public_id_column}=", create_uuid(options[:prefix]) ) unless self.send(public_id_column)
      end
      
    # Required for rails to load before the database is migrated
    rescue StandardError => error
      raise error if self.table_exists?
    end
    
  end #ClassMethods
end #Uuidable