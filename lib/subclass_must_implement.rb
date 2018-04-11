# Either `include SubclassMustImplement` or `extend SubclassMustImplement` in your base class.
# Then call `subclass_must_implement` with a list of required method names as symbols.
# You can optionally pass in a custom error message using the `err_message` named argument.
#
# Example 1:
#
#   class BaseFoo
#     include SubclassMustImplement
#
#     subclass_must_implement :foo, :bar, :baz
#   end
#
#   class Foo < BaseFoo
#     def foo
#       :foo
#     end
#   end
#
#   f = Foo.new
#   f.foo # returns :foo
#   f.bar # raises a NotImplementedError that "bar" must be implemented in the subclass
#   f.baz # raises a NotImplementedError that "baz" must be implemented in the subclass
#   f.qux # raises a MethodMissing
#
# Example 2:
#
#   class BaseBar
#     extend SubclassMustImplement
#
#     subclass_must_implement :foo, :bar, err_message: "Version expected!!!"
#   end
#
#   class Bar < BaseBar
#     def bar
#       :bar
#     end
#   end
#
#   b = Bar.new
#   b.bar # return :bar
#   b.foo # raises a NotImplementedError with the specified error message "Version expected!!!"
#
module SubclassMustImplement

  # Inject the `subclass_must_implement` macro.
  def self.included(base)
    base.extend ClassMethods
  end

  # Inject the `subclass_must_implement` macro.
  def self.extended(base)
    base.extend ClassMethods
  end

  # Return the Gem version as a string.
  def self.version
    "0.0.1"
  end

  # Create the default error message for the given method name.
  def self.default_error_message(method_name)
    "`#{method_name}` must be implemented in a subclass."
  end

  # The class level macros are defined here.
  module ClassMethods

    # Define a method for each method name that raises a NotImplementedError when called.
    # Pass in a custom error message if desired using the err_message named argument.
    def subclass_must_implement(*method_names, err_message: nil)
      method_names.each do |method_name|
        err = err_message.nil? ? ::SubclassMustImplement.default_error_message(method_name) : "#{err_message}"
        define_method method_name do |*_|
          raise NotImplementedError, err
        end
      end
    end
  end
end

if defined? RSpec
  require "rspec_matchers/require_subclass_to_implement_matcher"
end
