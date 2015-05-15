class Employee
  attr_reader :name, :email, :phone_number, :salary, :review_text, :review_file, :review_rating
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
    # def rating
    #   # review_file.empty? ? "bad" : "good"
    #   # rate = review_file.all? {|r| r != []}
    #   # rate ? "good" : "bad"
    #   # if review_file != []
    #   #   return "good"
    #   # else
    #   #   "bad"
    #   # end
    # end

end
