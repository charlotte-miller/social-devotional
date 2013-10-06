require 'tempfile'

class AttachmentDownloader
  include Sidekiq::Worker
  
  def perform(obj_hash, attachment_names=[])
    @obj_instance = obj_hash.to_obj
    Array.wrap(attachment_names).each {|attachment| download attachment }
    @obj_instance.save!
  end
  
private

  def download( attachment_name )
    url_str = @obj_instance.send("#{attachment_name}_original_url")
    
    Tempfile.open(attachment_name) do |tempfile|
      `curl #{url_str} -o #{tempfile.path} --silent`
      @obj_instance.send("#{attachment_name}=", tempfile.path)
    end
  end

end