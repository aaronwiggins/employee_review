class Employee
  attr_reader :name, :email, :phone_number, :salary

    def initialize(name:, email: "blank@email.com",
                  phone_number: "9191234567", salary: "50000")
      @name = name
      @email = email
      @phone_number = phone_number
      @salary = salary
    end
end
