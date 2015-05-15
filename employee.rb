class Employee
  attr_reader :name, :email, :phone_number, :salary, :review_text, :review_file
    def initialize(name:, email: "", phone_number: "", salary: 0, review_text: "")
      @name = name
      @email = email
      @phone_number = phone_number
      @salary = salary
      @review_text = review_text
      @review_file = []
    end

    def assign(text)
      @review_file << text
    end

end
