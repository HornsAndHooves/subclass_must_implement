require "spec_helper"

RSpec.describe SubclassMustImplement do

  class BaseFoo
    include SubclassMustImplement

    subclass_must_implement :foo, :bar, :baz
  end

  class Foo < BaseFoo
    def foo
      :foo
    end
  end

  class BaseBar
    extend SubclassMustImplement

    subclass_must_implement :version, :sub_version, err_message: "Version expected!!!"
  end

  class Bar < BaseBar
    def version
      SubclassMustImplement.version
    end
  end

  let(:foo) { Foo.new }
  let(:bar) { Bar.new }

  context "module included" do
    it "will raise a not implemented error if any required method is not implemented in the subclass" do
      expect { foo.bar }.to raise_error(NotImplementedError, "`bar` must be implemented in a subclass.")
      expect { foo.baz }.to raise_error(NotImplementedError, "`baz` must be implemented in a subclass.")
    end

    it "will not raise an error if a requred method is implemented by the subclass" do
      expect(foo.foo).to eq(:foo)
    end
  end

  context "module extended" do
    it "will raise a not implemented error if any required method is not implemented in the subclass" do
      expect { bar.sub_version }.to raise_error(NotImplementedError, "Version expected!!!")
    end

    it "will not raise an error if a requred method is implemented by the subclass" do
      expect(bar.version).to eq(described_class.version)
    end
  end

  context "matcher" do
    it { expect(BaseFoo).to require_subclass_to_implement(:foo) }
    it { expect(BaseFoo.new).to require_subclass_to_implement(:bar) }
    it { expect(BaseFoo).to_not require_subclass_to_implement(:qux) }
    it { expect(BaseBar).to require_subclass_to_implement(:version).with_error_message("Version expected!!!")}
  end
end
