class Employee
  attr_reader :name, :email, :phone_number, :salary

    def initialize(name: "", email: "",
                  phone_number: "", salary: 0)
      @name = name
      @email = email
      @phone_number = phone_number
      @salary = salary
    end
end
