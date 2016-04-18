require "pry"

module Towable
  def tow_statement
      "I can tow."
  end
end

class Vehicle
  attr_accessor :current_speed, :status, :color
  attr_reader :year
  @@number_of_objects = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @status = "not running"
    @@number_of_objects += 1
  end

  def speed_up
    self.current_speed += 10
  end

  def brake
    self.current_speed -= 10
  end

  def turn_on
    self.status = "running"
  end

  def shut_off
    self.status = "not running"
  end

  def spray_paint(new_color) 
    self.color = new_color
    "your new vehicle color is #{color}"
  end

  def self.calculate_gas_mileage(miles_driven, gallons_used)
    puts "Your miles per gallon is #{miles_driven / gallons_used} mpg."
  end

  def display_num_of_objects
    puts @@number_of_objects
  end
end

class MyTruck < Vehicle
  CLASSIFICATION = "truck"
  include Towable
  def to_s
    "Your truck is a #{year}, #{color}, #{@model}. Yippee"
  end
end

class MyCar < Vehicle
    CLASSIFICATION = "car"

  def info
    "#{self.year} #{self.color} #{@model}"
  end
  def to_s
    "Your car is a #{year}, #{color}, #{@model}. Yippee"
  end
end


car1 = MyCar.new("2012", "green", "focus")
truck1 = MyTruck.new("22", "white", "tundra")
car1.display_num_of_objects
puts truck1.tow_statement
puts MyTruck.ancestors

puts "What year is your car?"
year = gets.chomp
puts "What color is your car?"
color = gets.chomp
puts "What model is your car?"
model = gets.chomp

oscar_car = MyCar.new(year, color, model)
MyCar.calculate_gas_mileage(20, 10)
puts oscar_car
puts "Your car is currently #{oscar_car.status}"
puts "Would you like to start your car? (y/n)"

if gets.chomp.downcase == "y"
  puts "Your car is now #{oscar_car.turn_on}"
else
  puts "Your car is still #{oscar_car.status}"
end

while oscar_car.status == "running" 
  puts "Your current speed is #{oscar_car.current_speed}"
  puts "Would you like to change colors? If so, what color? or 'n'"
  color_choice = gets.chomp.downcase
  if color_choice != "n"
    oscar_car.spray_paint(color_choice)
  end
  puts "Would you like to 1) accelerate, 2) break, or 3) turn car off?"
  choice = gets.chomp
  if !["1", "2", "3"].include?(choice)
    puts "you must select 1, 2, or 3"
    next
  end

  case choice
    
  when "1" then oscar_car.speed_up
  when "2" then oscar_car.brake
  when "3" 
   puts "Your #{oscar_car.color} car is #{oscar_car.shut_off}"
   exit    
  end
end


