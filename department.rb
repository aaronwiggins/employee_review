class Department
  attr_reader :division, :employees

    def initialize(division)
      @division = division
      @employees = []
    end

    def assign_employee(name)
      #employess are the employee object
      @employees << name
    end

    def department_salaries
      @employees.reduce(0) {|sum, e| e.salary + sum}
    end

    def distribute_raise (amount)
      good_employees = @employees.select {|x| yield (x)}
      good_employees.each { |e| e.salary = e.salary + amount / good_employees.count }
    end

end
