class MyClass
  def initialize
    @v = 1
  end

  def my_method
    15
  end
end

obj = MyClass.new
method = obj.method :my_method
p method
p method.class.instance_methods(false)
p method.call

module MyMudule
  def my_method1
    11
  end
end

class MySubClass < MyClass
end

unbound = MyMudule.instance_method(:my_method1)
unbound_1 = MyClass.instance_method(:my_method)
p unbound
p unbound.class #UnboundMethod
p unbound_1

String.send :define_method, :another_method, unbound
MySubClass.send :define_method, :another_method_1, unbound_1
p "abc".another_method # 11
p MySubClass.new.another_method_1 # 15