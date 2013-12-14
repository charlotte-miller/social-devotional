class Object
  
  # Similar to #try(:method), 
  # try_these(:method, [:method, arg]) accepts multiple methods and try() each until finding a winner!
  # Pass arguments as arrays
  def try_these( *methods )
    value = nil
    methods.find {|method| value = self.try( *method )}
    value
  end
end