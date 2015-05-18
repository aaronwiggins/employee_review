class Employee
  attr_accessor :salary
  attr_reader :review_word_count, :positive_count, :negative, :positive, :name,
              :email, :phone_number, :review_text, :review_file, :review_rating
    def initialize(name:, email: "", phone_number: "", salary: 0, review_text: "", review_rating: "")
      @name = name
      @email = email
      @phone_number = phone_number
      @salary = salary
      @review_text = review_text
      @review_file = []
      @review_rating = review_rating
      @negative = %r/(N?needs\s\w+\simprove\w+)|(N?need?s\s\w+\swork)|(disagree)|
      (concerns?)|(tendency)|(issues?)|(sometimes?)|(\W\s?b\But)|(D?difficult)|
      (C?cause)|(S?second)|(less)|(negative)|(consequences?)|(inadequate)|
      (limitations?)|(R?require?s.more)/x
      @positive = %r/(I?is\sS?significant\w+\sbetter)|(S?significant?(ly))|
      (V?value?d)|(asset)|(pleasure)|(quickly)|(alway?s\swilling)|(count.on)|
      (H?help\sothers?)|(success?full?y)|([Hh]appy)|([Ww]ill?ing)|
      ([^in]consistent)|([^in][Ee]ffective)|([Ss]atisfied)|(impressed)|(willing)|
      ([Ee]njoy?s)|([Dd]evoted)|([Pp]erfect)|(O?outstanding)|(Q?quick\w+)|(G?good)/x
    end

    def assign(text)
      @review_file << text

    end

    def deserve_raise
      review_words = @review_file.join
      @review_word_count = review_words.split.count

      negative_count = review_words.scan(/#{negative}/).count
      @positive_count = review_words.scan(/#{positive}/).count
      positive_count > negative_count ? true : false
    end

    def give_raise(percent)
      @salary += percent * @salary
    end

    def determine_review_score
      deserve_raise ?
      ((@positive_count.to_f / @review_word_count.to_f) * 100).round(2) : false
    end
end
