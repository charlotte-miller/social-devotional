class Paperclip::AbstractAdapter
  alias_method :basename, :original_filename

  def extname
    File.extname(self.basename)
  end
end

class Paperclip::Attachment
  alias_method :basename, :original_filename

  def extname
    File.extname(self.basename)
  end
  
  def to_tempfile(style=:original)
    raise 'Missing Paperclip::Attachment in #to_tempfile' unless self.present?
    copy_to_local_file(style, tempfile = Tempfile.new([self.basename, self.extname]).binmode)
    tempfile
  end
  
  
  # ---------------------------------------------------------------------------------
  # Domain Specific
  # ---------------------------------------------------------------------------------
  
  # Extend #url 
  # => S3 || YouTube/Vimeo || Missing
  def url_with_original_url(*args)
    original_url = instance.send("#{name}_original_url") rescue nil
    return url_without_original_url(*args)  if self.present?
    return original_url                     if trusted_third_party?
    return url_without_original_url(*args)  # missing.jpg
  end
  alias_method_chain :url, :original_url
  
  # Identifies trusted third parties using options[:skip_processing_urls]
  # These attachments are not downloaded/processed by the worker
  def trusted_third_party?
    return false if present? 
    return false if (url_str = instance.send("#{name}_original_url")).blank?
    attachment_domain = URI(url_str).host_w_out_subdomains
    trusted_domains   = options[:skip_processing_urls]
    !!(trusted_domains && attachment_domain =~ Regexp.new(trusted_domains.join("|")))
  end
end