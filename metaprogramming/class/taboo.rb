# try to define a method without writing class XXX def end end
a = Class.new(Array) do
  def aa
    'aaa'
  end
end
p a #[]
p a.new.aa #'aaa'
p a.class
MyClass = a
p a.name

p '000' + MyClass.new.aa