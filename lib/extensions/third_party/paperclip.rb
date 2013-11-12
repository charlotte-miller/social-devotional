class Paperclip::AbstractAdapter
  alias_method :basename, :original_filename

  def extname
    File.extname(self.basename)
  end
end