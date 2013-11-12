class File
  def basename
    File.basename(self.path)
  end
  
  def extname
    File.extname(self.basename)
  end
end