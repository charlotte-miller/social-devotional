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
    copy_to_local_file(style, Tempfile.new([self.basename, self.extname]).binmode)
  end
end