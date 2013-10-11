class Object
  # This allows you to be a good OOP citizen and honor encapsulation, but
  # still make calls to private methods (for testing) by doing
  #
  #   obj.bypass.private_thingie(arg1, arg2)
  #
  # Which is easier on the eye than
  #
  #   obj.send(:private_thingie, arg1, arg2)
  #
  class Bypass
    instance_methods.each do |m|
      undef_method m unless m =~ /^__/ or m =~ /object_id/
    end

    def initialize(ref)
      @ref = ref
    end

    def method_missing(sym, *args, &block)
      @ref.__send__(sym, *args, &block)
    end
  end

  def bypass
    Bypass.new(self)
  end
end