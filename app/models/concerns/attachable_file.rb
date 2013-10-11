# === Configures Paperclip/S3 and adds methods for a remote_url
#
module AttachableFile
  extend ActiveSupport::Concern
  
  module ClassMethods
    # === Usage: 
    #  has_attached_file, :video, path: ':rails_env/:class/:attachment/:updated_at-:basename.:extension'  
    # 
    # *Generates:*
    #  has_attached_file :video,
    #    :storage => :s3,
    #    :bucket => AppConfig.s3.bucket,
    #    :s3_credentials => AppConfig.s3.credentials,
    #    :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension'
    #  
    #  attr_accessible :video_original_url
    #  attr_reader :video_remote_url
    #  def video_remote_url=(url_str)
    #    self.video_original_url = url_str
    #    
    #    # require lib/extensions/active_record/instance_after_save
    #    def self.after_save
    #      return if @already_queued
    #      AttachmentDownloader.perform_async(self.to_findable_hash, :video) && @already_queued=true
    #    end
    #  end
    #  
    #
    def has_attachable_file( attachment_name, options={} )
      class_eval do
        has_attached_file attachment_name, {
          :storage => :s3,
          :bucket => AppConfig.s3.bucket,
          :s3_credentials => AppConfig.s3.credentials,
          # :url  => AppConfig.cloudfront.url 
          # :path => [ DEFINE IN OPTIONS ]
        }.merge(options)
      end
      
      # https://github.com/thoughtbot/paperclip/wiki/Attachment-downloaded-from-a-URL
      class_eval %Q{
        # non_original_url compatability
        attr_accessor :#{attachment_name}_original_url unless column_names.include? '#{attachment_name}_original_url'
        
        attr_accessible :#{attachment_name}_original_url
        attr_reader :#{attachment_name}_remote_url
        def #{attachment_name}_remote_url=(url_str)
          self.#{attachment_name}_original_url = url_str
          
          # require lib/extensions/active_record/instance_after_save
          def self.after_save
            return if @already_queued
            AttachmentDownloader.perform_async(self.to_findable_hash, :#{attachment_name}) && @already_queued=true
          end
        end
      }
      
    end
  end
end