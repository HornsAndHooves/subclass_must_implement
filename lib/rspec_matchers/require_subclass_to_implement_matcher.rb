require 'rspec/expectations'

RSpec::Matchers.define :require_subclass_to_implement do |method_name|

  chain :with_error_message do |err_message|
    @err_message = err_message
  end

  match do |klass|
    item = if klass.is_a?(Class)
             klass.new
           else
             klass
           end

    if item.respond_to?(method_name)
      begin
        item.__send__ method_name
        false
      rescue NotImplementedError => err
        @err_message ||= ::SubclassMustImplement.default_error_message(method_name)
        err.message == @err_message
      end
    else
      false
    end

  end # match do

  failure_message do
    "should require subclasses to implement method `#{method_name}`,"\
      " otherwise raise a NotImplementedError with message '#{@err_message}'"
  end

  failure_message_when_negated do
    "should not require method `#{method_name}` to be implemented by subclasses"
  end

  description do
    "method `#{method_name}` must be implemented by subclasses"
  end
end
