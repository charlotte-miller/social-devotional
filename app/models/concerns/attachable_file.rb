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
    #  # https://github.com/thoughtbot/paperclip/wiki/Attachment-downloaded-from-a-URL
    #  attr_reader :video_remote_url
    #  def video_remote_url=(url_str)
    #    self.video=URI.parse(url_str)
    #    @video_remote_url = url_str
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
        attr_reader :#{attachment_name}_remote_url
        def #{attachment_name}_remote_url=(url_str)
          self.#{attachment_name}=URI.parse(url_str)
          @#{attachment_name}_remote_url = url_str
        end
      }
    end
  end
end