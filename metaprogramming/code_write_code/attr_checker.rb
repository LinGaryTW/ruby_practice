require 'test/unit'
class Object
  def self.attr_checked(attribute, &validation)
    self.class_eval do
      attr_accessor attribute

      define_method("#{attribute}=") do |arg|
        fail 'Invalid attribute' unless arg
        fail 'Invalid attribute' unless validation.call(arg)
        instance_variable_set("@#{attribute}", arg)
      end
    end
  end
end

class Person
  attr_checked :age do |v|
    v >= 18
  end
end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
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