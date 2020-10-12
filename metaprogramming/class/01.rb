a = class MyClass
  1
end
p a

def add_method_to(a_class)
  a_class.class_eval do
    p self
    def m; 'hello'; end
  end
end
add_method_to(String)
p "abc".m # hello

class A
  @var = 1
  def read
    @var
  end

  def write
    @var = 2
  end

  def self.read
    [@var, @var1]
  end
  @var1 = 10
end
obj = A.new
p obj.read # nil
obj.write
p obj.read # 2
p A.read # [1, 10]
a = class << obj
  self
end
def obj.kk
  p 'kkkkkkkk'
end
p a.singleton_class
p a.superclass.ancestors
p A.singleton_class.superclass.superclass.superclass

class Maaaaa < A
  alias_method :read1, :read

  def read
    '222'
  end
end
ww = Maaaaa.new
ww.write
p ww.read1
p ww.read