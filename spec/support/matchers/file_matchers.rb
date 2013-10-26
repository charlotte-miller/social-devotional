# === File Matchers
# +have_the_same_content_as+
# +have_the_same_name_as+
# +be_the_same_file_as+
#
module FileMatchers
  class HaveTheSameContent
    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      @actual.read == @expected.read
    end

    def failure_message_for_should
      "expected #{@actual.inspect} to have the same content as #{@expected.inspect}"
    end

    def failure_message_for_should_not
      "expected #{@actual.inspect} to have DIFFERENT content than #{@expected.inspect}"
    end
  end

  class HaveTheSameName
    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      @actual.basename == @expected.basename
    end

    def failure_message_for_should
      "expected #{@actual.inspect} to have the same basename as #{@expected.inspect}"
    end

    def failure_message_for_should_not
      "expected #{@actual.inspect} to have a DIFFERENT basename than #{@expected.inspect}"
    end
  end

  def have_the_same_content_as(expected)
    HaveTheSameContent.new(expected)
  end
  
  def have_the_same_name_as(expected)
    HaveTheSameName.new(expected)
  end
    
  def be_the_same_file_as(expected)
    HaveTheSameName.new(expected)
    HaveTheSameContent.new(expected)
  end
  
end

RSpec.configure do |config|
  config.include(FileMatchers)
end