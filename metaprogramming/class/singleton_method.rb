# singleton method example
str = 'just a string'

def str.title?
  self.upcase == self
end
p str.title? #false
str << 'AAAA'
str.slice!(0..-4)
p str.title? #true
p str.methods.grep(/title?/) #[:title?]
p str.singleton_methods #[:title?]

str = 'BBB'
# str.title? # undefined method `title?'
# class mehtod is a singleton method
p '==='
class A
  def self.kk
    'kk'
  end

  def mm
    'mm'
  end
end

p A.singleton_methods
p A.methods(false)

# the class chain of singleton class and normal classs
p '==='
class B < A
end
obj = B.new
def obj.aa
  'aaa'
end
p obj.singleton_class.instance_methods(false)
p obj.singleton_class
p obj.singleton_class.superclass
p obj.singleton_class.superclass.singleton_class
p obj.singleton_class.superclass.singleton_class.superclass

# how extend work?
p '==='
module MyModule
  def my_method
    'my_method'
  end
end

# class MyClass
#   include MyModule
# end

# MyClass.my_method #No method error!!
class MyClass
  # include MyModule
  class << self
    include MyModule
  end
end

p MyClass.ancestors
p MyClass.singleton_class.ancestors
p MyClass.singleton_methods
