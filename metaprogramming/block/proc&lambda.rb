inc = Proc.new { |x| x * 10 }
p inc.call(2)
p inc
p inc.class
aa = lambda { |x, y| x + 2 + y }
p aa.call 2, 3 
p aa
p aa.class

p '------------------------------'
def math(a, b)
  yield(a, b)
end

def do_meth(a, b, &operation)
  p operation
  math(a, b, &operation)
end

p do_meth(1, 2, &aa)
p '------------------------------'
def test
  pp = Proc.new { return 10 }
  result = pp.call
  p '-=======-'     # unreachable code
  return result * 2 # unreachable code
end

p test

def test1(callable_object)
  callable_object.call * 2
end

aa = Proc.new { 10 }
p test1(aa)