class Department
  attr_reader :division, :employees

    def initialize(division)
      @division = division
      @employees = []
    end

    def assign_employee(name)
      @employees << name
    end

end
