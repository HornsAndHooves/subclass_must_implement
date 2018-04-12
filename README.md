# SubclassMustImplement

There are circumstances when it is desirable to specify certain methods as abstract,
i.e. it is the responsibility of any subclass to implement them.
Getting a `MethodMIssing` is not helpful; an error that explicitly explains that the
missing method is required by contract to fully implement the interface will save much
time and frustration.

## Installation

Add this line to your application's Gemfile:

    gem 'subclass_must_implement'

And then execute:

    $ bundle

Or install yourself as:

    $ gem install subclass_must_implement

## Usage

Either `include SubclassMustImplement` or `extend SubclassMustImplement` in your base class.
Then call `subclass_must_implement` with a list of required method names as symbols.
You can optionally pass in a custom error message using the `err_message` named argument.

Example 1:

```ruby
class BaseFoo
  include SubclassMustImplement

  subclass_must_implement :foo, :bar, :baz
end

class Foo < BaseFoo
  def foo
    :foo
  end
end

f = Foo.new
f.foo # returns :foo
f.bar # raises a NotImplementedError that "bar" must be implemented in the subclass
f.baz # raises a NotImplementedError that "baz" must be implemented in the subclass
f.qux # raises a MethodMissing
```

Example 2:

```ruby
class BaseBar
  extend SubclassMustImplement

  subclass_must_implement :foo, :bar, err_message: "Version expected!!!"
end

class Bar < BaseBar
  def bar
    :bar
  end
end

b = Bar.new
b.bar # return :bar
b.foo # raises a NotImplementedError with the specified error message "Version expected!!!"
```

## Using With RSpec

There is a custom [RSpec](http://rspec.info/) matcher included to simplify testing.

Example:

```ruby
# NOTE: depending on gem load order, you may need to manually load the matcher.
# If so, add the following line to your `spec_helper.rb`
require "subclass_must_implement/rspec_matcher/require_subclass_to_implement_matcher"

# Given the following class:
class BaseBar
  extend SubclassMustImplement

  subclass_must_implement :foo, :bar, err_message: "Version expected!!!"
end

# Test to ensure required functionality is specified:

# Custom error messages can be specified
it { expect(BaseBar).to require_subclass_to_implement(:version).with_error_message("Version expected!!!")}

# Either the class or the instance can be passed to the matcher
it { expect(BaseBar.new).to require_subclass_to_implement(:sub_version) }

# Sometimes it makes sense to specify certain methods as not required
it { expect(BaseBar).to_not require_subclass_to_implement(:foo) }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/subclass_must_implement/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. Make sure all the test pass and your changes have test coverage!
