class MyClass
  def my_method(my_arg)
    my_arg * 2
  end

  define_method :my_method2 do | my_arg|
    my_arg * 3 
  end
end

obj = MyClass.new
p obj.my_method(3) # -> 6
p obj.send(:my_method, 3) # -> 6
p obj.send(:my_method2, 3) # -> 9

# ----------------------------------------
class DataSource
  def get_cpu_info
    'cpu no 1' 
  end

  def get_mouse_info
    'mouse no 1'
  end

  def get_keyboard_info
    'keyboard no 1'
  end

  def get_cpu_price
    100
  end

  def get_mouse_price
    10
  end

  def get_keyboard_price
    15
  end
end

# stander call each method

# class Computer
#   def initialize(data_source)
#     @data_source = data_source
#   end

#   def cpu
#     info = @data_source.get_cpu_info
#     price = @data_source.get_cpu_price
#     result = "info: #{info}, price: $#{price}"
#   end

#   def mouse
#     info = @data_source.get_mouse_info
#     price = @data_source.get_mouse_price
#     result = "info: #{info}, price: $#{price}"
#   end

#   def keyboard
#     info = @data_source.get_keyboard_info
#     price = @data_source.get_keyboard_price
#     result = "info: #{info}, price: $#{price}"
#   end
# end

# call method dynamically
# class Computer
#   def initialize(data_source)
#     @data_source = data_source
#     # gerp names and then define the method one by one
#     @data_source.methods.grep(/get_(.*)_info/) { Computer.define_component $1}
#   end

#   def self.define_component(name)
#     define_method name do
#       info = @data_source.send("get_#{name}_info")
#       price = @data_source.send("get_#{name}_price")
#       result = "info: #{info}, price: $#{price}"
#     end
#   end
# end
# p Computer.instance_methods(false)
# computer = Computer.new(DataSource.new)
# p computer.class.instance_methods(false)

# method missing
class Computer < BasicObject
  def initialize(data_source)
    @data_source = data_source
  end

  def method_missing(method)
    super if !@data_source.respond_to?("get_#{method}_info")
    info = @data_source.send("get_#{method}_info")
    price = @data_source.send("get_#{method}_price")
    
    "info: #{info}, price: $#{price}"
  end

  # def respond_to_missing?(method, include_private = false)
  #   @data_source.respond_to?("get_#{method}_info") || super
  # end
end
p Computer.new(DataSource.new).mouse
# p Computer.new(DataSource.new).respond_to?(:mouse)
p Computer.ancestors