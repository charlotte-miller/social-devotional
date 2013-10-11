require 'tempfile'
require 'uri'

class AttachmentDownloader
  include Sidekiq::Worker
  sidekiq_options({
    queue: :attachments, 
    unique: true,
    backtrace: true})

  def perform(obj_hash, attachment_names=[])
    @obj_instance = obj_hash.to_obj
    Array.wrap(attachment_names).each {|attachment| download_and_assign attachment }
    @obj_instance.save!
  end

private

  # Paperclip assignment will trigger any Paperclip::Processor
  def download_and_assign( attachment_name )
    url_str   = @obj_instance.send("#{attachment_name}_original_url")
    file_name = URI(url_str).path.sub(/^\//,'')
    
    Tempfile.open(file_name) do |tempfile|
      curl_to(url_str, tempfile.path)
      @obj_instance.send("#{attachment_name}=", tempfile)
    end
  end

  # Uses system `curl` to avoid buffering content into ruby
  # This can be updated when Curb/Typhoeus supports the --output option 
  def curl_to(from_url, to_file_path)
    `curl #{from_url} -o #{to_file_path} --silent`
  end
end