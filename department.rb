class Department
  attr_reader :division, :employees, :totals

    def initialize(division)
      @division = division
      @employees = []
      @salaries = []
    end

    def assign_employee(name)
      @employees << name
      # p @employees
    end

    def department_salary(amount)
      @salaries << amount
      @totals = @salaries.reduce(:+)
    end

end
