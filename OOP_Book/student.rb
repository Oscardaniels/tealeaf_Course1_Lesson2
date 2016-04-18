class Student 
  attr_accessor :name
  attr_writer :grade  

  def initialize (n, g)
    self.name = n
    @g = g
  end

  def better_grade_than?(bob_grade)
    return true if bob_grade < get_grade
  end

  private

  def get_grade
    @g
  end
end

joe = Student.new("joe", 90)
bob_grade = 80
puts "Well done!" if joe.better_grade_than?(bob_grade)