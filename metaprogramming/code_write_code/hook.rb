class String
  def self.inherited(subClass)
    puts "#{self} was inherited by #{subClass}"
  end
end

class MyClass < String
end