class Sensitivity

    attr_accessor :none
    
    def initialize

    end
    
    def load_sensitive_words_list
        file_path = File.expand_path('../sensitive_words_list.txt', __FILE__)
        lines = File.readlines(file_path)
        return lines.map {|line| line.chomp }
    end

    def detect_sensitive_words(answer)
        sensitive_words = load_sensitive_words_list()
        detected = []
        sensitive_words.each do |word|
            if (answer.include?(word)) # check the answer for sensitive words
                detected << "The word '#{word}' has been detected in this answer"
            end
        end
        # return detected words array
        detected
    end
end