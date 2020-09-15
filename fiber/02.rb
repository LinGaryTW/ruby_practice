a = Fiber.new do
  puts 'aa'
  Fiber.yield
end
a.resume
puts a
a.resume
puts a