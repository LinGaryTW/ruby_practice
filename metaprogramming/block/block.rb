def my_method(a, b)
  result = ''
  result += yield(a, b) if block_given?
  result + 'ccccccccccccc'
end
x = 'aaaaaaaaaaaaaa'
p my_method(1, 2) { |a, b| p self; "#{a} is a number #{b} is too!!#{x}"}
p my_method('a', 'b')

v1 = 1
class MyClass
  v2 = 2
  p local_variables
  def my_method
    v3 = 3
    p local_variables
  end
  p local_variables
end
obj = MyClass.new
obj.my_method
p local_variables

