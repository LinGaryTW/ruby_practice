require 'test/unit'

class Person
end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    add_checked_attribute(Person, :age) { |v| v >= 18 }
    @bob = Person.new
  end

  def test_accepts_valid_values
    @bob.age = 20
    assert_equal(20, @bob.age)
  end

  def test_refuce_nil_attribute
    assert_raise RuntimeError, 'Invalid attribute' do
      @bob.age = nil
    end
  end

  def test_refuce_false_attribute
    assert_raise RuntimeError, 'Invalid attribute' do
      @bob.age = false
    end
  end

  def test_refuce_invalid_values
    assert_raise RuntimeError, 'Invalid attribute' do
      @bob.age = 17
    end
  end
end

def add_checked_attribute(class_name, attribute, &validation)
  class_name.class_eval do
    attr_accessor attribute

    define_method("#{attribute}=") do |arg|
      fail 'Invalid attribute' unless arg
      fail 'Invalid attribute' unless validation.call(arg)
      instance_variable_set("@#{attribute}", arg)
    end
  end
end
# module CheckedAttribute
#   def age=()

#   end  
# end

# class Person
#   include CheckedAttribute
#   attr_checked :age do |v|
#     v >= 18
#   end
# end

# me = Person.new
# # me.age = 39
# # me.age = 12