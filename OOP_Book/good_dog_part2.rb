class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def total_number_of_dogs
    @@number_of_dogs
  end
end       

#puts dog1.total_number_of_dogs

dog1 = GoodDog.new
dog2 = GoodDog.new

puts dog2.total_number_of_dogs