module A
  def a_a
    puut
  end

  def puut
    p 'a'
  end
end

module B
  def b_b
    a_a
    puut
  end

  def puut
    p 'b'
  end
end

class MyClass
  include B
  include A
end

p MyClass.ancestors
p MyClass.superclass
MyClass.new.a_a
MyClass.new.b_b
MyClass.new.puut