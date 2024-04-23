class Sentimental
    attr_accessor :thresh

    def initialize(thresh: -1.5)
      @thresh = thresh
      @seperators = load_seperators
      @ratings = load_ratings
      @multipliers = load_multipliers
      @concerning_items = load_concerning
    end

    def score_paragraph(string)
        regex = Regexp.union(@seperators)

        sentences = string.split(regex).map {|sentence| sentence.strip}
      
        results = sentences.map {|sentence| score_sentence sentence}

        return results.compact
    end

    def score_sentence(string)
      words = string.split(" ").map {|word| word.downcase}

      score = 0
      words.each_with_index do |word, index|

        if @ratings[word] != nil
          scoretmp = @ratings[word]

          indextmp = index -1
          while (indextmp >=0 && @multipliers[words[indextmp]] != nil)
            scoretmp *= @multipliers[words[indextmp]]
            indextmp -= 1
          end

          score += scoretmp
        end
      end
      if (score < 0)
        words.each do |word|
          if (@concerning_items[word] != nil)
            score *= @concerning_items[word]
          end
        end
      end

      if (score < @thresh)
        return [string, score]
      else
        return nil
      end
    end

    private

    def load_seperators
      file_path = File.expand_path('../data/content_split.txt', __FILE__)
      lines = File.readlines(file_path)
      return lines.map {|line| line.chomp }
    end

    def load_ratings
      file_path = File.expand_path('../data/word_ratings.json', __FILE__)
      content = File.read(file_path)
      return JSON.parse(content)
    end

    def load_multipliers
      file_path = File.expand_path('../data/multipliers.json', __FILE__)
      content = File.read(file_path)
      return JSON.parse(content)
    end

    def load_concerning
      file_path = File.expand_path('../data/concerning_items.json', __FILE__)
      content = File.read(file_path)
      return JSON.parse(content)
    end
end