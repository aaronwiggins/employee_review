class Employee
  attr_accessor :salary
  attr_reader :negative, :positive, :name, :email, :phone_number, :review_text, :review_file, :review_rating
    def initialize(name:, email: "", phone_number: "", salary: 0, review_text: "", review_rating: "")
      @name = name
      @email = email
      @phone_number = phone_number
      @salary = salary
      @review_text = review_text
      @review_file = []
      @review_rating = review_rating
      @negative = /(disagree)|(concerns?)|(tendency)|(issues?)|(sometimes?)|(\W\s?b\But)|(\W\s?b\But)|(D?difficult)|(C?cause)|(S?second)|(less)|(negative)|(consequences?)|(inadequate)|(limitations?)/
      @positive = /(asset)|(pleasure)|(quickly)|(alway?s\swilling)|(H?help\sothers?)|(success?full?y)|([Hh]appy)|([Ww]ill?ing)|([^in]consistent)|([^in][Ee]ffective)|([Ss]atisfied)|(impressed)|(willing)|([Ee]njoy?s)|([Dd]evoted)|([Pp]erfect)/

    end

    def assign(text)
      @review_file << text

    end

    def deserve_raise
      review_words = @review_file.join
      negative_count = review_words.scan(/#{negative}/).count
      positive_count = review_words.scan(/#{positive}/).count
      p negative_count
      p positive_count
      positive_count > negative_count ? true : false
      #   true
      # end

      # review_rating == "good" ? true : false
    end

    def give_raise(percent)
      @salary += percent * @salary
    end
end
