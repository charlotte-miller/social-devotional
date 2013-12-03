# RSpec matcher to spec delegations.
#
# Usage:
#
#     describe Post do
#       it { should delegate_method(:name).to(:author).with_prefix } # post.author_name
#       it { should delegate_method(:month).to(:created_at) }
#       it { should delegate_method(:year).to(:created_at) }
#     end
 
RSpec::Matchers.define :delegate_method do |method|
  match do |delegator|
    @method = @prefix ? :"#{@to}_#{method}" : method
    @delegator = delegator
    begin
      @delegator.send(@to)
    rescue NoMethodError
      raise "#{@delegator} does not respond to #{@to}!" 
    end
    @delegator.stub(@to).and_return double('receiver')
    @delegator.send(@to).stub(method).and_return :called
    @delegator.send(@method) == :called
  end
 
  description do
    "delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end
 
  failure_message_for_should do |text|
    "expected #{@delegator} to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end
 
  failure_message_for_should_not do |text|
    "expected #{@delegator} not to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end
 
  chain(:to) { |receiver| @to = receiver }
  chain(:with_prefix) { @prefix = true }
 
end


# # Pulled from shoulda-matchers 1.5
# # This helper is being depricated for semantic reasons I disagree with... so I'm keeping it.
# 
# # require 'bourne'
# # require 'active_support/deprecation'
# 
# module Shoulda # :nodoc:
#   module Matchers
#     module Independent # :nodoc:
# 
#       # Ensure that a given method is delegated properly.
#       #
#       # Basic Syntax:
#       #   it { should delegate_method(:deliver_mail).to(:mailman) }
#       #
#       # Options:
#       # * <tt>:as</tt> - tests that the object being delegated to is called with a certain method
#       #   (defaults to same name as delegating method)
#       # * <tt>:with_arguments</tt> - tests that the method on the object being delegated to is
#       #   called with certain arguments
#       #
#       # Examples:
#       #   it { should delegate_method(:deliver_mail).to(:mailman).as(:deliver_with_haste)
#       #   it { should delegate_method(:deliver_mail).to(:mailman).
#       #     with_arguments('221B Baker St.', :hastily => true) }
#       #
#       def delegate_method(delegating_method)
#         DelegateMatcher.new(delegating_method)
#       end
# 
#       class DelegateMatcher
#         def initialize(delegating_method)
#           # ActiveSupport::Deprecation.warn 'The delegate_method matcher is deprecated and will be removed in 2.0'
#           @delegating_method = delegating_method
#         end
# 
#         def matches?(subject)
#           @subject = subject
#           ensure_target_method_is_present!
# 
#           begin
#             extend Mocha::API
# 
#             stubbed_object = stub(method_on_target)
#             subject.stubs(@target_method).returns(stubbed_object)
#             subject.send(@delegating_method)
# 
#             matcher = Mocha::API::HaveReceived.new(method_on_target).with(*@delegated_arguments)
#             matcher.matches?(stubbed_object)
#           rescue NoMethodError, Mocha::ExpectationError
#             false
#           end
#         end
# 
#         def description
#           add_clarifications_to("delegate method ##{@delegating_method} to :#{@target_method}")
#         end
# 
#         def does_not_match?(subject)
#           raise InvalidDelegateMatcher
#         end
# 
#         def to(target_method)
#           @target_method = target_method
#           self
#         end
# 
#         def as(method_on_target)
#           @method_on_target = method_on_target
#           self
#         end
# 
#         def with_arguments(*arguments)
#           @delegated_arguments = arguments
#           self
#         end
# 
#         def failure_message_for_should
#           base = "Expected #{delegating_method_name} to delegate to #{target_method_name}"
#           add_clarifications_to(base)
#         end
# 
#         private
# 
#         def add_clarifications_to(message)
#           if @delegated_arguments.present?
#             message << " with arguments: #{@delegated_arguments.inspect}"
#           end
# 
#           if @method_on_target.present?
#             message << " as ##{@method_on_target}"
#           end
# 
#           message
#         end
# 
#         def delegating_method_name
#           method_name_with_class(@delegating_method)
#         end
# 
#         def target_method_name
#           method_name_with_class(@target_method)
#         end
# 
#         def method_name_with_class(method)
#           if Class === @subject
#             @subject.name + '.' + method.to_s
#           else
#             @subject.class.name + '#' + method.to_s
#           end
#         end
# 
#         def method_on_target
#           @method_on_target || @delegating_method
#         end
# 
#         def ensure_target_method_is_present!
#           if @target_method.blank?
#             raise TargetNotDefinedError
#           end
#         end
#       end
# 
#       class DelegateMatcher::TargetNotDefinedError < StandardError
#         def message
#           'Delegation needs a target. Use the #to method to define one, e.g. `post_office.should delegate(:deliver_mail).to(:mailman)`'
#         end
#       end
# 
#       class DelegateMatcher::InvalidDelegateMatcher < StandardError
#         def message
#           '#delegate_to does not support #should_not syntax.'
#         end
#       end
#     end
#   end
# end
