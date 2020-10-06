class C
  def public_method
    private_method
    p self
  end

  def public_method_2
    public_method
  end

  def self.nonono
    p self
    p 'noonono'
  end

  private
  def private_method
  end
end

module Crefine
  refine C do
    def public_method
      p 'aaaa'
    end
  end
end
using Crefine
C.new.public_method
C.new.public_method_2
C.nonono