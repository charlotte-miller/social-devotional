# Ensures the model has an attr_accessor, attr_reader or attr_writer
# Examples:
#   it { should have_attr_accessor(:value) }
#   it { should have_attr_accessor(:value).read_only }
#   it { should have_attr_accessor(:value).write_only }
module Shoulda
  module Matchers
    module ActiveModel # :nodoc

      def have_attr_accessor(attribute)
        HaveAttrAccessorMatcher.new(attribute)
      end

      class HaveAttrAccessorMatcher < ValidationMatcher # :nodoc:
        def initialize(attribute)
          @attribute = attribute
          @ro = false
          @wo = false
        end

        def read_only
          @ro = true
          self
        end

        def write_only
          @wo = true
          self
        end

        def matches?(subject)
          @subject = subject

          reader = @subject.respond_to?(@attribute)
          writer = @subject.respond_to?("#{@attribute.to_s}=")

          v = true
          v = v && !reader if @wo
          v = v && reader unless @wo
          v = v && !writer if @ro
          v = v && writer unless @ro
          v
        end

        def description
          msg = "have "
          if @ro
            msg += "read only"
          elsif @wo
            msg += "write only"
          else
            msg += "read and write"
          end
          msg += " accessors for #{@attribute}"
        end

        def failure_message
          if @ro
            "Expected #{@subject.class.name} to respond only to '#{@attribute}'"
          elsif @wo
            "Expected #{@subject.class.name} to respond only to '#{@attribute}='"
          else
            "Expected #{@subject.class.name} to respond to both '#{@attribute}' and '#{@attribute}='"
          end
        end

        def negative_failure_message
          if @ro
            "Expected #{@subject.class.name} not to respond only to '#{@attribute}'"
          elsif @wo
            "Expected #{@subject.class.name} not to respond only to '#{@attribute}'="
          else
            "Expected #{@subject.class.name} not to respond to '#{@attribute}' and '#{@attribute}='"
          end
        end

      end
    end
  end
end
