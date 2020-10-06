def my_method(a, b)
  result = ''
  result += yield(a, b) if block_given?
  result + 'ccccccccccccc'
end

p my_method(1, 2) { |a, b| "#{a} is a number #{b} is too!!"}
p my_method('a', 'b')