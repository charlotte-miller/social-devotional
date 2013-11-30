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
end