class Employee
  attr_accessor :salary
  attr_reader :name, :email, :phone_number, :review_text, :review_file, :review_rating
    def initialize(name:, email: "", phone_number: "", salary: 0, review_text: "", review_rating: "")
      @name = name
      @email = email
      @phone_number = phone_number
      @salary = salary
      @review_text = review_text
      @review_file = []
      @review_rating = review_rating
    end

    def assign(text)
      @review_file << text
    end

    def deserve_raise
      review_rating == "good" ? true : false
    end

    def give_raise(percent)
      @salary += percent * @salary
    end

end
