# module A
#   def self.included?(base)
#     base.extend(ClassMethods)
#   end

#   def aa
#     'aa'
#   end
#   module ClassMethods
#     def aa
#       'aa'
#     end
#   end
# end

# module B
#   include A
# end

# class C
#   include B
# end
# p C.new.aa
# p B.ancestors
# p B.singleton_class.ancestors
# p C.ancestors
# p C.singleton_class.ancestors

module A
  def greet
    "Hi #{super}"
  end
end

class B
  include A

  def greet
    "good day!"
  end
end

p B.new.greet