require 'date'
arg = {
  duty: 1,
  agen: 1,
  human_resource: {d: 1 ,a: 2},
  month: Time.now.month
}

def check_and_set_params(args)
  not_null_column = ["duty", "agen", "human_resource", "month"]
  not_null_column.each do |column|
    fail "missing #{column} value" unless arg[column]
  end
end

class ShiftCreator
  def auto_create_shifts(args)
  end
end



class Staff
  attr_accessor :req_off, :name, :position
  def initialize(req_off = [], name, position)
    @req_off = req_off.map{|date| }
    @name = name
    @position = position
  end
end