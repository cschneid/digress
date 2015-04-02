require "digress/version"

class Object
  def digress(condition, &block)
    return self unless condition
    return self unless condition.call(self) if condition.respond_to? :call
    yield self
  end
end

