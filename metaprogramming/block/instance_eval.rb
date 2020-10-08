class MyClass
  def initialize
    @v = 1
  end

  def try
    yield
  end
end

obj = MyClass.new
obj.instance_eval do 
  p self
  p @v
end

class D
  def twisted_method
    @y = 2
    MyClass.new.instance_eval { "@v :#{@v} @y : #{@y}"}
  end

  def twisted_method_2
    @y = 2
    MyClass.new.instance_exec(@y) { |y| p self; "@v :#{@v} @y : #{y}"}
  end
end
p D.new.twisted_method
p D.new.twisted_method_2
p MyClass.new.try { self }
p MyClass.new.instance_eval { self }
p MyClass.new.instance_exec { self }