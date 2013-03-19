class Hash
  def try(arg)
    self[arg] rescue nil
  end
  
end