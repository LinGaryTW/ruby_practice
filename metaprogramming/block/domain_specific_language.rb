load './01.rb'
p MyClass.new.a

def event(desc)
  "#{desc}" if yield
end

def test
  @ccc
end

p event('nonononono') { @a = 'aaaa' ; false }
p @a