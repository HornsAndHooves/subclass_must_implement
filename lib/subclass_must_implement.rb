module SubclassMustImplement
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  def self.extended(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def subclass_must_implement(*method_names, err_message: nil)
      method_names.each do |method_name|
        err = err_message.nil? ? "`#{method_name}` must be implemented in a subclass." : "#{err_message}"
        define_method method_name do |*_|
          raise NotImplementedError, err
        end
      end
    end
  end
end
