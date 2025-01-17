#!/usr/bin/env ruby 

def sum(x,y)
  x + y
end

def substrac(x, y)
  x - y
end

class Calculator
  attr_reader :acc
  attr_writer :function

  def initialize
    @acc = 0
  end

  def run(param1, param2)
    puts "[INFO] function :#{@function}"
    puts "           with : #{param1}, #{param2}"
    @acc = @function.call(param1, param2)
    @acc
  end

end

c = Calculator.new()
c.function = method(:sum)

puts c.run(3, 4)

