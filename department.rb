class Department
  attr_reader :division, :employees

    def initialize(division)
      @division = division
      @employees = []
      @salaries = []
    end

    def assign_employee(name)
      ##employess are the employee object
      @employees << name
    end

    def department_salaries
      @employees.reduce(0) {|sum, e| e.salary + sum}
      # @salaries_in_department = @employees.map {|e| e.salary}
      # @salaries_in_department.reduce(:+)
    end

    def distribute_raise(amount)
      good_employees = @employees.select {|r| r.review_rating == "good"}
      good_employees.each { |e| e.salary = e.salary + amount / good_employees.count }

    end
end


# class Array
#   def translate
#     new_array = []
#     self.each do |item|
#       new_array << yield(item)
#     end
#     new_array
#   end
# end
#
# var = ["Dog", "Perro", "Hund"].translate do |word|
#   word.upcase
# end
