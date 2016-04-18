
# class Person 
#   attr_accessor :name, :age

#   def initialize(n, a)
#     self.name = n
#     self.age  = a
#   end

#   def to_s
#     "#{name} is #{age} years old."
#   end
# end

# steve = Person.new("Steve", "32")

# puts steve

# class MyCar 
#   attr_accessor :current_speed, :status, :color, :year, :model


#   def initialize(year, color, model)
#     self.year = year
#     self.color = color
#     self.model = model
#     self.current_speed = 0
#     self.status = "not running"
#   end

#   def to_s
#      puts "Your car is a #{year}, #{color}, #{model}. Yippee"
#   end

# end

# oscar_car = MyCar.new("2203", "red", "subaru")

# puts oscar_car
require "pry"
class KrispyKreme
  attr_accessor :filling_type, :glazing

  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    binding.pry
    return_string = @filling_type ? @filling_type : "Plain"
    return_string += " with " + @glazing if @glazing
    return_string
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
puts donut2
puts donut3
puts donut4
puts donut5