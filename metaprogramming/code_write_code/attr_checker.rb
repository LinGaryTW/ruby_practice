module CheckedAttribute
  def age=()

  end  
end

class Person
  include CheckedAttribute
  attr_checked :age do |v|
    v >= 18
  end
end

me = Person.new
# me.age = 39
# me.age = 12